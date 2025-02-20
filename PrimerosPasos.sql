--Validación de existencia de base de datos para su creación
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'Com1353G02')
BEGIN
    CREATE DATABASE Com1353G02;
END;
GO

USE Com1353G02;
GO

--Validación de existencia de esquema para su creación
IF NOT EXISTS (SELECT name FROM sys.schemas WHERE name = 'ddbba')
BEGIN
    EXEC('CREATE SCHEMA ddbba');
END;
GO

--DROP PROCEDURE ddbba.CrearTablaVentas

CREATE PROCEDURE ddbba.CrearTablaVentas
AS
BEGIN
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
END;

EXEC ddbba.CrearTablaVentas;

--DROP PROCEDURE ddbba.ImportarVentas

CREATE PROCEDURE ddbba.ImportarVentas
    @RutaArchivo NVARCHAR(255)
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);

    SET @SQL = '
    BULK INSERT ddbba.Ventas
    FROM ''' + @RutaArchivo + ''' 
    WITH (
        FORMAT = ''CSV'',
        FIRSTROW = 2,
        FIELDTERMINATOR = '';'',
        ROWTERMINATOR = ''\n'',
        TABLOCK,
        CODEPAGE = ''65001'' -- UTF-8 para caracteres especiales
    );';

    EXEC sp_executesql @SQL;
END;

EXEC ddbba.ImportarVentas 'C:\Users\Pedro Melissari\Desktop\TP_integrador_Archivos\Ventas_registradas.csv';

SELECT * FROM ddbba.Ventas