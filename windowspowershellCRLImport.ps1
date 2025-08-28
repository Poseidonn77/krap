# Downloads CRLs and imports them into the Windows certificate stores.
# Run this in an elevated PowerShell (Run as Administrator).

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

# Prefer modern TLS for HTTPS endpoints (ignored for HTTP)
try {
    [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
} catch { }

# Array of CRL URLs
$crlUrls = @(
    "http://crl.usertrust.com/USERTrustRSACertificationAuthority.crl",
    "http://crl.usertrust.com/USERTrustECCCertificationAuthority.crl",
    "http://crl3.digicert.com/DigiCertTrustedRootG4.crl",
    "http://crl3.digicert.com/DigiCertHighAssuranceEVRootCA.crl",
    "http://crl3.digicert.com/DigiCertTrustedG4CodeSigningRSA4096SHA3842021CA1.crl",
    "http://crl4.digicert.com/DigiCertTrustedG4CodeSigningRSA4096SHA3842021CA1.crl",
    "http://crl3.digicert.com/DigiCertAssuredIDRootCA.crl",
    "http://crl4.digicert.com/DigiCertAssuredIDRootCA.crl",
    "http://crl4.digicert.com/DigiCertHighAssuranceEVRootCA.crl",
    "http://crls.ssl.com/ssl.com-rsa-RootCA.crl",
    "http://rootca2017-crl1.e-szigno.hu/rootca2017.crl",
    "http://rootca2017-crl2.e-szigno.hu/rootca2017.crl",
    "http://rootca2017-crl3.e-szigno.hu/rootca2017.crl",
    "http://crl.comodoca.com/COMODORSACertificationAuthority.crl",
    "http://crl.sectigo.com/SectigoPublicCodeSigningCAR36.crl",
    "http://crl3.digicert.com/DigiCertAssuredIDRootG2.crl",
    "http://crl3.digicert.com/DigiCertCSRSA4096RootG5.crl",
    "http://crl.certum.pl/ctnca.crl",
    "http://crl.certum.pl/ctnca2.crl",
    "http://crl.globalsign.com/codesigningrootr45.crl",
    "http://crl.harica.gr/HaricaRootCA2015.crl",
    "http://crl.sectigo.com/SectigoPublicCodeSigningRootR46.crl",
    "http://crl3.digicert.com/DigiCertCSECCP384RootG5.crl",
    "http://crl3.digicert.com/DigiCertGlobalRootG3.crl",
    "http://crls.ssl.com/SSLcom-RootCA-EV-RSA-4096-R2.crl",
    "http://repo.bjca.cn/global/crl/BJCA_Global_Root_CA1.crl",
    "http://rtcrl.cybertrust.ne.jp/SecureSign/rtca14/cdp.crl",
    "http://rtcrl.cybertrust.ne.jp/SecureSign/rtca15/cdp.crl",
    "http://validation.identrust.com/crl/commercialrootca1.crl",
    "http://crl.emsign.com?RootCAG2.crl",
    "http://crl.emsign.com?RootCAG3.crl",
    "http://crl.entrust.net/g2ca.crl",
    "http://crl.globalsign.com/root-r3.crl",
    "http://crl.harica.gr/HaricaECCRootCA2015.crl",
    "http://crl.microsoft.com/pki/crl/products/MicRooCerAut2011_2011_03_22.crl",
    "http://crls.ssl.com/ssl.com-ecc-RootCA.crl",
    "http://crls1.wosign.com/ca1.crl",
    "http://repository.secomtrust.net/SC-Root2/SCRoot2CRL.crl",
    "http://service.globaltrust.eu/static/globaltrust-2020.crl",
    "http://crl.comodoca.com/AAACertificateServices.crl",
    "http://crl.comodoca.com/COMODOECCCertificationAuthority.crl",
    "http://crl.emsign.com?RootCAC2.crl",
    "http://crl.emsign.com?RootCAC3.crl",
    "http://crl.entrust.net/csbr1.crl",
    "http://crl.global.sheca.com/root/evg1.crl",
    "http://crl.harica.gr/HARICA-CodeSigning-Root-2021-ECC.crl",
    "http://crl.harica.gr/HARICA-CodeSigning-Root-2021-RSA.crl",
    "http://crl.sectigo.com/SectigoPublicCodeSigningRootE46.crl",
    "http://crl.startssl.com/sfsca.crl"
)

# Target certificate store for CRLs: use CA (Intermediate CAs) by default.
$targetStore = 'CA'

# Temporary directory to store downloaded CRLs
$tempDir = Join-Path $env:TEMP "crl_import"
New-Item -ItemType Directory -Path $tempDir -Force | Out-Null

# For Windows PowerShell, use basic parsing to avoid IE engine
$useBasicParsing = $PSVersionTable.PSEdition -eq 'Desktop'

foreach ($url in $crlUrls | Where-Object { $_ -and $_.Trim() -ne '' } | Select-Object -Unique) {
    $filename = Split-Path -Path $url -Leaf
    if (-not $filename) { $filename = [Guid]::NewGuid().ToString() + '.crl' }
    $crlFile = Join-Path -Path $tempDir -ChildPath $filename

    Write-Host "Downloading CRL from $url..."
    try {
        Invoke-WebRequest -Uri $url -OutFile $crlFile -UseBasicParsing:$useBasicParsing -ErrorAction Stop
    } catch {
        Write-Warning "Failed to download CRL: $url (`$($_.Exception.Message)`)"
        continue
    }

    if (-not (Test-Path -LiteralPath $crlFile) -or (Get-Item -LiteralPath $crlFile).Length -eq 0) {
        Write-Warning "Downloaded file is missing or empty: $filename"
        continue
    }

    Write-Host "Importing CRL into '$targetStore' store: $filename"
    & certutil -addstore -f $targetStore $crlFile | Out-Null
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "certutil failed for $filename with exit code $LASTEXITCODE"
        continue
    }
}

Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue
Write-Host "All CRLs processed."
