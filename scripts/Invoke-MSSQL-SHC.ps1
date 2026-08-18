param (
    [string]$PrimaryHost = "."
)

# Report location
$ReportFile = "C:\Temp\MSSQL_SHC_Report.txt"

# Get SQL Service Status
$Service = Get-Service -Name MSSQLSERVER -ErrorAction SilentlyContinue

if ($Service) {
    $ServiceStatus = $Service.Status
}
else {
    $ServiceStatus = "SQL Service Not Found"
}

# Build output
$Results = @()
$Results += "========================================="
$Results += "MSSQL Security Health Check"
$Results += "========================================="
$Results += "Server: $env:COMPUTERNAME"
$Results += "Primary Host: $PrimaryHost"
$Results += "Date: $(Get-Date)"
$Results += "SQL Service Status: $ServiceStatus"
$Results += "========================================="

# Write report to file
$Results | Out-File -FilePath $ReportFile -Encoding UTF8

# Display output in AAP
$Results | ForEach-Object {
    Write-Output $_
}
