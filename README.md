# PowerShell-MailScanner
This is a PowerShell script to query a MailScanner database using the MySQL .NET Connector to retrieve mail entries from the database.

##Usage
You can of course always use Get-Help .\Get-MailScan to get examples or help but the most general usage of the script could be as follows. 

```
./Get-MailScan -Server 127.0.0.1 -UserName user -Password example -Spam -Today
Example that retrieves all mail entries that are marked as Spam and only from Today that are in the database
```

##Prerequisites
The MySQL .NET Connector: https://dev.mysql.com/downloads/connector/net/6.9.html

##Learning
I am still learning PowerShell everyday and I do it mainly by just working as a day to day sysadmin. Please keep that in mind when viewing or using this script. 
