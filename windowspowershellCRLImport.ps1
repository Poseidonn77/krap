# Windows PowerShell Script to Download and Import CRLs

# Array of CRL URLs
$CRL_URLS = @(
    "https://www.apple.com/appleca/root.crl",
    "https://www.apple.com/certificateauthority/root.crl",
    "https://crl.apple.com/softwareupdateca.crl",
    "https://crl.apple.com/timestamp.crl",
    "https://developer.apple.com/certificationauthority/wwdrca.crl",
    "https://crl.apple.com/apsrsa12g1.crl",
    "https://crl.apple.com/apsecc12g1.crl",
    "https://crl.apple.com/appleistca2g1.crl",
    "https://crl.apple.com/appleistca8g1.crl",
    "https://crl.apple.com/apevsrsa1g1.crl",
    "https://crl.apple.com/apevsrsa2g1.crl",
    "https://crl.apple.com/apevsrsaca3g1.crl",
    "https://crl.apple.com/apevsecc1g1.crl",
    "https://crl.apple.com/aptrsa1g1.crl",
    "https://crl.apple.com/aptecc1g1.crl",
    "http://crl.emsign.com/RootCAG2.crl",
    "http://crl.emsign.com/RootCAG3.crl",
    "http://crl.emsign.com/RootCAC2.crl",
    "http://crl.emsign.com/RootCAC3.crl",
    "http://crl.emsign.com/rootcscag2.crl",
    "http://crl.emsign.com/rootcscag3.crl",
    "http://crl.usertrust.com/USERTrustRSACertificationAuthority.crl",
    "http://crl.usertrust.com/USERTrustECCCertificationAuthority.crl",
    "http://crl3.digicert.com/DigiCertTrustedRootG4.crl",
    "http://crl3.digicert.com/DigiCertHighAssuranceEVRootCA.crl",
    "http://crl3.digicert.com/DigiCertTrustedG4CodeSigningRSA4096SHA3842021CA1.crl",
    "http://crl4.digicert.com/DigiCertTrustedG4CodeSigningRSA4096SHA3842021CA1.crl",
    "http://crl3.digicert.com/DigiCertAssuredIDRootCA.crl",
    "http://crl4.digicert.com/DigiCertAssuredIDRootCA.crl",
    "http://crl4.digicert.com/DigiCertHighAssuranceEVRootCA.crl",
    "http://crl.sectigo.com/SectigoPublicCodeSigningCAR36.crl",
    "http://crls.ssl.com/ssl.com-rsa-RootCA.crl",
    "http://rootca2017-crl1.e-szigno.hu/rootca2017.crl",
    "http://rootca2017-crl2.e-szigno.hu/rootca2017.crl",
    "http://rootca2017-crl3.e-szigno.hu/rootca2017.crl",
    "http://crl.comodoca.com/COMODORSACertificationAuthority.crl",
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
    "http://www.microsoft.com/pkiops/crl/MicCodSigPCA2011_2011-07-08.crl",
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
    "http://crl.globalsign.com/gsgccr45codesignca2020.crl",
    "http://crl.harica.gr/HARICA-CodeSigning-Root-2021-ECC.crl",
    "http://crl.harica.gr/HARICA-CodeSigning-Root-2021-RSA.crl",
    "http://crl.sectigo.com/SectigoPublicCodeSigningRootE46.crl",
    "http://crl.startssl.com/sfsca.crl",
    "http://crl.wt.trustasia.com/TrustAsiaGlobalRootCAG3.crl",
    "http://crl.wt.trustasia.com/TrustAsiaGlobalRootCAG4.crl",
    "http://crl05.actalis.it/Repository/AUTH-ROOT/getLastCRL",
    "http://crls.ssl.com/SSL.com-Enterprise-Intermediate-codeSigning-RSA-4096-R1.crl",
    "http://crls.ssl.com/ssl.com-EVecc-RootCA.crl",
    "http://crls.ssl.com/SSLcom-CodeSigning-Root-2022-RSA.crl",
    "http://crls.ssl.com/SSLcom-RootCA-ECC-384-R1.crl",
    "http://crls.ssl.com/SSLcom-RootCA-EV-ECC-384-R1.crl",
    "http://crls.ssl.com/SSLcom-RootCA-RSA-4096-R1.crl",
    "http://crls.ssl.com/SSLcom-SubCA-CodeSigning-RSA-4096-R1.crl",
    "http://crls.ssl.com/ssl.com-EVrsa-RootCA.crl",
    "http://g.symcb.com/GeoTrustPCA.crl",
    "http://pki-crl.atos.net/crl/Atos_TrustedRoot_CA_2011.crl",
    "http://repository.secomtrust.net/SC-Root3/SCRoot3CRL.crl",
    "http://s.symcb.com/pca3-g5.crl",
    "http://s.symcb.com/universal-root.crl",
    "http://t.symcb.com/ThawtePCA-G3.crl",
    "http://validation.identrust.com/crl/trustidevcodesigning4.crl",
    "http://www.anf.es/crl/ANF_Global_Root_CA_SHA1.crl",
    "http://www.apple.com/appleca/root.crl",
    "http://www.microsoft.com/pkiops/crl/Microsoft%20ECC%20Product%20Root%20Certificate%20Authority%202018.crl",
    "http://www.microsoft.com/pkiops/crl/Microsoft%20Windows%20Third%20Party%20Component%20CA%202012.crl"
)

# Temporary directory to store downloaded CRLs
$TEMP_DIR = "$env:TEMP\apple_crls"

# Create the temporary directory
New-Item -ItemType Directory -Path $TEMP_DIR -Force | Out-Null

# Function to Validate URL Format
function Validate-CRLUrl {
    param (
        [string]$url
    )

    # Check if the URL starts with http:// or https://
    if ($url -notmatch "^https?://") {
        return $false
    }

    # Basic URI validation
    try {
        $uri = [System.Uri]$url
        return $true
    }
    catch {
        return $false
    }
}

# Loop over the CRL URLs
foreach ($CRL_URL in $CRL_URLS) {
    # Validate the URL
    if (-not (Validate-CRLUrl -url $CRL_URL)) {
        Write-Warning "Invalid URL format: $CRL_URL. Skipping..."
        continue
    }

    # Extract the filename from the URL
    $FILENAME = [System.IO.Path]::GetFileName($CRL_URL.Split('?')[0])  # Remove query parameters if any
    $CRL_FILE = Join-Path $TEMP_DIR $FILENAME

    # Download the CRL
    Write-Output "Downloading CRL from $CRL_URL..."
    try {
        Invoke-WebRequest -Uri $CRL_URL -OutFile $CRL_FILE -ErrorAction Stop
    }
    catch {
        Write-Warning "Failed to download the CRL from $CRL_URL. Error: $_"
        continue
    }

    # Import the CRL into the system certificate store
    Write-Output "Importing the CRL from $FILENAME into the system certificate store..."
    try {
        # Use certutil to add CRL to the 'CA' store
        certutil -addstore -f "CA" $CRL_FILE | Out-Null
    }
    catch {
        Write-Warning "Failed to import the CRL from $FILENAME. Error: $_"
        continue
    }
}

# Clean up the temporary directory
Remove-Item -Path $TEMP_DIR -Recurse -Force -ErrorAction SilentlyContinue

Write-Output "All CRLs have been processed."