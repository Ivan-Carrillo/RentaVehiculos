-- 1. Usa EXISTS para listar los usuarios que sí tienen al menos una reserva registrada.

SELECT u.id_usuario, u.nombre, u.apellido, u.email
FROM Usuario u
WHERE EXISTS (
    SELECT 1 
    FROM Reserva r 
    WHERE r.id_usuario = u.id_usuario
);

-- 2. Usa NOT EXISTS para listar los vehículos que nunca han tenido un contrato asociado. (Conecta Vehiculo -> Reserva -> Contrato)
SELECT v.id_vehiculo, v.placa, v.anio
FROM Vehiculo v
WHERE NOT EXISTS (
    SELECT 1 
    FROM Reserva r
    INNER JOIN Contrato c ON r.id_reserva = c.id_reserva
    WHERE r.id_vehiculo = v.id_vehiculo
);

-- 3. Escribe una subconsulta correlacionada que muestre, por cada vehículo, la fecha de su último evento en Estado_Historial.
SELECT v.id_vehiculo, v.placa,
    (
        SELECT MAX(eh.fecha_evento)
        FROM Estado_Historial eh
        WHERE eh.id_vehiculo = v.id_vehiculo
    ) AS fecha_ultimo_evento
FROM Vehiculo v;

-- 4. Usa una subconsulta con IN para listar los pagos cuyo id_contrato pertenezca a contratos con sede de devolución distinta a la de recogida.
SELECT p.id_pago, p.fecha_pago, p.monto_total, p.id_contrato
FROM Pago p
WHERE p.id_contrato IN (
    SELECT c.id_contrato
    FROM Contrato c
    WHERE c.id_sede_devolucion IS NOT NULL 
      AND c.id_sede_recogida <> c.id_sede_devolucion
);

-- 5. Usa ANY o ALL para encontrar las categorías cuya tarifa_dia sea mayor a la de TODAS las categorías que contienen la palabra 'Económico'.
SELECT c.id_categoria, c.nombre AS categoria, c.tarifa_dia
FROM Categoria c
WHERE c.tarifa_dia > ALL (
    SELECT c_sub.tarifa_dia
    FROM Categoria c_sub
    WHERE c_sub.nombre LIKE '%Económico%'
);

-- 6. Construye una subconsulta en el FROM que calcule el total pagado por contrato, y luego únela con Contrato para mostrar el contrato junto a su total.
SELECT c.id_contrato, c.fecha_emision, totales.total_pagado
FROM Contrato c
INNER JOIN (
    SELECT 
        id_contrato, 
        SUM(monto_total) AS total_pagado
    FROM Pago
    GROUP BY id_contrato
) totales ON c.id_contrato = totales.id_contrato;

-- 7. Encuentra, para cada usuario, cuál fue su reserva más reciente usando una subconsulta correlacionada con MAX(fecha_inicio).
SELECT u.id_usuario, CONCAT(u.nombre, ' ', u.apellido) AS usuario, r.id_reserva, r.fecha_inicio AS fecha_reserva_mas_reciente
FROM Usuario u
INNER JOIN Reserva r ON u.id_usuario = r.id_usuario
WHERE r.fecha_inicio = (
    SELECT MAX(r_sub.fecha_inicio)
    FROM Reserva r_sub
    WHERE r_sub.id_usuario = u.id_usuario
);