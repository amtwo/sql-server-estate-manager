# SQL Server Estate Manager

A small project to manage your estate, patching, and license compliance

This project is licensed under [the 3-Clause BSD License](LICENSE).


## Setup Instructions
### To install
* Clone this repo.
* From the sql-server-estate-manager folder, run the install script:
  * `./Install-LatestEstateDatabase.ps1 -InstanceName "PRODSQL123"`
    * This will create a `sql_server_estate_manager` database on the server `PRODSQL123`. 
    * Optionally, you can use the `-DatabaseName` parameter to use a non-default database name.
* Schedule `\pwsh\Get-SqlServerEstateInfo.ps1` to run on a schedule.
  * If you've installed the database on `PRODSQL123` using the instructions above, you will want to schedule the execution of the following PowerShell command:
    * `./Get-SqlServerEstateInfo.ps1 -InstanceName "PRODSQL123"`
  * If you've used a non-default database name, you will need to use the `-DatabaseName` parameter to additionally specify the correct database:
    * `./Get-SqlServerEstateInfo.ps1 -InstanceName "PRODSQL123" -DatabaseName "EstateManager"`
  * You likely want to copy this script to a management server and schedule it to run on a daily basis, using the scheduling software of your choice. (SQL Agent works fine.)


### To configure
Populate the `dbo.Servers` table with all servers in your environment. This table has two required fields: 
* **`ServerName`** - This is the "normal" host name of your server. ex) PRODSQL123
* **`ServerFQDN`** - This is the fully qualfied domain name of your server. ex) PRODSQL123.contoso.com

