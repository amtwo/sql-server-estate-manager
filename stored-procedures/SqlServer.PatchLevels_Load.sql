CREATE OR ALTER PROCEDURE SqlServer.PatchLevels_Load
    @MajorVersion decimal(4,2) = NULL
AS
SET NOCOUNT ON;

--Insert new rows
INSERT INTO SqlServer.PatchLevels (ProductVersion, MajorVersion, ProductLevel, ProductUpdateLevel, ReleaseDate, SupportEndDate)
SELECT ProductVersion, MajorVersion, ProductLevel, ProductUpdateLevel, ReleaseDate, SupportEndDate
FROM Staging.SqlPatchLevels AS stg
WHERE NOT EXISTS (SELECT 1 FROM SqlServer.PatchLevels AS prd WHERE prd.ProductVersion = stg.ProductVersion)
AND stg.MajorVersion = COALESCE(@MajorVersion,stg.MajorVersion)

--Update 
UPDATE prd
SET     prd.ProductLevel        = stg.ProductLevel,
        prd.ProductUpdateLevel  = stg.ProductUpdateLevel,
        prd.ReleaseDate         = stg.ReleaseDate,
        prd.SupportEndDate      = stg.SupportEndDate
FROM SqlServer.PatchLevels  AS prd
JOIN Staging.SqlPatchLevels AS stg ON prd.ProductVersion = stg.ProductVersion
WHERE prd.MajorVersion      =  COALESCE(@MajorVersion,stg.MajorVersion)
AND prd.ProductLevel        <> stg.ProductLevel
AND prd.ProductUpdateLevel  <> stg.ProductUpdateLevel
AND prd.ReleaseDate         <> stg.ReleaseDate
AND prd.SupportEndDate      <> stg.SupportEndDate

--We don't really need to delete anything. If a patch is pulled, we won't delete it.
GO