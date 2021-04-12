DELETE pl
FROM Staging.SqlPatchLevels AS pl
WHERE MajorVersion = 15;

INSERT INTO Staging.SqlPatchLevels (ProductVersion, MajorVersion, ProductLevel, ProductUpdateLevel, ReleaseDate, SupportEndDate)
SELECT ProductVersion, MajorVersion, ProductLevel, ProductUpdateLevel, ReleaseDate, SupportEndDate
FROM (VALUES
    ('15.0.2000.5', 15.00, 'RTM', 'RTM', '20191104', NULL),
    ('15.0.2070.41', 15.00, 'RTM', 'GDR', '20191104', NULL),
    ('15.0.4003.23', 15.00, 'RTM', 'CU1', '20200107', NULL),
    ('15.0.4013.40', 15.00, 'RTM', 'Withdrawn Update', '20200213', NULL),
    ('15.0.4023.6', 15.00, 'RTM', 'CU3', '20200312', NULL),
    ('15.0.4033.1', 15.00, 'RTM', 'CU4', '20200331', NULL),
    ('15.0.4043.16', 15.00, 'RTM', 'CU5', '20200622', NULL),
    ('15.0.4053.23', 15.00, 'RTM', 'CU6', '20200804', NULL),
    ('15.0.4073.23', 15.00, 'RTM', 'CU8', '20201001', NULL),
    ('15.0.4083.2', 15.00, 'RTM', 'CU8 Security Update', '20210112', NULL),
    ('15.0.4102.2', 15.00, 'RTM', 'CU9', '20210211', NULL),
    ('15.0.4123.1', 15.00, 'RTM', 'CU10', '20210406', NULL),
    ('15.4063.15', 15.00, 'RTM', 'CU7', '20200902', NULL)
) AS x(ProductVersion, MajorVersion, ProductLevel, ProductUpdateLevel, ReleaseDate, SupportEndDate);

