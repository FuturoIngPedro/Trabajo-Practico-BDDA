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


CREATE PROCEDURE ddbba.ImportarAccesoriosElectronicos
    @RutaArchivo NVARCHAR(255),
    @NombreHoja NVARCHAR(50)  
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);

    SET @SQL = '
    INSERT INTO ddbba.Accesorios_Electronicos
	SELECT *
    FROM OPENROWSET(''Microsoft.ACE.OLEDB.12.0'',  
                    ''Excel 12.0 Xml;HDR=YES;Database=' + @RutaArchivo + ''',  
                    ''SELECT * FROM [' + @NombreHoja + '$]'');';

    EXEC sp_executesql @SQL;
END;
GO

drop procedure ddbba.ImportarAccesoriosElectronicos

EXEC ddbba.ImportarAccesoriosElectronicos 'C:\Users\jimeb\Desktop\TP_BDDA\Productos\Electronic accessories.xlsx','Sheet1'
    