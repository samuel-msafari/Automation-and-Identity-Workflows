# Purpose: Identify inactive users in Microsoft Entra (Azure AD)
# Requirement: Microsoft Graph PowerShell Module
Select-MgProfile -Name beta
Connect-MgGraph -Scopes "User.Read.All","Directory.Read.All","AuditLog.Read.All"

$DaysInactive = 90
$CutOffDate   = (Get-Date).AddDays(-$DaysInactive)

$Users = Get-MgUser -All -Property "DisplayName,UserPrincipalName,SignInActivity"

$Report = $Users | Select-Object DisplayName, UserPrincipalName,
  @{Name="NeverSignedIn"; Expression={
      $null -eq $_.SignInActivity.LastSignInDateTime
  }},
  @{Name="LastSignIn"; Expression={
      $dt = $_.SignInActivity.LastSignInDateTime
      if ($null -eq $dt) { "Never" } else { $dt }
  }},
  @{Name="Inactive"; Expression={
      $dt = $_.SignInActivity.LastSignInDateTime
      ($null -eq $dt) -or ($dt -le $CutOffDate)
  }}

$Report |
  Where-Object { $_.Inactive } |
  Export-Csv -Path ".\Inactive_User_Audit.csv" -NoTypeInformation

Write-Host ("Audit Complete. {0} inactive accounts identified ({1} never signed in)." -f `
  ($Report | Where-Object Inactive).Count, `
  ($Report | Where-Object NeverSignedIn).Count)

