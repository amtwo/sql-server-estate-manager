IF ( schema_id('Staging') IS NULL )
BEGIN
	EXEC sp_executesql @stmt = N'CREATE SCHEMA [Staging] AUTHORIZATION [dbo];';
END
