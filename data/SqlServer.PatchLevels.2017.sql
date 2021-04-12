DELETE pl
FROM Staging.SqlPatchLevels AS pl
WHERE MajorVersion = 14;

INSERT INTO Staging.SqlPatchLevels (ProductVersion, MajorVersion, ProductLevel, ProductUpdateLevel, ReleaseDate, SupportEndDate)
SELECT ProductVersion, MajorVersion, ProductLevel, ProductUpdateLevel, ReleaseDate, SupportEndDate
FROM (VALUES
    ('14.0.1000.169', 14.00, 'RTM', '', '20171002', '20271012'),
    ('14.0.2000.63', 14.00, 'RTM', 'GDR', '20180814', '20271012'),
    ('14.0.3006.16', 14.00, 'RTM', 'CU1', '20171025', '20271012'),
    ('14.0.3008.27', 14.00, 'RTM', 'CU2', '20171129', '20271012'),
    ('14.0.3015.40', 14.00, 'RTM', 'CU3', '20180104', '20271012'),
    ('14.0.3022.28', 14.00, 'RTM', 'CU4', '20180221', '20271012'),
    ('14.0.3023.8', 14.00, 'RTM', 'CU5', '20180320', '20271012'),
    ('14.0.3025.34', 14.00, 'RTM', 'CU6', '20180419', '20271012'),
    ('14.0.3026.27', 14.00, 'RTM', 'CU7', '20180524', '20271012'),
    ('14.0.3029.16', 14.00, 'RTM', 'CU8', '20180620', '20271012'),
    ('14.0.3030.27', 14.00, 'RTM', 'CU9', '20180718', '20271012'),
    ('14.0.3035.2', 14.00, 'RTM', 'CU9 Security Update', '20180814', '20271012'),
    ('14.0.3037.1', 14.00, 'RTM', 'CU10', '20180827', '20271012'),
    ('14.0.3038.14', 14.00, 'RTM', 'CU11', '20180920', '20271012'),
    ('14.0.3045.24', 14.00, 'RTM', 'CU12', '20181024', '20271012'),
    ('14.0.3048.4', 14.00, 'RTM', 'CU13', '20181218', '20271012'),
    ('14.0.3049.1', 14.00, 'RTM', 'CU13 Hotfix', '20190107', '20271012'),
    ('14.0.3076.1', 14.00, 'RTM', 'CU14', '20190325', '20271012'),
    ('14.0.3162.1', 14.00, 'RTM', 'CU15', '20190524', '20271012'),
    ('14.0.3164.1', 14.00, 'RTM', 'CU15 Hotfix', '20190621', '20271012'),
    ('14.0.3192.2', 14.00, 'RTM', 'CU15 GDR', '20190709', '20271012'),
    ('14.0.3223.3', 14.00, 'RTM', 'CU16', '20190801', '20271012'),
    ('14.0.3238.1', 14.00, 'RTM', 'CU17', '20191008', '20271012'),
    ('14.0.3257.3', 14.00, 'RTM', 'CU18', '20191209', '20271012'),
    ('14.0.3281.6', 14.00, 'RTM', 'CU19', '20200205', '20271012'),
    ('14.0.3294.2', 14.00, 'RTM', 'CU20', '20200407', '20271012'),
    ('14.0.3335.7', 14.00, 'RTM', 'CU21', '20200701', '20271012'),
    ('14.0.3356.20', 14.00, 'RTM', 'CU22', '20200910', '20271012'),
    ('14.0.3370.1', 14.00, 'RTM', 'CU22 Security Update', '20210112', '20271012'),
    ('14.0.3381.3', 14.00, 'RTM', 'CU23', '20210225', '20271012')
) AS x(ProductVersion, MajorVersion, ProductLevel, ProductUpdateLevel, ReleaseDate, SupportEndDate);

EXEC SqlServer.PatchLevels_Load @MajorVersion = 14;