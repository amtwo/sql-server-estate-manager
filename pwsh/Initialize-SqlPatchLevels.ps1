
Param(
    [parameter( Mandatory = $true )]
        [string] $ServerInstance ,

    [parameter( Mandatory = $false )]
    [string] $Database  = "sql_server_estate_manager"

)

Import-Module SqlServer

Write-Verbose "`n        ***Truncating Staging.SqlPatchLevels `n"
Invoke-SqlCmd -ServerInstance $ServerInstance -Database $Database -Query "TRUNCATE TABLE Staging.SqlPatchLevels;"


Write-Verbose "`n        ***Loading Staging.SqlPatchLevels from files `n"
$fileList = Get-ChildItem -Path .\data -Recurse -Filter SqlServer.PatchLevels.*.sql
Foreach ($file in $fileList){
    Write-Verbose $file.FullName
    Invoke-Sqlcmd -ServerInstance $instance -Database $Database -InputFile $file.FullName -QueryTimeout 300
}

Write-Verbose "`n        ***Loading SqlServer.PatchLevels from Staging.SqlPatchLevels `n"
Invoke-SqlCmd -ServerInstance $ServerInstance -Database $Database -Query "TRUNCATE TABLE Staging.SqlPatchLevels;"

