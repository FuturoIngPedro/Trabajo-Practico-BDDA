Descripción
Este proyecto contiene scripts SQL para la creación y carga de datos en la base de datos Com1353G02, incluyendo:

Creación de la base de datos y el esquema.
Creación de la tabla Ventas.
Procedimiento almacenado para importar datos desde un archivo de ventas.


Pasos para configurar la base de datos

1️⃣ Ejecutar el script de creación de la base de datos

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'Com1353G02')
BEGIN
    CREATE DATABASE Com1353G02;
END;
GO

USE Com1353G02;
GO

//Esto verificará si la base de datos existe y, si no, la creará.

2️⃣ Crear el esquema ddbba

IF NOT EXISTS (SELECT name FROM sys.schemas WHERE name = 'ddbba')
BEGIN
    EXEC('CREATE SCHEMA ddbba');
END;
GO

//Este paso garantiza que el esquema ddbba exista antes de crear la tabla.

3️⃣ Crear la tabla Ventas (si no existe)
Ejecutar el procedimiento para crear la tabla:

EXEC ddbba.CrearTablaVentas;

//Si la tabla no existe, se creará automáticamente con la estructura definida en el script.

Carga de Datos desde el archivo Ventas_registradas
Requisitos del archivo
  - Separador de columnas: ; (punto y coma).
  - Codificación: UTF-8.
  - Estructura esperada: IDFactura;TipoFactura;Ciudad;TipoCliente;Genero;Producto;PrecioUnitario;Cantidad;Fecha;Hora;MedioPago;Empleado;IdentificadorPago

Importar el archivo CSV a la tabla Ventas
Ejecutar el procedimiento almacenado, pasando la ruta del archivo Ventas_registradas: 

EXEC ddbba.ImportarVentas 'C:\ruta\del\archivo\Ventas_registradas.csv'; //Reemplazar con la ubicación real del archivo

Para confirmar que los datos se importaron correctamente:
SELECT * FROM ddbba.Ventas;
