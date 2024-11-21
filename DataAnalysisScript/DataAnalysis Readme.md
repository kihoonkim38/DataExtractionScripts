1. TLSChecker.ps1 (Requires OpenSSL)
    -Uses a file name EdgeBrowserHistory.txt to  iterate through a list of URLs (without http/https header in the url, example: www.example.com or example.com) and checks to see TLS Version the server is utlizing.

    *** OpenSSL download instruction: ***
    On Powershell run:
        choco install openssl   <- command to install OpenSSL
        openssl version   <- if it returns version, it is installed