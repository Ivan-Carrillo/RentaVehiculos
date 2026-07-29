-- Calcula el ingreso total generado (suma de monto_total) por cada sede, considerando la sede de recogida del contrato.

CREATE FUNCTION dbo.fn_IngresoTotalPorSede()
RETURNS TABLE
AS
RETURN
(
    SELECT 
        s.ciudad AS sede_recogida,
        CASE 
            WHEN SUM(p.monto_total) IS NULL THEN 0 
            ELSE SUM(p.monto_total) 
        END AS ingreso_total
    FROM Sede s
    INNER JOIN Contrato c ON s.id_sede = c.id_sede_recogida
    INNER JOIN Pago p ON c.id_contrato = p.id_contrato
    GROUP BY s.id_sede, s.ciudad
);
GO

-- Cuenta cuántos vehículos hay registrados por cada categoría.

CREATE FUNCTION dbo.fn_VehiculosPorCategoria()
RETURNS TABLE
AS
RETURN
(
    SELECT c.nombre AS categoria, COUNT(v.id_vehiculo) AS total_vehiculos
    FROM Categoria c
    LEFT JOIN Vehiculo v ON c.id_categoria = v.id_categoria
    GROUP BY c.id_categoria, c.nombre
);
GO

-- Calcula el promedio de kilómetros recorridos (km_actual) por marca de vehículo.

CREATE FUNCTION dbo.fn_PromedioKmPorMarca()
RETURNS TABLE
AS
RETURN
(
    SELECT m.nombre AS marca, AVG(v.km_actual) AS promedio_kilometraje
    FROM Marca m
    INNER JOIN Modelo mo ON m.id_marca = mo.id_marca
    INNER JOIN Vehiculo v ON mo.id_modelo = v.id_modelo
    GROUP BY m.id_marca, m.nombre
);
GO

-- Encuentra las 5 categorías de vehículo con mayor tarifa por día.

CREATE FUNCTION dbo.fn_Top5CategoriasMasCaras()
RETURNS TABLE
AS
RETURN
(
    SELECT c1.nombre AS categoria, c1.tarifa_dia
    FROM Categoria c1
    WHERE (
        SELECT COUNT(*) 
        FROM Categoria c2 
        WHERE c2.tarifa_dia >= c1.tarifa_dia
    ) <= 5
);
GO

-- Cuenta cuántas reservas ha hecho cada usuario, mostrando solo a los que tienen más de una reserva (usa HAVING).

CREATE FUNCTION dbo.fn_UsuariosConMasDeUnaReserva()
RETURNS TABLE
AS
RETURN
(
    SELECT u.id_usuario, CONCAT(u.nombre, ' ', u.apellido) AS usuario, COUNT(r.id_reserva) AS total_reservas
    FROM Usuario u
    INNER JOIN Reserva r ON u.id_usuario = r.id_usuario
    GROUP BY u.id_usuario, u.nombre, u.apellido
    HAVING COUNT(r.id_reserva) > 1
);
GO

-- Calcula el ingreso total por método de pago.

CREATE FUNCTION dbo.fn_IngresoPorMetodoPago()
RETURNS TABLE
AS
RETURN
(
    SELECT mp.descripcion AS metodo_pago, SUM(p.monto_total) AS ingreso_total
    FROM Metodo_Pago mp
    INNER JOIN Pago p ON mp.id_metodo_pago = p.id_metodo_pago
    GROUP BY mp.id_metodo_pago, mp.descripcion
);
GO

-- Determina cuál es el vehículo con más reservas registradas.

CREATE FUNCTION dbo.fn_VehiculoConMasReservas()
RETURNS TABLE
AS
RETURN
(
    SELECT v.id_vehiculo, v.placa, m.nombre AS marca, mo.nombre AS modelo, COUNT(r.id_reserva) AS total_reservas
    FROM Vehiculo v
    INNER JOIN Modelo mo ON v.id_modelo = mo.id_modelo
    INNER JOIN Marca m ON mo.id_marca = m.id_marca
    LEFT JOIN Reserva r ON v.id_vehiculo = r.id_vehiculo
    GROUP BY v.id_vehiculo, v.placa, m.nombre, mo.nombre
    HAVING COUNT(r.id_reserva) = (
        SELECT MAX(total_res.cantidad)
        FROM (
            SELECT COUNT(id_reserva) AS cantidad
            FROM Vehiculo v2
            LEFT JOIN Reserva r2 ON v2.id_vehiculo = r2.id_vehiculo
            GROUP BY v2.id_vehiculo
        ) total_res
    )
);
GO

--  Calcula el promedio de duración (en días) de los contratos, usando fecha_emision y las fechas de la reserva asociada.

CREATE FUNCTION dbo.fn_PromedioDiasAlquiler()
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @promedio DECIMAL(10, 2);

    SELECT @promedio = AVG(CAST(CAST(r.fecha_fin AS DATE) - CAST(r.fecha_inicio AS DATE) AS DECIMAL(10,2)))
    FROM Contrato c
    INNER JOIN Reserva r ON c.id_reserva = r.id_reserva;

    RETURN @promedio;
END;
GO