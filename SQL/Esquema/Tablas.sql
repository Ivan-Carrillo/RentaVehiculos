-- create database RentaVehiculos
GO

CREATE TABLE Categoria
(
  id_categoria numeric       NOT NULL,
  nombre       varchar(50)   NOT NULL,
  tarifa_dia   decimal(10,2) NOT NULL,
  CONSTRAINT PK_Categoria PRIMARY KEY (id_categoria)
)
GO

CREATE TABLE Contrato
(
  id_contrato        numeric  NOT NULL,
  fecha_emision      datetime NOT NULL,
  km_salida          numeric  NOT NULL,
  km_retorno         numeric ,
  id_reserva         numeric  NOT NULL,
  id_sede_recogida   numeric  NOT NULL,
  id_sede_devolucion numeric ,
  id_estado_contrato numeric  NOT NULL,
  CONSTRAINT PK_Contrato PRIMARY KEY (id_contrato)
)
GO

ALTER TABLE Contrato
  ADD CONSTRAINT UQ_id_reserva UNIQUE (id_reserva)
GO

CREATE TABLE Estado_Contrato
(
  id_estado_contrato numeric      NOT NULL,
  descripcion        varchar(300) NOT NULL,
  CONSTRAINT PK_Estado_Contrato PRIMARY KEY (id_estado_contrato)
)
GO

CREATE TABLE Estado_Historial
(
  id_historial    numeric      NOT NULL,
  id_vehiculo     numeric      NOT NULL,
  fecha_evento    datetime     NOT NULL,
  estado_anterior varchar(30) ,
  estado_nuevo    varchar(30)  NOT NULL,
  motivo          varchar(255) NOT NULL,
  CONSTRAINT PK_Estado_Historial PRIMARY KEY (id_historial)
)
GO

CREATE TABLE Estado_Reserva
(
  id_estado_reserva numeric      NOT NULL,
  descripcion       varchar(300) NOT NULL,
  CONSTRAINT PK_Estado_Reserva PRIMARY KEY (id_estado_reserva)
)
GO

CREATE TABLE Estado_Vehiculo
(
  id_estado_vehiculo numeric      NOT NULL,
  descripcion        varchar(300) NOT NULL,
  CONSTRAINT PK_Estado_Vehiculo PRIMARY KEY (id_estado_vehiculo)
)
GO

CREATE TABLE Marca
(
  id_marca numeric     NOT NULL,
  nombre   varchar(50) NOT NULL,
  CONSTRAINT PK_Marca PRIMARY KEY (id_marca)
)
GO

CREATE TABLE Metodo_Pago
(
  id_metodo_pago numeric      NOT NULL,
  descripcion    varchar(300) NOT NULL,
  CONSTRAINT PK_Metodo_Pago PRIMARY KEY (id_metodo_pago)
)
GO

CREATE TABLE Modelo
(
  id_modelo numeric     NOT NULL,
  nombre    varchar(50) NOT NULL,
  id_marca  numeric     NOT NULL,
  CONSTRAINT PK_Modelo PRIMARY KEY (id_modelo)
)
GO

CREATE TABLE Pago
(
  id_pago        numeric       NOT NULL,
  fecha_pago     datetime      NOT NULL,
  monto_total    decimal(10,2) NOT NULL,
  id_contrato    numeric       NOT NULL,
  id_metodo_pago numeric       NOT NULL,
  CONSTRAINT PK_Pago PRIMARY KEY (id_pago)
)
GO

ALTER TABLE Pago
  ADD CONSTRAINT UQ_id_contrato UNIQUE (id_contrato)
GO

CREATE TABLE Reserva
(
  id_reserva        numeric  NOT NULL,
  fecha_inicio      datetime NOT NULL,
  fecha_fin         datetime NOT NULL,
  id_usuario        numeric  NOT NULL,
  id_vehiculo       numeric  NOT NULL,
  id_estado_reserva numeric  NOT NULL,
  CONSTRAINT PK_Reserva PRIMARY KEY (id_reserva)
)
GO

CREATE TABLE Reserva_Servicio
(
  id_reserva  numeric       NOT NULL,
  id_servicio numeric       NOT NULL,
  cantidad    numeric       NOT NULL,
  subtotal    decimal(10,2) NOT NULL,
  CONSTRAINT PK_Reserva_Servicio PRIMARY KEY (id_reserva, id_servicio)
)
GO

CREATE TABLE Sede
(
  id_sede       numeric      NOT NULL,
  ciudad        varchar(50)  NOT NULL,
  direccion     varchar(150) NOT NULL,
  telefono_sede varchar(20)  NOT NULL,
  CONSTRAINT PK_Sede PRIMARY KEY (id_sede)
)
GO

CREATE TABLE Servicio
(
  id_servicio     numeric       NOT NULL,
  nombre_servicio varchar(100)  NOT NULL,
  precio_unitario decimal(10,2) NOT NULL,
  CONSTRAINT PK_Servicio PRIMARY KEY (id_servicio)
)
GO

