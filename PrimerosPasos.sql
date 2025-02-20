--Validación de existencia de base de datos para su creación
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'Com1353G02') 
BEGIN
    CREATE DATABASE Com1353G02
	COLLATE Latin1_General_CI_AS
END;
ELSE
	print 'ya existe la base de datos Com1353G02'
GO

USE Com1353G02;
GO

--Validación de existencia de esquema para su creación
IF NOT EXISTS (SELECT name FROM sys.schemas WHERE name = 'ddbba')
BEGIN
    EXEC('CREATE SCHEMA ddbba');
END;
ELSE 
	print 'ya existe el esquema ddbba'
GO

--DROP PROCEDURE ddbba.CrearTablaVentas


--Procedure para crear todas las tablas
CREATE PROCEDURE ddbba.CrearTablas
AS
BEGIN
----------------VENTAS REGISTRADAS----------------
--TABLA VENTAS
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Ventas')
    BEGIN
        CREATE TABLE ddbba.Ventas (
            IDFactura NVARCHAR(50),
            TipoFactura CHAR(1),
            Ciudad NVARCHAR(50),
            TipoCliente NVARCHAR(10),
            Genero NVARCHAR(10),
            Producto NVARCHAR(100),
            PrecioUnitario DECIMAL(10,2),
            Cantidad INT,
            Fecha DATE,
            Hora TIME,
            MedioPago NVARCHAR(20),
            Empleado INT,
            IdentificadorPago NVARCHAR(50)
        );
    END
	ELSE print 'La tabla Ventas ya existe'

----------------PRODUCTOS----------------
--TABLA CATALOGO
	IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Catalogo')
	BEGIN
		CREATE TABLE ddbba.Catalogo(
			ID INT PRIMARY KEY,
			Categoria VARCHAR(100),
			Nombre VARCHAR(100),
			Precio DECIMAL (10,2),
			Referencia_Precio decimal (10,2),
			Unidad CHAR(6),
			Fecha_Hora DATETIME
			)
	END
	ELSE print 'La tabla Catalogo ya existe'

--TABLA ACCESORIOS ELECTRONICOS
	IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Accesorios_Electronicos')
	BEGIN
		CREATE TABLE ddbba.Accesorios_Electronicos(
			Producto VARCHAR(40),
			Precio_Unitario DECIMAL (10,2)
			)
	END
	ELSE print 'La tabla Accesorios_Electronicos ya existe'

--TABLA PRODUCTOS IMPORTADOS
	IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Productos_importados')
	BEGIN
		CREATE TABLE ddbba.Productos_Importados(
			ID INT,
			Nombre VARCHAR(40),
			Proveedor VARCHAR(40),
			Categoria VARCHAR(40),
			Cantidad_Por_Unidad VARCHAR (40),
			Precio_Unidad DECIMAL (10,2)
			)
	END
	ELSE print 'La tabla Productos_Importados ya existe'

----------------INFORMACION COMPLEMENTARIA----------------
--TABLA SUCURSAL
	IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Sucursal')
	BEGIN
		CREATE TABLE ddbba.Sucursal(
			Ciudad VARCHAR(40),
			RemplazarPor/*???*/ VARCHAR (40),
			Direccion VARCHAR (100),
			Telefono INT
			)
	END
	ELSE print 'La tabla Sucursal ya existe'

--TABLA EMPLEADOS
	IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Empleados')	
	BEGIN
		CREATE TABLE ddbba.Empleados(
			Legajo INT PRIMARY KEY,
			Nombre VARCHAR(40),
			Apellido VARCHAR (40),
			DNI INT ,
			Direccion VARCHAR(100),
			Email_Empresa NVARCHAR(100),
			CUIL INT,
			Cargo VARCHAR (50),
			Sucursal VARCHAR(50),
			Turno VARCHAR(30)
			)
	END
	ELSE print 'La tabla Empleados ya existe'

--TABLA MEDIOS DE PAGO
	IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Medio_De_Pago')
	BEGIN
		CREATE TABLE ddbba.Medio_De_Pago(
		Medio VARCHAR(40)
		)
	END
	ELSE print 'La tabla Medio_De_Pago ya existe'

--TABLA CLASIFICACION DE PRODUCTOS
	IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Clasificacion_De_Productos')
	BEGIN
		CREATE TABLE ddbba.Clasificacion_Productos(
			Linea_De_Producto VARCHAR(40),
			Producto VARCHAR(40)
			)
	END
	ELSE print 'La tabla Clasificacion_Productos ya existe'

print 'Tablas creadas'
END;
go

 --Ejecutamos el SP
EXEC ddbba.CrearTablas;
go







