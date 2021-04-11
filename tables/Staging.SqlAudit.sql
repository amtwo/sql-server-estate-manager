IF ( object_id('Staging.SqlAudit','U') IS NULL )
BEGIN
    CREATE TABLE Staging.SqlAudit (
        ServerName              nvarchar(128)   NOT NULL,
        InstanceName            nvarchar(128)   NOT NULL,
        SqlProductVersion       nvarchar(128)   NULL,
        SqlEdition              nvarchar(128)    NULL
        INDEX CIX_StagingSqlAudit CLUSTERED (ServerName, InstanceName)
        );
END;



