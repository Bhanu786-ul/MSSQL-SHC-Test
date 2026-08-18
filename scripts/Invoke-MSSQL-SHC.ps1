param(
    [string]$PrimaryHost = "."
)

$ErrorActionPreference = "Stop"

$query = @"
SELECT @@SERVERNAME AS ServerName;
"@

$result = Invoke-Sqlcmd `
    -ServerInstance $PrimaryHost `
    -Database "master" `
    -Query $query `
    -ErrorAction Stop

$serverName = $result.ServerName

if ([string]::IsNullOrWhiteSpace($serverName)) {
    $status = "VIOLATION"
}
else {
    $status = "COMPLIANT"
}

[PSCustomObject]@{
    CheckId     = "SQL_SHC_001"
    Description = "SQL Server Instance Name"
    Scope       = "INSTANCE"
    Status      = $status
    ServerName  = $serverName
    Timestamp   = (Get-Date).ToUniversalTime().ToString("o")
} | ConvertTo-Json -Depth 5
