-- Lista todas las reservas cuya fecha_inicio caiga dentro del mes y año actual.

SELECT id_reserva, fecha_inicio, fecha_fin, id_usuario, id_vehiculo
FROM Reserva
WHERE MONTH(fecha_inicio) = MONTH(GETDATE())
  AND YEAR(fecha_inicio)  = YEAR(GETDATE());

-- Encuentra los contratos que aún no tienen kilometraje de devolución registrado.

SELECT id_contrato, fecha_emision, km_salida, id_reserva, id_sede_recogida
FROM Contrato
WHERE km_retorno IS NULL;

-- Calcula cuántos días de retraso tiene un contrato aún abierto comparando la fecha_fin pactada en la reserva contra la fecha actual.

SELECT  c.id_contrato, r.id_reserva, r.fecha_fin AS fecha_fin_programada, GETDATE() AS fecha_actual,
    DATEDIFF(day, r.fecha_fin, GETDATE()) AS dias_de_retraso
FROM Contrato c
INNER JOIN Reserva r ON c.id_reserva = r.id_reserva
WHERE c.km_retorno IS NULL
  AND r.fecha_fin < GETDATE(); -- Solo muestra los que ya vencieron

-- Muestra los pagos realizados en los últimos 7 días a partir de hoy.

SELECT id_pago, fecha_pago, monto_total, id_contrato, id_metodo_pago
FROM Pago
WHERE fecha_pago >= DATEADD(day, -7, GETDATE());

-- Lista los vehículos que tuvieron un cambio de estado en el último mes.

SELECT v.id_vehiculo, v.placa, eh.fecha_evento, eh.estado_anterior, eh.estado_nuevo, eh.motivo
FROM Vehiculo v
INNER JOIN Estado_Historial eh ON v.id_vehiculo = eh.id_vehiculo
WHERE eh.fecha_evento >= DATEADD(month, -1, GETDATE());