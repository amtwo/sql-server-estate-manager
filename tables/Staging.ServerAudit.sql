IF ( object_id('Staging.ServerAudit','U') IS NULL )
BEGIN
    CREATE TABLE Staging.ServerAudit (
        ServerName              nvarchar(128)   NOT NULL,
        LastWindowsPatchDate    date            NULL,
        CoreCount               nvarchar(16)    NULL
        INDEX CIX_StagingServerAudit CLUSTERED (ServerName)
        );
END;

