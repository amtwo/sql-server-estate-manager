IF ( object_id('dbo.Servers','U') IS NULL )
BEGIN
    CREATE TABLE dbo.Servers (
        ServerName      nvarchar(128)   NOT NULL,
        ServerFQDN      nvarchar(128)   NOT NULL,
        Environment     varchar(16)     NULL
        CONSTRAINT PK_Servers PRIMARY KEY CLUSTERED (ServerName)
        );
END;
