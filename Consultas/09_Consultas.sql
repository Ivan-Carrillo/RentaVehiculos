-- Inserta un nuevo usuario con todos sus datos.
INSERT INTO Usuario (id_usuario, nombre, apellido, email, contrasenia, telefono, rol, numero_licencia, fecha_vencimiento_licencia) 
VALUES (6, 'Roberto', 'Gómez', 'roberto.gomez@email.com', 'hashPass2026', '988776655', 'Cliente', 'Q-99887766', '2028-12-31');

-- Inserta un nuevo vehículo asociado a relaciones ya existentes. (id_categoria=2 SUV, id_sede=1 Lima, id_modelo=4 Tucson, id_estado_vehiculo=1 Disponible)
INSERT INTO Vehiculo (id_vehiculo, placa, anio, km_actual, id_categoria, id_sede, id_modelo, id_estado_vehiculo) 
VALUES (7, 'GHI-789', 2024, 500, 2, 1, 4, 1);

-- Actualiza el estado de un vehículo específico cambiando de 'Disponible' (1) a 'En Mantenimiento' (3).

UPDATE Vehiculo
SET id_estado_vehiculo = 3
WHERE id_vehiculo = 1;

-- Registra manualmente el evento en Estado_Historial correspondiente al cambio de estado anterior.

INSERT INTO Estado_Historial (id_historial, id_vehiculo, fecha_evento, estado_anterior, estado_nuevo, motivo) 
VALUES (4, 1, GETDATE(), 'Disponible', 'En Mantenimiento', 'Revisión periódica de frenos y cambio de aceite');

-- Actualiza el km_retorno y la sede de devolución de un contrato activo (id_contrato = 202) cuando el vehículo es devuelto.

UPDATE Contrato
SET km_retorno = 9200, id_sede_devolucion = 2, id_estado_contrato = 2            
WHERE id_contrato = 202;

-- Elimina una reserva en estado 'Cancelada' (id_estado_reserva = 4) y que no tenga ningún contrato asociado.

DELETE FROM Reserva
WHERE id_estado_reserva = 4
  AND id_reserva NOT IN (
      SELECT id_reserva 
      FROM Contrato 
      WHERE id_reserva IS NOT NULL
);