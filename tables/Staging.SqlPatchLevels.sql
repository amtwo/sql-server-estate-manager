IF ( object_id('Staging.SqlPatchLevels','U') IS NULL )
BEGIN
    CREATE TABLE Staging.SqlPatchLevels (
        ProductVersion      varchar(16)     NOT NULL,
        MajorVersion        decimal(4,2)    NULL,
        ProductLevel        varchar(16)     NULL,
        ProductUpdateLevel  varchar(32)     NULL,
        ReleaseDate         date            NULL,
        SupportEndDate      date            NULL
        CONSTRAINT PK_StagingSqlPatchLevels PRIMARY KEY CLUSTERED (ProductVersion)
        );
END;

-- Scrape SqlServerBuilds.blogspot.com or SqlServerBuilds.com to populate historical info?

