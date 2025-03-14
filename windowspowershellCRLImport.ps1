# This PowerShell script downloads a list of CRLs and imports them into the Windows certificate store.
# Be sure to run this as Administrator.

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
    "http://crl.startssl.com/sfsca.crl",
    "http://crl.wt.trustasia.com/TrustAsiaGlobalRootCAG3.crl"
)

# Temporary directory to store downloaded CRLs
$tempDir = Join-Path $env:TEMP "apple_crls"

# Create the temporary directory if it doesn't exist
if (!(Test-Path -Path $tempDir)) {
    New-Item -ItemType Directory -Path $tempDir | Out-Null
}

foreach ($url in $crlUrls) {
    # Extract the filename from the URL
    $filename = Split-Path -Path $url -Leaf
    $crlFile = Join-Path -Path $tempDir -ChildPath $filename

    Write-Host "Downloading CRL from $url..."
    try {
        Invoke-WebRequest -Uri $url -OutFile $crlFile -ErrorAction Stop
    }
    catch {
        Write-Host "Failed to download the CRL from $url."
        continue
    }

    Write-Host "Importing the CRL from $filename into the system certificate store..."
    # Import the CRL using certutil. (Store "ROOT" is chosen here.)
    & certutil -addstore -f "ROOT" $crlFile

    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to import the CRL from $filename."
        continue
    }
}

# Clean up the temporary directory
Remove-Item -Path $tempDir -Recurse -Force

Write-Host "All CRLs have been processed."
