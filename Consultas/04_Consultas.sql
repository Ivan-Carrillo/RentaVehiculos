-- 1. Muestra los vehículos cuya tarifa de categoría esté por encima  del promedio de todas las categorías.

SELECT v.id_vehiculo, v.placa, c.nombre AS categoria, c.tarifa_dia
FROM Vehiculo v
INNER JOIN Categoria c ON v.id_categoria = c.id_categoria
WHERE c.tarifa_dia > (
    SELECT AVG(tarifa_dia) 
    FROM Categoria
);

-- 2. Lista los usuarios que nunca han hecho una reserva.

SELECT id_usuario, nombre, apellido, email
FROM Usuario
WHERE id_usuario NOT IN (
    SELECT DISTINCT id_usuario 
    FROM Reserva
);

-- 3. Encuentra el vehículo (o vehículos) con mayor kilometraje registrado, usando una subconsulta.

SELECT v.id_vehiculo, v.placa, v.km_actual, m.nombre AS marca, mo.nombre AS modelo
FROM Vehiculo v
INNER JOIN Modelo mo ON v.id_modelo = mo.id_modelo
INNER JOIN Marca m ON mo.id_marca = m.id_marca
WHERE v.km_actual = (
    SELECT MAX(km_actual) 
    FROM Vehiculo
);

-- 4. Muestra los contratos cuyo monto total pagado sea mayor al monto promedio de todos los pagos.

SELECT c.id_contrato, c.fecha_emision, p.monto_total
FROM Contrato c
INNER JOIN Pago p ON c.id_contrato = p.id_contrato
WHERE p.monto_total > (
    SELECT AVG(monto_total) 
    FROM Pago
);

-- 5. Lista las sedes que no tienen ningún vehículo asignado actualmente.

SELECT id_sede, ciudad, direccion
FROM Sede s
WHERE NOT EXISTS (
    SELECT 1 
    FROM Vehiculo v 
    WHERE v.id_sede = s.id_sede
);

-- 6. Encuentra los servicios adicionales que nunca han sido solicitados en ninguna reserva.

SELECT id_servicio, nombre_servicio, precio_unitario
FROM Servicio
WHERE id_servicio NOT IN (
    SELECT DISTINCT id_servicio 
    FROM Reserva_Servicio
);