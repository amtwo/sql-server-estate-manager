
[cmdletbinding(
    SupportsShouldProcess = $true,
    DefaultParameterSetName = 'DbTarget'
)]

Param(
    [parameter(
        Mandatory = $true,
        ParameterSetName = 'DbTarget'
    )]
    [string] $ServerInstance ,

    [parameter(
        Mandatory = $true,
        ParameterSetName = 'DbTarget'
    )]
    [string] $DatabaseName  = "sql_server_estate_manager",

    [parameter(
        Mandatory = $false,
        ParameterSetName = 'DbTarget'
    )]

    [parameter(
        Mandatory = $true,
        ParameterSetName = 'FileTarget'
    )]
    [string] $CsvPath

)
Import-Module SqlServer

# Get list of everything 
# Add a filter by Environment later.
$ServerList = Invoke-SqlCmd -ServerInstance BLEP -Database sql_server_estate_manager -Query "SELECT * FROM dbo.EstateServers"

$ServerAuditResult = @()
$SqlAuditResult = @()
$SkippedServers = @()

foreach($Server in $ServerList){
    Write-Verbose "Evaluating Server:  $($Server.ServerName)"

    # Test is the server is accessible via WMI, skip additional connection attempts if the server is unreachable
    If ( (Test-NetConnection -ComputerName $Server.ServerName -Port 135).TcpTestSucceeded ){
        
            # If there are stacked instances, we'll need to loop through & grab them all.
            $InstanceDetails = @()
            $InstanceDetails += Invoke-Command -ComputerName $Server.ServerName {
                $Instances = (Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\Instance Names").Property
                ForEach ($InstanceName in $Instances){
                    $i = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\Instance Names\SQL').$InstanceName;
                    $InstanceProperties = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\$i\Setup"

                    $SqlAuditResult += @([pscustomobject]@{
                                            ServerName       = $Server.ServerName;
                                            InstanceName     = $InstanceName;
                                            SqlPatchLevel    = $InstanceProperties.PatchLevel;
                                            SqlEdition       = $InstanceProperties.Edition;
                                            }
                                        )
                }
            }

            $LastWinPatch   = Get-HotFix -ComputerName $Server.name| 
                                    Sort-Object -Property InstalledOn -Descending | Select-Object -First 1
            $CoreCount      = (Get-WmiObject win32_processor -Property numberOfCores -ComputerName $Server.name| 
                                    Measure-Object -Property NumberOfCores -Sum).sum
            $LastWinPatchDate = $LastWinPatch.InstalledOn.ToShortDateString()

            $ServerAuditResult += @([pscustomobject]@{
                                    ServerName        = $Server.ServerName;
                                    LastWinPatch      = $LastWinPatchDate;
                                    CoreCount         = $coreCount;
                                    }
                                )

    }
    else {
        Write-Verbose "Unable to connect to $($Server.name) via WMI. Skipping all WMI checks"

        $SkippedServers += $Servers;

    }

}


If ($CsvPath){
    Write-Verbose "Writing output to $($CsvPath)"
    $SqlAuditResult | Export-Csv -Path "$($CsvPath)\SQLServerAudit_$(Get-Date -Format yyyyMMdd).csv" -NoTypeInformation
    $ServerAuditResult | Export-Csv -Path "$($CsvPath)\ServerAudit_$(Get-Date -Format yyyyMMdd).csv" -NoTypeInformation
}

If ($ServerInstance){
    Write-Verbose "Truncating staging tables on [$($ServerInstance)].[$($DatabaseName)]"
    Invoke-SqlCmd -ServerInstance $ServerInstance -Database $DatabaseName -Query "TRUNCATE TABLE staging.ServerAudit;"
    Invoke-SqlCmd -ServerInstance $ServerInstance -Database $DatabaseName -Query "TRUNCATE TABLE staging.SqlAudit;"
    Write-Verbose "Writing output to [$($ServerInstance)].[$($DatabaseName)]"
    Write-SqlTableData -ServerInstance $ServerInstance -DatabaseName $DatabaseName -SchemaName "staging" -TableName "ServerAudit" -InputData $ServerAuditResult
    Write-SqlTableData -ServerInstance $ServerInstance -DatabaseName $DatabaseName -SchemaName "staging" -TableName "SqlAudit" -InputData $SqlAuditResult
    Write-Verbose "Loading Data to dbo.SQLServerPatchAudit"
    Invoke-SqlCmd -ServerInstance $ServerInstance -Database $DatabaseName -Query "EXEC dbo.ServerAudit_Load;"
}
