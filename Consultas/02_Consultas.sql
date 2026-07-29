-- Muestra cada vehículo junto con el nombre de su marca y modelo.

SELECT v.id_vehiculo, v.placa, m.nombre AS marca, mo.nombre AS modelo
FROM Vehiculo v
INNER JOIN Modelo mo 
ON v.id_modelo = mo.id_modelo
INNER JOIN Marca m 
ON mo.id_marca = m.id_marca;

-- Lista cada vehículo junto con el nombre de la categoría a la que pertenece y su tarifa por día.

SELECT v.id_vehiculo, v.placa, c.nombre AS categoria, c.tarifa_dia
FROM Vehiculo v
INNER JOIN Categoria c ON v.id_categoria = c.id_categoria;

-- Muestra cada reserva junto con el nombre completo del usuario que la hizo y la placa del vehículo reservado.

SELECT r.id_reserva, r.fecha_inicio, r.fecha_fin, CONCAT(u.nombre, ' ', u.apellido) AS nombre_usuario, v.placa
FROM Reserva r
INNER JOIN Usuario u ON r.id_usuario = u.id_usuario
INNER JOIN Vehiculo v ON r.id_vehiculo = v.id_vehiculo;

-- Lista cada contrato junto con la ciudad de la sede de recogida y la ciudad de la sede de devolución.

SELECT c.id_contrato, c.fecha_emision, sr.ciudad AS sede_recogida, sd.ciudad AS sede_devolucion
FROM Contrato c
INNER JOIN Sede sr ON c.id_sede_recogida = sr.id_sede
LEFT JOIN Sede sd ON c.id_sede_devolucion = sd.id_sede;

-- Muestra cada pago junto con el nombre del método de pago utilizado y la fecha de emisión del contrato asociado.

SELECT p.id_pago, p.monto_total, p.fecha_pago, mp.descripcion AS metodo_pago, c.fecha_emision AS fecha_emision_contrato
FROM Pago p
INNER JOIN Metodo_Pago mp ON p.id_metodo_pago = mp.id_metodo_pago
INNER JOIN Contrato c ON p.id_contrato = c.id_contrato;

-- Lista cada reserva junto con los servicios adicionales incluidos (si los hay) y su subtotal.

SELECT  r.id_reserva, s.nombre_servicio, rs.cantidad, rs.subtotal
FROM Reserva r
LEFT JOIN Reserva_Servicio rs ON r.id_reserva = rs.id_reserva
LEFT JOIN Servicio s ON rs.id_servicio = s.id_servicio;

-- Muestra el historial de estados de un vehículo específico (ejemplo: id_vehiculo = 4) junto con su placa y modelo.

SELECT eh.id_historial, v.placa, mo.nombre AS modelo, eh.fecha_evento, eh.estado_anterior, eh.estado_nuevo, eh.motivo
FROM Estado_Historial eh
INNER JOIN Vehiculo v ON eh.id_vehiculo = v.id_vehiculo
INNER JOIN Modelo mo ON v.id_modelo = mo.id_modelo
WHERE v.id_vehiculo = 4;

-- Lista todos los contratos junto con el estado actual del vehículo que fue rentado.

SELECT c.id_contrato, c.fecha_emision, v.placa, ev.descripcion AS estado_actual_vehiculo
FROM Contrato c
INNER JOIN Reserva r ON c.id_reserva = r.id_reserva
INNER JOIN Vehiculo v ON r.id_vehiculo = v.id_vehiculo
INNER JOIN Estado_Vehiculo ev ON v.id_estado_vehiculo = ev.id_estado_vehiculo;