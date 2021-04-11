IF ( object_id('dbo.EstateServers','U') IS NULL )
BEGIN
    CREATE TABLE dbo.EstateServers (
        ServerName      nvarchar(128)   NOT NULL,
        ServerFQDN      nvarchar(128)   NOT NULL,
        Environment     varchar(16)     NULL,
        SqlLicenseType  varchar(16)     NULL,
        SqlSaPrimary    nvarchar(128)   NULL
        CONSTRAINT PK_EstateServers PRIMARY KEY CLUSTERED (ServerName)
        );
END;
