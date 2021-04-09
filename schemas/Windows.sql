IF ( schema_id('Windows') IS NULL )
BEGIN
	EXEC sp_executesql @stmt = N'CREATE SCHEMA [Windows] AUTHORIZATION [dbo];';
END
