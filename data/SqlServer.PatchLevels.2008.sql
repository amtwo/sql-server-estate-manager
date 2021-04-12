DELETE pl
FROM Staging.SqlPatchLevels AS pl
WHERE MajorVersion = 10;

INSERT INTO Staging.SqlPatchLevels (ProductVersion, MajorVersion, ProductLevel, ProductUpdateLevel, ReleaseDate, SupportEndDate)
SELECT ProductVersion, MajorVersion, ProductLevel, ProductUpdateLevel, ReleaseDate, SupportEndDate
FROM (VALUES
    ('10.0.6556',  10, 'RTM', 'GDR', '20180111', '20190709'),
    ('10.00.1600', 10, 'RTM', NULL,  '20081107', '20100413'),
    ('10.00.2531', 10, 'SP1', NULL,  '20090407', '20111011'),
    ('10.00.4000', 10, 'SP2', NULL,  '20100924', '20121009'),
    ('10.00.5500', 10, 'SP3', NULL,  '20111006', '20151013'),
    ('10.00.6000', 10, 'SP4', NULL,  '20140930', '20190709')
) AS x(ProductVersion, MajorVersion, ProductLevel, ProductUpdateLevel, ReleaseDate, SupportEndDate);

EXEC SqlServer.PatchLevels_Load @MajorVersion = 10;