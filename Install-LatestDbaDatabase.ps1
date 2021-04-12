<#
.SYNOPSIS
Installs or updates sql-server-estate-manager database to the latest version
 
.DESCRIPTION
This function will create a sql-server-estate-manager database if it does not already exist, and install the latest code. 

This depends on having the full, latest version of the full repo https://github.com/amtwo/sql-server-estate-manager

All dependent .sql files are itempotent:
* Table.sql scripts are written to create if not exists. Changes are maintained similarly as conditional idempotent ALTERs.
* code.sql scripts are written to create a stub, then alter with actual code. Switch to CREATE OR ALTER in 2024 when support ends for SQL 2014

.PARAMETER InstanceName
An array of instance names, in case you are deploying to multiple locations, such as separate environments.

.PARAMETER DatabaseName
By default, this will be installed in a database called "sql_server_estate_manager". 
If you want to install my estate manager database with a different name, specify it here.

 
.EXAMPLE
Install-LatestDbaDatabase -InstanceName AM2Prod
 

.NOTES
AUTHOR: Andy Mallon
DATE: 20210409
COPYRIGHT: This code is licensed as part of Andy Mallon's SQL Server Estate Manager Database, using the 3-Clause BSD License.
https://github.com/amtwo/sql-server-estate-manager/blob/master/LICENSE
©2021 ● Andy Mallon ● am2.co
#>
 
[CmdletBinding()]
param (
    [Parameter(Position=0,mandatory=$true)]
        [string[]]$InstanceName,
    [Parameter(Position=1,mandatory=$false)]
        [string]$DatabaseName = 'sql_server_estate_manager'
    )

# Process servers in a loop. I could do this parallel, but doing it this way is fast enough for me.
foreach($instance in $InstanceName) {
    Write-Verbose "**************************************************************"
    Write-Verbose "                           $instance"
    Write-Verbose "**************************************************************"
    #Create the database - SQL Script contains logic to be conditional & not clobber existing database
    Write-Verbose "`n        ***Creating Database if necessary `n"
    Invoke-Sqlcmd -ServerInstance $instance -Database master -InputFile .\create-database.sql -Variable "DbName=$($DatabaseName)"

    #Create schemas first
    Write-Verbose "`n        ***Creating/Updating Schemas `n"
    $fileList = Get-ChildItem -Path .\schemas -Recurse
    Foreach ($file in $fileList){
        Write-Verbose $file.FullName
        Invoke-Sqlcmd -ServerInstance $instance -Database $DatabaseName -InputFile $file.FullName -QueryTimeout 300
    }
    #Create tables second
    Write-Verbose "`n        ***Creating/Updating Tables `n"
    $fileList = Get-ChildItem -Path .\tables -Recurse
    Foreach ($file in $fileList){
        Write-Verbose $file.FullName
        Invoke-Sqlcmd -ServerInstance $instance -Database $DatabaseName -InputFile $file.FullName -QueryTimeout 300
    }
    #Then scalar functions
    Write-Verbose "`n        ***Creating/Updating Scalar Functions `n"
    $fileList = Get-ChildItem -Path .\functions-scalar -Recurse
    Foreach ($file in $fileList){
        Write-Verbose $file.FullName
        Invoke-Sqlcmd -ServerInstance $instance -Database $DatabaseName -InputFile $file.FullName
    }
    #Then TVFs
    Write-Verbose "`n        ***Creating/Updating Table-Valued Functions `n"
    $fileList = Get-ChildItem -Path .\functions-tvfs -Recurse
    Foreach ($file in $fileList){
        Write-Verbose $file.FullName
        Invoke-Sqlcmd -ServerInstance $instance -Database $DatabaseName -InputFile $file.FullName
    }
    #Then Procedures
    Write-Verbose "`n        ***Creating/Updating Stored Procedures `n"
    $fileList = Get-ChildItem -Path .\stored-procedures -Recurse -Filter *.sql
    Foreach ($file in $fileList){
        Write-Verbose $file.FullName
        Invoke-Sqlcmd -ServerInstance $instance -Database $DatabaseName -InputFile $file.FullName
    }
    # Finally, load data
    Write-Verbose "`n        ***Loading Data `n"
    $fileList = Get-ChildItem -Path .\data -Recurse -Filter *.sql
    Foreach ($file in $fileList){
        Write-Verbose $file.FullName
        Invoke-Sqlcmd -ServerInstance $instance -Database $DatabaseName -InputFile $file.FullName  -QueryTimeout 300
    }


#That's it!
}
