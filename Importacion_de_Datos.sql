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

EXEC ddbba.ImportarVentas 'C:\Users\jimeb\Desktop\TP_BDDA\Ventas_registradas.csv';

--para verificar si se cargaron los datos
SELECT * FROM ddbba.Ventas

DROP PROCEDURE ddbba.ImportarCatalogo
--CATALOGO
CREATE PROCEDURE ddbba.ImportarCatalogo
    @RutaArchivo NVARCHAR(255)
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);

    SET @SQL = '
    BULK INSERT ddbba.Catalogo
    FROM ''' + @RutaArchivo + ''' 
    WITH (
		FORMAT = ''CSV'',
        FIRSTROW = 2,
        FIELDTERMINATOR = '','',
        ROWTERMINATOR = ''0x0A'',
        TABLOCK,
        CODEPAGE = ''65001'' -- UTF-8 para caracteres especiales
    );';

    EXEC sp_executesql @SQL;
END;
go
 
EXEC ddbba.ImportarCatalogo 'C:\Users\jimeb\Desktop\TP_BDDA\Productos\catalogo.csv'

--para confirmar si se exportaron los datos
SELECT * FROM ddbba.Catalogo

sp_configure 'show advanced options', 1;
RECONFIGURE;
GO
sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;
GO

--ACCESORIOS ELECTRONICOS
CREATE OR ALTER PROCEDURE ddbba.ImportarAccesoriosElectronicos
	@NomArch VARCHAR(255)
AS
BEGIN
	
	DECLARE @SQL NVARCHAR(MAX);

	SET @SQL = 
	'INSERT INTO  ddbba.Accesorios_Electronicos (Producto, Precio_Unitario)
	SELECT "Product", [Precio Unitario en Dolares]
	FROM OPENROWSET(
	''Microsoft.ACE.OLEDB.16.0'',
	''Excel 12.0;Database=' + @NomArch + ';HDR=YES;'',
	''SELECT * FROM [Sheet1$]'')';

	EXEC sp_executesql @SQL;
END;
GO

EXEC ddbba.ImportarAccesoriosElectronicos
	@NomArch = 'C:\\Users\\taiel\\Desktop\\TP_integrador_Archivos\\Productos\\Electronic accessories.xlsx';

--para verificar si se cargaron los datos
SELECT * FROM ddbba.Accesorios_Electronicos
