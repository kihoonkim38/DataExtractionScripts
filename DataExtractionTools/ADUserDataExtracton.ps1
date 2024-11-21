#Simple Script to grab all AD-user/AD-Group data extraction to view on spreadsheet

$currentDate = Get-Date -Format "MM_dd_yyyy_HH_mm_ss"
Get-ADUser -Filter * -properties * | Export-CSV -Path "ADUser_DataExtract_$currentDate.csv"
Get-ADGroup -Filter * -properties * | Export-CSV -Path "ADGroup_DataExtract_$currentDate.csv"


