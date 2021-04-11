IF ( object_id('dbo.EstateServers','U') IS NULL )
BEGIN
    CREATE TABLE dbo.EstateServers (
        ServerName      nvarchar(128)   NOT NULL,
        ServerFQDN      nvarchar(128)   NOT NULL,
        Environment     varchar(16)     NULL
        CONSTRAINT PK_Servers PRIMARY KEY CLUSTERED (ServerName)
        );
END;
