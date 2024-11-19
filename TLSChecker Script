# Read URLs from file
$urls = Get-Content -Path "EdgeBrowserHistory.txt"

foreach ($url in $urls) {
    $ports = @(443)
    foreach ($port in $ports) {
        Write-Host "`nTesting TLS versions for $url`:$port" -ForegroundColor Cyan
        Write-Host "----------------------------------------" -ForegroundColor Cyan
        
        # Test each TLS version
        $tlsVersions = @(
            "tls1",      # TLS 1.0
            "tls1_1",    # TLS 1.1
            "tls1_2",    # TLS 1.2
            "tls1_3"     # TLS 1.3
        )
        
        foreach ($version in $tlsVersions) {
            Write-Host "Testing TLS $version..." -NoNewline
            $result = openssl s_client -connect ${url}:${port} -$version -brief 2>&1
            if ($result -match "CONNECTION ESTABLISHED") {
                Write-Host " Supported" -ForegroundColor Green
            } else {
                Write-Host " Not Supported" -ForegroundColor Red
            }
        }
    }
}
