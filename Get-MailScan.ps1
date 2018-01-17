<#
.SYNOPSIS
This is a PowerShell script to query a MailScanner database to retrieve mail entries from it

.DESCRIPTION
This is a PowerShell script to query a MailScanner database using the MySQL .NET Connector to retrieve mail entries from the database.

This does require you to be able to access the database remotely and having a user that can use the Select command on the database. 
This script is created to retrieve information not modify it. 

.EXAMPLE
./Get-MailScan -Server 127.0.0.1 -UserName user -Password example
Default example retrieves all mail entries in the database

.EXAMPLE
./Get-MailScan -Server 127.0.0.1 -UserName user -Password example -Today
Example that retrieves all mail entries from only Today that are in the database

.EXAMPLE
./Get-MailScan -Server 127.0.0.1 -UserName user -Password example -Spam
Example that retrieves all mail entries that are marked as Spam that are in the database

.EXAMPLE
./Get-MailScan -Server 127.0.0.1 -UserName user -Password example -Spam -Today
Example that retrieves all mail entries that are marked as Spam and only from Today that are in the database

.EXAMPLE`
./Get-MailScan -Server 127.0.0.1 -UserName user -Password example -Database mailscanner
Example of the Database parameter if the database is not installed by its default name

.EXAMPLE
./Get-MailScan -Server 127.0.0.1 -UserName user -Password example -Database mailscanner -Port 3306
Example of the Port parameter if the MySQL/MariaDB remote port is the default 3306 but something else

.EXAMPLE
./Get-MailScan -Server 127.0.0.1 -UserName user -Password example -Database mailscanner -Port 3306 -MySQLPath "C:\Program Files (x86)\MySQL\MySQL Connector Net 6.10.5\Assemblies\v4.5.2\MySql.Data.dll"
Example of the MySQLPath parameter that you can use to find the MySql.Data.Dll file which is required to connect to a MySQL/MariaDB database

.LINK
https://www.mailscanner.info/
http://mailwatch.org/
http://lists.mailscanner.info/pipermail/mailscanner/2010-June/095932.html
https://dev.mysql.com/downloads/connector/net/6.9.html
https://github.com/perplexityjeff
#>

[CmdletBinding()]
param
(
    [Parameter(Mandatory=$true)][String]$Server,  
    [Parameter(Mandatory=$true)][String]$UserName,
    [Parameter(Mandatory=$true)][String]$Password,
    [Parameter()][Switch]$Spam,
    [Parameter()][Switch]$NotSpam,
    [Parameter()][Switch]$Today,
    [Parameter()][String]$To,
    [Parameter()][String]$From,
    [Parameter()][String]$TLD,
    [Parameter()][String]$Database = "mailscanner",
    [Parameter()][int]$Port = 3306,
    [Parameter()][String]$MySQLPath = "C:\Program Files (x86)\MySQL\MySQL Connector Net 6.10.5\Assemblies\v4.5.2\MySql.Data.dll"  
)

#Function to query the database and return the results back to the command line to edit, save or modify to your hearts content
function GetDataFromDatabase($q)
{
    # the connection string used to connect to the database
    $connString = "Server=$Server;Port=$Port;Database=$Database;Uid=$UserName;Pwd=$Password";

    $conn = New-Object MySql.Data.MySqlClient.MySqlConnection;
    $conn.ConnectionString = $connString;
    $conn.Open();

    $Command = New-Object MySql.Data.MySqlClient.MySqlCommand($q, $connString)
    $DataAdapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter($Command)
    $DataSet = New-Object System.Data.DataSet
    $RecordCount = $dataAdapter.Fill($dataSet, "data")
    return $DataSet.Tables[0]

    $conn.Close();
}

Write-Verbose "Attempting to import the MySQL .NET Connector DLL"
[System.Reflection.Assembly]::LoadWithPartialName("MySql.Data") | Out-Null
Write-Verbose "MySQL .NET Connector DLL has been imported"

Write-Verbose "Setting up data query"

#This is the base query it does by default get EVERYTHING so limit it where you can using OnlySpam or OnlyToday
$query = "SELECT * FROM maillog"

#Query builder for $OnlyToday to only include todays entries
if ($Today)
{
    if ($query -notlike '*where*')
    {
        $query += " where "
    }
    else 
    {
        $query += " and "
    }

    $DateToday = (get-date -uFormat "%Y-%m-%d");
    $query += "date='$DateToday'"
}

if ($Spam)
{
    if ($query -notlike '*where*')
    {
        $query += " where "
    }
    else 
    {
        $query += " and "
    }

    $query += "isspam='1'"
}

if ($NotSpam)
{
    if ($query -notlike '*where*')
    {
        $query += " where "
    }
    else 
    {
        $query += " and "
    }

    $query += "isspam='0'"
}

if ($To)
{
    if ($query -notlike '*where*')
    {
        $query += " where "
    }
    else 
    {
        $query += " and "
    }

    $query += "to_address='$To'"
}

if ($From)
{
    if ($query -notlike '*where*')
    {
        $query += " where "
    }
    else 
    {
        $query += " and "
    }

    $query += "from_address='$From'"
}

if ($TLD)
{
    if ($query -notlike '*where*')
    {
        $query += " where "
    }
    else
    {
        $query += " and "
    }

    $query += "from_address like '%.$TLD'"
}

Write-Verbose "Data query has been setup"

Write-Verbose "Querying database with $query"
GetDataFromDatabase($query);
Write-Verbose "Database results retrieved"