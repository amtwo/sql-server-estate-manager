IF ( object_id('SqlServer.Instances','U') IS NULL )
BEGIN
    CREATE TABLE SqlServer.Instances (
        ServerName      nvarchar(128)   NOT NULL,
        InstanceName    nvarchar(128)   NOT NULL,
        Purpose         varchar(50)     NULL
        CONSTRAINT PK_SqlInstances PRIMARY KEY CLUSTERED (ServerName,InstanceName)
        );
END;

