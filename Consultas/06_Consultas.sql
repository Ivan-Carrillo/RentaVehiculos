-- Obtener usuarios con nombre completo concatenado

CREATE FUNCTION dbo.fn_ObtenerUsuariosNombreCompleto()
RETURNS TABLE
AS
RETURN
(
    SELECT id_usuario, CONCAT(nombre, ' ', apellido) AS nombre_completo, email
    FROM Usuario
);
GO

-- Sedes en mayúscula y emails en minúscula

CREATE FUNCTION dbo.fn_ObtenerSedesMayuscula()
RETURNS TABLE
AS
RETURN
(
    SELECT UPPER(ciudad) AS ciudad_mayuscula, direccion
    FROM Sede
);
GO

CREATE FUNCTION dbo.fn_ObtenerUsuariosEmailMinuscula()
RETURNS TABLE
AS
RETURN
(
    SELECT LOWER(email) AS email_minuscula, nombre, apellido
    FROM Usuario
);
GO

-- Vehículos con placa de longitud mayor a un parámetro

CREATE FUNCTION dbo.fn_VehiculosPlacaLarga(@longitudMinima INT)
RETURNS TABLE
AS
RETURN
(
    SELECT id_vehiculo, placa, LEN(placa) AS longitud_placa
    FROM Vehiculo
    WHERE LEN(placa) > @longitudMinima
);
GO

-- Pagos con monto redondeado

CREATE FUNCTION dbo.fn_ObtenerPagosRedondeados()
RETURNS TABLE
AS
RETURN
(
    SELECT id_pago, monto_total AS monto_original, ROUND(monto_total, 1) AS monto_redondeado
    FROM Pago
);
GO

-- Días de alquiler por contrato finalizado

CREATE FUNCTION dbo.fn_DiasAlquilerPorContrato()
RETURNS TABLE
AS
RETURN
(
    SELECT c.id_contrato, c.fecha_emision, r.fecha_inicio, r.fecha_fin,
        CAST(CAST(r.fecha_fin AS DATE) - CAST(r.fecha_inicio AS DATE) AS INT) AS dias_alquiler
    FROM Contrato c
    INNER JOIN Reserva r ON c.id_reserva = r.id_reserva
    WHERE c.id_estado_contrato = 2
);
GO

-- Conteo de reservas por año y mes

CREATE FUNCTION dbo.fn_ReservasPorMes()
RETURNS TABLE
AS
RETURN
(
    SELECT YEAR(fecha_inicio) AS anio, MONTH(fecha_inicio) AS mes, COUNT(id_reserva) AS total_reservas
    FROM Reserva
    GROUP BY YEAR(fecha_inicio), MONTH(fecha_inicio)
);
GO

-- Clasificación de antigüedad de vehículos

CREATE FUNCTION dbo.fn_ClasificacionAntiguedadVehiculos()
RETURNS TABLE
AS
RETURN
(
    SELECT id_vehiculo, placa, anio,
        CASE 
            WHEN anio >= 2023 THEN 'Nuevo'
            WHEN anio BETWEEN 2018 AND 2022 THEN 'Reciente'
            ELSE 'Antiguo'
        END AS clasificacion_antiguedad
    FROM Vehiculo
);
GO

-- Estado de pago por contrato 

CREATE FUNCTION dbo.fn_EstadoPagoPorContrato()
RETURNS TABLE
AS
RETURN
(
    SELECT c.id_contrato, c.fecha_emision,
        CASE 
            WHEN p.id_pago IS NOT NULL THEN 'Pagado'
            ELSE 'Pendiente'
        END AS estado_pago
    FROM Contrato c
    LEFT JOIN Pago p ON c.id_contrato = p.id_contrato
);
GO

-- Estado del km de retorno 

CREATE FUNCTION dbo.fn_EstadoKmRetornoContratos()
RETURNS TABLE
AS
RETURN
(
    SELECT id_contrato, km_salida, COALESCE(CAST(km_retorno AS VARCHAR(20)), 'Aún no devuelto') AS estado_km_retorno
    FROM Contrato
);
GO

-- Numeración secuencial de reservas por usuario

CREATE FUNCTION dbo.fn_NumeracionReservasPorUsuario()
RETURNS TABLE
AS
RETURN
(
    SELECT r.id_reserva, r.id_usuario, CONCAT(u.nombre, ' ', u.apellido) AS usuario, r.fecha_inicio, ROW_NUMBER() OVER (
            PARTITION BY r.id_usuario 
            ORDER BY r.fecha_inicio ASC
        ) AS numero_reserva_usuario
    FROM Reserva r
    INNER JOIN Usuario u ON r.id_usuario = u.id_usuario
);
GO

-- Vehículo con mayor kilometraje por categoría

CREATE FUNCTION dbo.fn_VehiculoMayorKmPorCategoria()
RETURNS TABLE
AS
RETURN
(
    WITH VehiculosRankeados AS (
        SELECT v.id_vehiculo, v.placa, v.km_actual, c.nombre AS categoria,
            RANK() OVER (
                PARTITION BY v.id_categoria 
                ORDER BY v.km_actual DESC
            ) AS ranking_kilometraje
        FROM Vehiculo v
        INNER JOIN Categoria c ON v.id_categoria = c.id_categoria
    )
    SELECT id_vehiculo, placa, categoria, km_actual
    FROM VehiculosRankeados
    WHERE ranking_kilometraje = 1
);
GO