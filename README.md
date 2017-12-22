# PowerShell-MailScanner
This is a PowerShell script to query a MailScanner database using the MySQL .NET Connector to retrieve mail entries from the database.

## Usage
You can of course always use Get-Help .\Get-MailScan to get examples or help but the most general usage of the script could be as follows. 

Example that retrieves all mail entries that are marked as Spam and only from Today that are in the database

```
./Get-MailScan -Server 127.0.0.1 -UserName user -Password example -Spam -Today
```

## Prerequisites
* The MySQL .NET Connector found at https://dev.mysql.com/downloads/connector/net/6.9.html. The script looks by default on location C:\Program Files (x86)\MySQL\MySQL Connector Net 6.10.5\Assemblies\v4.5.2\MySql.Data.dll however using -MySQLPath you are change it if you like.

* Remote Access to the MySQL or MariaDB database using preferably a good secured user that can only 'Select' 

## Learning
I am still learning PowerShell everyday and I do it mainly by just working as a day to day sysadmin. Please keep that in mind when viewing or using this script. 
