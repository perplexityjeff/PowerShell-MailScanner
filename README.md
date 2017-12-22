# PowerShell-MailScanner
This is a PowerShell script to query a MailScanner database using the MySQL .NET Connector to retrieve mail entries from the database.

## Usage
You can of course always use Get-Help .\Get-MailScan to get examples or help but the most general usage of the script could be as follows. 

Example that retrieves all mail entries that are marked as Spam and only from Today that are in the database.

```
./Get-MailScan -Server 127.0.0.1 -UserName user -Password example -Spam -Today
```
Use Format-Table, Select-Object and Get-Member to get the table how you want it. 

## Prerequisites
* The MySQL .NET Connector found at https://dev.mysql.com/downloads/connector/net/6.9.html. The script looks by default on location C:\Program Files (x86)\MySQL\MySQL Connector Net 6.10.5\Assemblies\v4.5.2\MySql.Data.dll however using -MySQLPath you are change it if you like.

* Remote Access to the MySQL or MariaDB database using a good secured user that can only 'Select' 

## Learning
I am still learning PowerShell and I do it mainly by just working as a day to day sysadmin. Please keep that in mind when viewing or using this script. 

## Credits
The idea came by a post found on the mailscanner mailing list found here.

http://lists.mailscanner.info/pipermail/mailscanner/2010-June/095932.html

## References
https://www.mailscanner.info/

http://mailwatch.org/

http://lists.mailscanner.info/pipermail/mailscanner/2010-June/095932.html

https://dev.mysql.com/downloads/connector/net/6.9.html

https://www.cogmotive.com/blog/powershell/querying-mysql-from-powershell

