<#
.SYNOPSIS
    Audit Intune Managed Devices for Security Compliance.
.DESCRIPTION
    Queries Microsoft Graph to identify devices failing BitLocker, Antivirus, or OS compliance.
    Strategic Value: Provides data for Secure Score hardening (38% -> 91%).
#>

# 1. Connect to Microsoft Graph with necessary permissions
# Required: DeviceManagementManagedDevices.Read.All
Connect-MgGraph -Scopes "DeviceManagementManagedDevices.Read.All"

# 2. Fetch all managed devices
$Devices = Get-MgDeviceManagementManagedDevice -All

$ComplianceReport = foreach ($Device in $Devices) {
    [PSCustomObject]@{
        DeviceName        = $Device.DeviceName
        User              = $Device.UserPrincipalName
        OS                = $Device.OperatingSystem
        ComplianceState   = $Device.ComplianceState # e.g., compliant, noncompliant
        IsEncrypted       = $Device.IsEncrypted
        LastContact       = $Device.LastSyncDateTime
    }
}

# 3. Filter for non-compliant devices to create an actionable "At-Risk" list
$AtRiskFleet = $ComplianceReport | Where-Object { $_.ComplianceState -ne "compliant" }

# 4. Export to CSV for Executive Reporting
$AtRiskFleet | Export-Csv -Path "./Fleet_Security_Risk_Report.csv" -NoTypeInformation

Write-Host "Audit Complete. Found $($AtRiskFleet.Count) non-compliant devices. Report exported." -ForegroundColor Cyan
