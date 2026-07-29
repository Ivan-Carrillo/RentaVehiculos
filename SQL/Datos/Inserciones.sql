-- Categoria
INSERT INTO Categoria (id_categoria, nombre, tarifa_dia) VALUES 
(1, 'Económico', 35.00),
(2, 'Camioneta', 75.00),
(3, 'Premium', 120.00),
(4, 'Furgoneta', 90.00);

-- Marca
INSERT INTO Marca (id_marca, nombre) VALUES 
(1, 'Toyota'),
(2, 'Hyundai'),
(3, 'BMW'),
(4, 'Nissan');

-- Modelo
INSERT INTO Modelo (id_modelo, nombre, id_marca) VALUES 
(1, 'Yaris', 1),
(2, 'RAV4', 1),
(3, 'Accent', 2),
(4, 'Tucson', 2),
(5, 'Serie 3', 3),
(6, 'X5', 3),
(7, 'Versa', 4);

-- Sede
INSERT INTO Sede (id_sede, ciudad, direccion, telefono_sede) VALUES 
(1, 'Lima', 'Av. Javier Prado Este 1234, San Isidro', '+51 134 445 122'),
(2, 'Arequipa', 'Av. Ejército 567, Yanahuara', '+51 545 232 344'),
(3, 'Cusco', 'Av. El Sol 890, Centro Histórico', '+51 847 256 689');

-- Estado_Vehiculo
INSERT INTO Estado_Vehiculo (id_estado_vehiculo, descripcion) VALUES 
(1, 'Disponible'),
(2, 'Alquilado'),
(3, 'En Mantenimiento'),
(4, 'Fuera de Servicio');

-- Estado_Reserva
INSERT INTO Estado_Reserva (id_estado_reserva, descripcion) VALUES 
(1, 'Pendiente'),
(2, 'Confirmada'),
(3, 'Completada'),
(4, 'Cancelada');

-- Estado_Contrato
INSERT INTO Estado_Contrato (id_estado_contrato, descripcion) VALUES 
(1, 'Activo'),
(2, 'Finalizado'),
(3, 'Anulado');

-- Metodo_Pago
INSERT INTO Metodo_Pago (id_metodo_pago, descripcion) VALUES 
(1, 'Tarjeta de Crédito'),
(2, 'Tarjeta de Débito'),
(3, 'Transferencia Bancaria'),
(4, 'Efectivo');

-- Servicio
INSERT INTO Servicio (id_servicio, nombre_servicio, precio_unitario) VALUES 
(1, 'Silla de Bebe', 15.00),
(2, 'GPS Navegador', 10.00),
(3, 'Conductor Adicional', 25.00),
(4, 'Cobertura Total de Seguro', 40.00);

-- Usuario
INSERT INTO Usuario (id_usuario, nombre, apellido, email, contrasenia, telefono, rol, numero_licencia, fecha_vencimiento_licencia) VALUES 
(1, 'Carlos', 'Mendoza', 'carlos.mendoza@email.com', 'pass123hash', '987654321', 'Cliente', 'Q-12345678', '2028-10-15'),
(2, 'Ana', 'García', 'ana.garcia@email.com', 'pass456hash', '912345678', 'Cliente', 'Q-87654321', '2027-05-20'),
(3, 'Luis', 'Torres', 'luis.torres@email.com', 'pass789hash', '955443322', 'Cliente', 'Q-55667788', '2025-12-01'), -- Licencia vencida
(4, 'Maria', 'Rojas', 'maria.rojas@email.com', 'pass321hash', '944332211', 'Cliente', 'Q-11223344', '2029-08-10'),
(5, 'Admin', 'Sistema', 'admin@rentacar.com', 'adminpasshash', '900000000', 'Administrador', 'Q-00000000', '2030-01-01');

-- Vehiculo
INSERT INTO Vehiculo (id_vehiculo, placa, anio, km_actual, id_categoria, id_sede, id_modelo, id_estado_vehiculo) VALUES 
(1, 'ABC-123', 2022, 15000, 1, 1, 1, 1), -- Toyota Yaris - Económico - Lima - Disponible
(2, 'XYZ-789', 2023, 8500,  2, 1, 2, 2), -- Toyota RAV4 - SUV - Lima - Alquilado
(3, 'MNO-456', 2021, 32000, 1, 2, 3, 1), -- Hyundai Accent - Económico - Arequipa - Disponible
(4, 'JKL-321', 2023, 12000, 2, 2, 4, 3), -- Hyundai Tucson - SUV, Arequipa - Mantenimiento
(5, 'LUX-999', 2024, 4000,  3, 1, 6, 1), -- BMW X5 - Premium - Lima - Disponible
(6, 'DEF-456', 2020, 45000, 1, 3, 7, 1); -- Nissan Versa - Económico - Cusco - Disponible

-- Estado_Historial
INSERT INTO Estado_Historial (id_historial, id_vehiculo, fecha_evento, estado_anterior, estado_nuevo, motivo) VALUES 
(1, 4, '2026-07-01 09:00:00', 'Disponible', 'En Mantenimiento', 'Mantenimiento preventivo de 10k km'),
(2, 2, '2026-07-10 10:30:00', 'Disponible', 'Alquilado', 'Inicio de contrato de alquiler'),
(3, 1, '2026-06-20 16:00:00', 'En Mantenimiento', 'Disponible', 'Cambio de aceite finalizado');

-- Reserva
INSERT INTO Reserva (id_reserva, fecha_inicio, fecha_fin, id_usuario, id_vehiculo, id_estado_reserva) VALUES 
(101, '2026-06-01 09:00:00', '2026-06-05 18:00:00', 1, 1, 3), -- Completada
(102, '2026-07-10 10:00:00', '2026-07-20 10:00:00', 2, 2, 2), -- Confirmada 
(103, '2026-08-01 08:00:00', '2026-08-03 20:00:00', 4, 3, 2), -- Confirmada
(104, '2026-07-05 12:00:00', '2026-07-07 12:00:00', 3, 5, 4); -- Cancelada

-- Reserva_Servicio
INSERT INTO Reserva_Servicio (id_reserva, id_servicio, cantidad, subtotal) VALUES 
(101, 2, 1, 40.00), 
(102, 1, 1, 150.00), 
(102, 4, 1, 400.00), 
(103, 3, 1, 50.00);

-- Contrato
INSERT INTO Contrato (id_contrato, fecha_emision, km_salida, km_retorno, id_reserva, id_sede_recogida, id_sede_devolucion, id_estado_contrato) VALUES 
(201, '2026-06-01 09:15:00', 14500, 15000, 101, 1, 1, 2), 
(202, '2026-07-10 10:20:00', 8500,  NULL,  102, 1, 2, 1); 

-- Pago
INSERT INTO Pago (id_pago, fecha_pago, monto_total, id_contrato, id_metodo_pago) VALUES 
(301, '2026-06-01 09:20:00', 180.00, 201, 1), 
(302, '2026-07-10 10:25:00', 1300.00, 202, 1); 