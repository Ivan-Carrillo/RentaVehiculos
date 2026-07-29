
-- Muestra el nombre, apellido y correo de todos los usuarios registrados.
SELECT nombre, apellido, email 
FROM Usuario;

-- Lista todos los vehículos con año de fabricación posterior a 2020.
SELECT * FROM Vehiculo 
WHERE anio > 2020;

-- Obtén los datos de todas las sedes ubicadas en una ciudad específica (ejemplo: 'Lima').
SELECT * FROM Sede 
WHERE ciudad = 'Lima';

-- Encuentra todos los usuarios cuyo rol sea 'Cliente', ordenados alfabéticamente por apellido.
SELECT * FROM Usuario 
WHERE rol = 'Cliente' 
ORDER BY apellido ASC;

-- Muestra los vehículos cuya placa comience con una letra específica (ejemplo: 'A').
SELECT * FROM Vehiculo 
WHERE placa LIKE 'A%';

-- Lista los servicios adicionales cuyo precio unitario sea mayor a 15.00, ordenados de mayor a menor precio.
SELECT * FROM Servicio 
WHERE precio_unitario > 15.00 
ORDER BY precio_unitario DESC;

-- Encuentra los usuarios cuya licencia de conducir vence en los próximos 30 días.
SELECT * FROM Usuario 
WHERE fecha_vencimiento_licencia BETWEEN GETDATE() AND DATEADD(day, 30, GETDATE());