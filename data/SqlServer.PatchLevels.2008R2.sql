DELETE pl
FROM Staging.SqlPatchLevels AS pl
WHERE MajorVersion = 10.5;

INSERT INTO Staging.SqlPatchLevels (ProductVersion, MajorVersion, ProductLevel, ProductUpdateLevel, ReleaseDate, SupportEndDate)
SELECT ProductVersion, MajorVersion, ProductLevel, ProductUpdateLevel, ReleaseDate, SupportEndDate
FROM (VALUES
    ('10.50.1600', 10.50, 'RTM', NULL,  '20100720', '20120710'),
    ('10.50.6560', 10.50, 'RTM', 'GDR', '20180111', '20190709'),
    ('10.50.2500', 10.50, 'SP1', NULL,  '20110711', '20131008'),
    ('10.50.4000', 10.50, 'SP2', NULL,  '20120726', '20151013'),
    ('10.50.6000', 10.50, 'SP3', NULL,  '20140930', '20190709')
) AS x(ProductVersion, MajorVersion, ProductLevel, ProductUpdateLevel, ReleaseDate, SupportEndDate);

