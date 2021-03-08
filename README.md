# PowerShell-MailScanner
This is a PowerShell script to query a MailScanner database using the MySQL .NET Connector to retrieve mail entries from the database based on various filters to query and end up with just the data you want.

## Usage
You can of course always use Get-Help .\Get-MailScan to get examples or help but the most general usage of the script could be as follows. 

Example that retrieves all mail entries that are marked as Spam and only from Today that are in the database.

```
./Get-MailScan -Server 127.0.0.1 -UserName user -Password example -Spam -Today
```
Use Format-Table, Select-Object and Get-Member to get the table how you want it. 

## Options

<table>
  <tr>
    <td><tt>-LastWeek</tt></td>
	  <td>Default filter to query for mail between today and last week</td>
  </tr>
  <tr>
    <td><tt>-Today</tt></td>
	  <td>Default filter to query for mail that arrived today</td>
  </tr>
  <tr>
    <td><tt>-Virus</tt></td>
	  <td>Default filter to query for mail that was detected as a virus</td>
  </tr>
  <tr>
    <td><tt>-Spam</tt></td>
	  <td>Default filter to query for mail that was detected as a spam</td>
  </tr>
  <tr>
    <td><tt>-NotSpam</tt></td>
	  <td>Default filter to query for mail that was detected as a non-spam</td>
  </tr>
  <tr>
    <td><tt>-To</tt></td>
	  <td>Default filter to query for mail based on a To address this contains wildcards</td>
  </tr>
  <tr>
    <td><tt>-From</tt></td>
	  <td>Default filter to query for mail based on a From address this contains wildcards</td>
  </tr>
  <tr>
    <td><tt>-ToDomain</tt></td>
	  <td>Default filter to query for mail based on a mail domain</td>
  </tr>
  <tr>
    <td><tt>-Subject</tt></td>
	  <td>Default filter to query for mail based on the subject line of a mail</td>
  </tr>
</table>

## Prerequisites
* The MySQL .NET Connector found at https://dev.mysql.com/downloads/connector/net/8.html. 

The script looks by default on location `C:\Program Files (x86)\MySQL\MySQL Connector Net 8.0.23\Assemblies\v4.5.2\MySql.Data.dll` however using `-MySQLPath` you can change it if you like.

* Remote Access to the MySQL or MariaDB database using a good secured user that can only 'Select' 

## Learning
I am still learning PowerShell and I do it mainly by just working as a day to day sysadmin. Please keep that in mind when viewing or using this script. I am open to pull requests to improve the project of course. 

## Credits
The idea came by a post found on the mailscanner mailing list found here.

http://lists.mailscanner.info/pipermail/mailscanner/2010-June/095932.html

## References
https://www.mailscanner.info/

http://mailwatch.org/

http://lists.mailscanner.info/pipermail/mailscanner/2010-June/095932.html

https://dev.mysql.com/downloads/connector/net/8.html

https://www.cogmotive.com/blog/powershell/querying-mysql-from-powershell

