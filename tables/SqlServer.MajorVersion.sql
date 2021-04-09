IF ( object_id('SqlServer.MajorVersions','U') IS NULL )
BEGIN
    CREATE TABLE SqlServer.MajorVersions (
        MajorVersion    decimal(4,2)    NOT NULL,
        VersionName     varchar(20)     NOT NULL,
        CONSTRAINT PK_SqlMajorVersions PRIMARY KEY CLUSTERED (MajorVersion)
        );
END;


INSERT INTO SqlServer.MajorVersions (MajorVersion,VersionName)
SELECT MajorVersion,VersionName
FROM (VALUES 
        (6.00, 'SQL Server 6'),
        (6.50, 'SQL Server 6.5'),
        (7.00, 'SQL Server 7'),
        (8.00, 'SQL Server 2000'),
        (9.00, 'SQL Server 2005'),
        (10.00,'SQL Server 2008'),
        (10.50,'SQL Server 2008 R2'),
        (11.00,'SQL Server 2012'),
        (12.00,'SQL Server 2014'),
        (13.00,'SQL Server 2016'),
        (14.00,'SQL Server 2017'),
        (15.00,'SQL Server 2019')
     ) AS x (MajorVersion,VersionName)
WHERE NOT EXISTS (SELECT 1 FROM SqlServer.MajorVersions AS v
                    WHERE v.MajorVersion = x.MajorVersion
                    );

