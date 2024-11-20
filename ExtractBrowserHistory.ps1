<#
- Extracts visited website URLs from current user's Chrome and Edge browsers
- Parses URLs into component parts (protocol, subdomains, domain, TLD)
- Exports results in CSV format for easy analysis
#>

# extracts from Chrome history location, matching the regexp expression below
$ChromeHistory = Get-Content "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\History" -Raw | 
    Select-String -Pattern '(http|https)://[\w\-\.]+(?::\d+)?(?:/[\w\-\./\?\%\&\=\#\:\+\$\;\~\@]*)?(?:\?\S*)?(?:\#\S*)?' -AllMatches |
    Select-Object -ExpandProperty Matches |
    Select-Object -ExpandProperty Value

# Grabs current user Edge History with full paths of URL
$EdgeHistory = Get-Content "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\History" -Raw |
    Select-String -Pattern '(http|https)://[\w\-\.]+(?::\d+)?(?:/[\w\-\./\?\%\&\=\#\:\+\$\;\~\@]*)?(?:\?\S*)?(?:\#\S*)?' -AllMatches |
    Select-Object -ExpandProperty Matches |
    Select-Object -ExpandProperty Value

# Export to file
$ChromeOutput = @()
$EdgeOutput = @()

$ChromeOutput += "Chrome History:"
$ChromeOutput += $ChromeHistory
$EdgeOutput += "Edge History:"
$EdgeOutput += $EdgeHistory

$ChromeOutput | Out-File "$env:USERPROFILE\Desktop\ChromeBrowserHistory.txt"
$EdgeOutput | Out-File "$env:USERPROFILE\Desktop\EdgeBrowserHistory.txt"
