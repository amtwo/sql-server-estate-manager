IF ( schema_id('SqlServer') IS NULL )
BEGIN
	EXEC sp_executesql @stmt = N'CREATE SCHEMA [SqlServer] AUTHORIZATION [dbo];';
END
