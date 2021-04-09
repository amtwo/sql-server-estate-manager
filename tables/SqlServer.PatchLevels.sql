IF ( object_id('SqlServer.PatchLevels','U') IS NULL )
BEGIN
    CREATE TABLE SqlServer.PatchLevels (
        ProductVersion      varchar (16)    NOT NULL,
        MajorVersion        decimal(4,2)    NULL,
        ProductLevel        varchar (16)    NULL,
        ProductUpdateLevel  varchar (16)    NULL,
        ReleaseDate         date            NULL,
        SupportEndDate      date            NULL
        CONSTRAINT PK_SqlPatchLevels PRIMARY KEY CLUSTERED (ProductVersion)
        );
END;

-- Scrape SqlServerBuilds.blogspot.com or SqlServerBuilds.com to populate historical info?

