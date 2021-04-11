IF ( object_id('SqlServer.ApprovedPatchLevels','U') IS NULL )
BEGIN
    CREATE TABLE SqlServer.ApprovedPatchLevels (
        ProductVersion      varchar(16)     NOT NULL,
        Environment         varchar(16)     NOT NULL,
        ApprovalDate        date            NOT NULL
                CONSTRAINT DF_ApprovedPatchLevels_Date DEFAULT (GETUTCDATE()),
        ApprovalComments    nvarchar(256)   NULL,
        CONSTRAINT PK_ApprovedPatchLevels PRIMARY KEY CLUSTERED (ProductVersion,Environment)
        );
END;
