# 🚗 Sistema de Base de Datos - Alquiler de Vehículos

Modelo entidad-relación (ERD) para un sistema de gestión de alquiler de vehículos, que cubre desde el catálogo de autos hasta las reservas, contratos y pagos.

## 📋 Descripción

Este proyecto contiene el diseño de base de datos para una empresa de renta de autos con múltiples sedes. El modelo permite:

- Gestionar un catálogo de vehículos organizado por marca, modelo, categoría y sede.
- Registrar usuarios (clientes/administradores) con su información de licencia de conducir.
- Manejar el flujo completo de una reserva: desde que el cliente reserva, hasta que se genera el contrato y se registran los pagos.
- Ofrecer servicios adicionales por reserva (GPS, silla para bebé, seguro extra, etc.).
- Llevar un historial de cambios de estado de cada vehículo (mantenimiento, disponible, rentado, etc.).

## 🗂️ Estructura del modelo

El modelo está organizado en tres grandes grupos:

**Catálogos / lookup tables**
- `Marca`, `Modelo`, `Categoria`, `Sede`, `Servicio`
- `Estado_Vehiculo`, `Estado_Reserva`, `Estado_Contrato`, `Metodo_Pago`

**Entidades principales**
- `Usuario` — clientes y/o administradores del sistema.
- `Vehiculo` — inventario de autos disponibles.
- `Reserva` — intención de alquiler hecha por un usuario.
- `Contrato` — alquiler formalizado (incluye sede de recogida y devolución).
- `Pago` — pagos asociados a un contrato.

**Tablas de relación / auditoría**
- `Reserva_Servicio` — servicios adicionales incluidos en una reserva.
- `Estado_Historial` — bitácora de cambios de estado de cada vehículo.

## 🖼️ Diagrama ERD

El diagrama completo (`Vehiculos.erd`) está incluido en este repositorio y puede abrirse con [erd-editor](https://github.com/dineug/erd-editor) o su [extensión de VS Code](https://marketplace.visualstudio.com/items?itemName=dineug.vuerd-vscode).

## 🛠️ Tecnologías / herramientas

- Diseño realizado con **erd-editor**
- Tipos de datos pensados para **SQL estándar** (numeric, varchar, datetime, decimal)

## 🚀 Cómo usar este proyecto

1. Clona el repositorio.
2. Abre `Vehiculos.erd` en erd-editor para visualizar o editar el modelo.
3. Exporta el DDL (SQL) desde la propia herramienta según el motor de base de datos que uses (MySQL, PostgreSQL, SQL Server, etc.).
4. Ejecuta el script generado en tu gestor de base de datos.

## 📌 Notas de diseño

- Se separa **Reserva** de **Contrato** para distinguir la intención de alquilar de la ejecución real del alquiler.
- Los estados (vehículo, reserva, contrato, método de pago) están normalizados en tablas catálogo en vez de usar texto libre, para mantener consistencia e integridad de datos.
- `Contrato` registra sede de recogida y de devolución por separado, dado que el cliente puede devolver el vehículo en una sede distinta a la de recogida.

## 📄 Licencia

Este proyecto está bajo la licencia MIT — consulta el archivo [LICENSE](./LICENSE) para más detalles.

## ✍️ Autor

**Ivan Carrillo**
