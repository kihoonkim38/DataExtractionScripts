<# Description: This script extracts AD data into an excel workbook, 1 worksheet per command.
There are 23 out of 43(Get-Command Get-AD*) commands that are able to utilize 
the "-Filter * -Proerties *" Paramter.

Extract Active Directory data for the following commands(23):
Get-ADAuthenticationPolicy, Get-ADAuthenticationPolicySilo, Get-ADCentralAccessPolicy, Get-ADCentralAccessRule,
Get-ADClaimTransformPolicy, Get-ADClaimType, Get-ADComputer, Get-ADFineGrainedPasswordPolicy, Get-ADGroup
Get-ADObject, Get-ADOptionalFeature, Get-ADOrganizationalUnit, Get-ADReplicationConnection, Get-ADReplicationSite
Get-ADReplicationSiteLink, Get-ADReplicationSiteLinkBridge, Get-ADReplicationSubnet, Get-ADResourceProperty
Get-ADResourcePropertyList, Get-ADResourcePropertyValueType, Get-ADServiceAccount, Get-ADTrust, Get-ADUser

Purpose: To extract Active Directory data for auditing/accessibility.
#>

$adCommands = Get-Command Get-AD*

$results = @{ 
    WorksWithFilter = @()
    ErrorWithFilter = @()
}

foreach ($cmd in $adCommands) {
   try {
        #This is the only command that requires additional filters, it will not be part of the workbook
        if ($cmd.Name -eq 'Get-ADReplicationAttributeMetadata') {
            & $cmd -Object * -Server * -Filter * -Properties * -ErrorAction Stop
        }
        else {
            & $cmd -Filter * -Properties * -ErrorAction Stop
        }
        $results.WorksWithFilter += $cmd.Name
    }
        catch {
        $results.ErrorWithFilter += $cmd.Name
    }
}

$excel = New-Object -ComObject Excel.Application
$excel.Visible = $true
$workbook = $excel.Workbooks.Add()

foreach($cmd in $results.WorksWithFilter) {
   $ws = $workbook.Worksheets.Add()
    $ws.Name = $cmd
    $row = 1
            
    try {
      $output = & $cmd -Filter * -Properties *
      foreach($item in $output) {
        foreach($property in $item.PSObject.Properties) {
          $ws.Cells($row, 1) = $property.Name
          $ws.Cells($row, 2) = $property.Value
          $row++
        }
      }
    }
    catch {
    $ws.Cells($row, 1) = "Error executing command"
    }
}

$workbook.SaveAs("AD_Commands_Output.xlsx")