CREATE TABLE Usuario
(
  id_usuario                 numeric      NOT NULL,
  nombre                     varchar(100) NOT NULL,
  apellido                   varchar(100) NOT NULL,
  email                      varchar(100) NOT NULL,
  contrasenia                varchar(255) NOT NULL,
  telefono                   varchar(20) ,
  rol                        varchar(30)  NOT NULL,
  numero_licencia            varchar(30)  NOT NULL,
  fecha_vencimiento_licencia datetime     NOT NULL,
  CONSTRAINT PK_Usuario PRIMARY KEY (id_usuario)
)
GO

CREATE TABLE Vehiculo
(
  id_vehiculo        numeric     NOT NULL,
  placa              varchar(15) NOT NULL,
  anio               numeric     NOT NULL,
  km_actual          numeric     NOT NULL,
  id_categoria       numeric     NOT NULL,
  id_sede            numeric     NOT NULL,
  id_modelo          numeric     NOT NULL,
  id_estado_vehiculo numeric     NOT NULL,
  CONSTRAINT PK_Vehiculo PRIMARY KEY (id_vehiculo)
)
GO

ALTER TABLE Vehiculo
  ADD CONSTRAINT FK_Categoria_TO_Vehiculo
    FOREIGN KEY (id_categoria)
    REFERENCES Categoria (id_categoria)
GO

ALTER TABLE Vehiculo
  ADD CONSTRAINT FK_Sede_TO_Vehiculo
    FOREIGN KEY (id_sede)
    REFERENCES Sede (id_sede)
GO

ALTER TABLE Reserva
  ADD CONSTRAINT FK_Usuario_TO_Reserva
    FOREIGN KEY (id_usuario)
    REFERENCES Usuario (id_usuario)
GO

ALTER TABLE Reserva
  ADD CONSTRAINT FK_Vehiculo_TO_Reserva
    FOREIGN KEY (id_vehiculo)
    REFERENCES Vehiculo (id_vehiculo)
GO

ALTER TABLE Reserva_Servicio
  ADD CONSTRAINT FK_Reserva_TO_Reserva_Servicio
    FOREIGN KEY (id_reserva)
    REFERENCES Reserva (id_reserva)
GO

ALTER TABLE Reserva_Servicio
  ADD CONSTRAINT FK_Servicio_TO_Reserva_Servicio
    FOREIGN KEY (id_servicio)
    REFERENCES Servicio (id_servicio)
GO

ALTER TABLE Contrato
  ADD CONSTRAINT FK_Reserva_TO_Contrato
    FOREIGN KEY (id_reserva)
    REFERENCES Reserva (id_reserva)
GO

ALTER TABLE Pago
  ADD CONSTRAINT FK_Contrato_TO_Pago
    FOREIGN KEY (id_contrato)
    REFERENCES Contrato (id_contrato)
GO

ALTER TABLE Modelo
  ADD CONSTRAINT FK_Marca_TO_Modelo
    FOREIGN KEY (id_marca)
    REFERENCES Marca (id_marca)
GO

ALTER TABLE Vehiculo
  ADD CONSTRAINT FK_Modelo_TO_Vehiculo
    FOREIGN KEY (id_modelo)
    REFERENCES Modelo (id_modelo)
GO

ALTER TABLE Vehiculo
  ADD CONSTRAINT FK_Estado_Vehiculo_TO_Vehiculo
    FOREIGN KEY (id_estado_vehiculo)
    REFERENCES Estado_Vehiculo (id_estado_vehiculo)
GO

ALTER TABLE Estado_Historial
  ADD CONSTRAINT FK_Vehiculo_TO_Estado_Historial
    FOREIGN KEY (id_vehiculo)
    REFERENCES Vehiculo (id_vehiculo)
GO

ALTER TABLE Reserva
  ADD CONSTRAINT FK_Estado_Reserva_TO_Reserva
    FOREIGN KEY (id_estado_reserva)
    REFERENCES Estado_Reserva (id_estado_reserva)
GO

ALTER TABLE Contrato
  ADD CONSTRAINT FK_Estado_Contrato_TO_Contrato
    FOREIGN KEY (id_estado_contrato)
    REFERENCES Estado_Contrato (id_estado_contrato)
GO

ALTER TABLE Pago
  ADD CONSTRAINT FK_Metodo_Pago_TO_Pago
    FOREIGN KEY (id_metodo_pago)
    REFERENCES Metodo_Pago (id_metodo_pago)
GO

ALTER TABLE Contrato
  ADD CONSTRAINT FK_Sede_TO_Contrato
    FOREIGN KEY (id_sede_recogida)
    REFERENCES Sede (id_sede)
GO

ALTER TABLE Contrato
  ADD CONSTRAINT FK_Sede_TO_Contrato1
    FOREIGN KEY (id_sede_devolucion)
    REFERENCES Sede (id_sede)
GO
