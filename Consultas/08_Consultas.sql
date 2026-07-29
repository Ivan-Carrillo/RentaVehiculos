-- Genera un listado con: nombre del cliente, placa del vehículo fecha de inicio y fin de la reserva, y el monto total pagado.
SELECT 
    CONCAT(u.nombre, ' ', u.apellido) AS cliente,
    v.placa,
    r.fecha_inicio,
    r.fecha_fin,
    ISNULL(p.monto_total, 0) AS monto_total_pagado
FROM Reserva r
INNER JOIN Usuario u ON r.id_usuario = u.id_usuario
INNER JOIN Vehiculo v ON r.id_vehiculo = v.id_vehiculo
LEFT JOIN Contrato c ON r.id_reserva = c.id_reserva
LEFT JOIN Pago p ON c.id_contrato = p.id_contrato;

-- Muestra el top 3 de vehículos más rentables.

SELECT TOP 3
    v.id_vehiculo,
    v.placa,
    m.nombre AS marca,
    mo.nombre AS modelo,
    SUM(p.monto_total) AS ingresos_totales
FROM Vehiculo v
INNER JOIN Modelo mo ON v.id_modelo = mo.id_modelo
INNER JOIN Marca m ON mo.id_marca = m.id_marca
INNER JOIN Reserva r ON v.id_vehiculo = r.id_vehiculo
INNER JOIN Contrato c ON r.id_reserva = c.id_reserva
INNER JOIN Pago p ON c.id_contrato = p.id_contrato
GROUP BY v.id_vehiculo, v.placa, m.nombre, mo.nombre
ORDER BY ingresos_totales DESC;

-- Lista los vehículos actualmente disponibles junto con su sede, categoría y tarifa diaria.

SELECT 
    v.id_vehiculo,
    v.placa,
    s.ciudad AS sede,
    c.nombre AS categoria,
    c.tarifa_dia
FROM Vehiculo v
INNER JOIN Estado_Vehiculo ev ON v.id_estado_vehiculo = ev.id_estado_vehiculo
INNER JOIN Sede s ON v.id_sede = s.id_sede
INNER JOIN Categoria c ON v.id_categoria = c.id_categoria
WHERE ev.descripcion = 'Disponible';

-- Encuentra los clientes que han usado más de un método de pago distinto.

SELECT 
    u.id_usuario,
    CONCAT(u.nombre, ' ', u.apellido) AS cliente,
    COUNT(DISTINCT p.id_metodo_pago) AS metodos_pago_distintos
FROM Usuario u
INNER JOIN Reserva r ON u.id_usuario = r.id_usuario
INNER JOIN Contrato c ON r.id_reserva = c.id_reserva
INNER JOIN Pago p ON c.id_contrato = p.id_contrato
GROUP BY u.id_usuario, u.nombre, u.apellido
HAVING COUNT(DISTINCT p.id_metodo_pago) > 1;

-- Calcula el porcentaje de contratos que fueron devueltos en una sede distinta a la de recogida.

SELECT 
    COUNT(*) AS total_contratos_con_devolucion,
    SUM(CASE WHEN id_sede_recogida <> id_sede_devolucion THEN 1 ELSE 0 END) AS devueltos_otra_sede,
    CAST(
        (SUM(CASE WHEN id_sede_recogida <> id_sede_devolucion THEN 1.0 ELSE 0 END) / COUNT(*)) * 100 
        AS DECIMAL(5,2)
    ) AS porcentaje_otra_sede
FROM Contrato
WHERE id_sede_devolucion IS NOT NULL;

-- Muestra un resumen por categoría de vehículo: cantidad de vehículos, cantidad de reservas y promedio de tarifa diaria.

SELECT 
    c.nombre AS categoria,
    COUNT(DISTINCT v.id_vehiculo) AS total_vehiculos,
    COUNT(r.id_reserva) AS total_reservas,
    AVG(c.tarifa_dia) AS promedio_tarifa_dia
FROM Categoria c
LEFT JOIN Vehiculo v ON c.id_categoria = v.id_categoria
LEFT JOIN Reserva r ON v.id_vehiculo = r.id_vehiculo
GROUP BY c.id_categoria, c.nombre;