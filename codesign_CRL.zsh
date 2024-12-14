#!/bin/zsh

# Array of CRL URLs
CRL_URLS=("http://crl.usertrust.com/USERTrustRSACertificationAuthority.crl;44"
    "http://www.apple.com/appleca/root.crl"
    "http://www.apple.com/certificateauthority/root.crl"
    "http://crl.apple.com/softwareupdateca.crl"
    "http://crl.apple.com/timestamp.crl"
    "http://developer.apple.com/certificationauthority/wwdrca.crl"
    "http://crl.apple.com/apsrsa12g1.crl"
    "http://crl.apple.com/apsecc12g1.crl"
    "http://crl.apple.com/appleistca2g1.crl"
    "http://crl.apple.com/appleistca8g1.crl"
    "http://crl.apple.com/apevsrsa1g1.crl"
    "http://crl.apple.com/apevsrsa2g1.crl"
    "http://crl.apple.com/apevsrsaca3g1.crl"
    "http://crl.apple.com/apevsecc1g1.crl"
    "http://crl.apple.com/aptrsa1g1.crl"
    "http://crl.apple.com/aptecc1g1.crl"
"http://crl.usertrust.com/USERTrustECCCertificationAuthority.crl;15"
"http://crl3.digicert.com/DigiCertTrustedRootG4.crl;11"
"http://crl3.digicert.com/DigiCertHighAssuranceEVRootCA.crl;9"
"http://crl3.digicert.com/DigiCertTrustedG4CodeSigningRSA4096SHA3842021CA1.crl;9"
"http://crl4.digicert.com/DigiCertTrustedG4CodeSigningRSA4096SHA3842021CA1.crl;9"
"http://crl3.digicert.com/DigiCertAssuredIDRootCA.crl;8"
"http://crl4.digicert.com/DigiCertAssuredIDRootCA.crl;8"
"http://crl4.digicert.com/DigiCertHighAssuranceEVRootCA.crl;8"
"http://crl.sectigo.com/SectigoPublicCodeSigningCAR36.crl;7"
"http://crls.ssl.com/ssl.com-rsa-RootCA.crl;7"
"http://rootca2017-crl1.e-szigno.hu/rootca2017.crl;6"
"http://rootca2017-crl2.e-szigno.hu/rootca2017.crl;6"
"http://rootca2017-crl3.e-szigno.hu/rootca2017.crl;6"
"http://crl.comodoca.com/COMODORSACertificationAuthority.crl;5"
"http://crl3.digicert.com/DigiCertAssuredIDRootG2.crl;5"
"http://crl3.digicert.com/DigiCertCSRSA4096RootG5.crl;5"
"http://crl.certum.pl/ctnca.crl;4"
"http://crl.certum.pl/ctnca2.crl;4"
"http://crl.globalsign.com/codesigningrootr45.crl;4"
"http://crl.harica.gr/HaricaRootCA2015.crl;4"
"http://crl.sectigo.com/SectigoPublicCodeSigningRootR46.crl;4"
"http://crl3.digicert.com/DigiCertCSECCP384RootG5.crl;4"
"http://crl3.digicert.com/DigiCertGlobalRootG3.crl;4"
"http://crls.ssl.com/SSLcom-RootCA-EV-RSA-4096-R2.crl;4"
"http://repo.bjca.cn/global/crl/BJCA_Global_Root_CA1.crl;4"
"http://rtcrl.cybertrust.ne.jp/SecureSign/rtca14/cdp.crl;4"
"http://rtcrl.cybertrust.ne.jp/SecureSign/rtca15/cdp.crl;4"
"http://validation.identrust.com/crl/commercialrootca1.crl;4"
"http://crl.emsign.com?RootCAG3.crl;3"
"http://crl.entrust.net/g2ca.crl;3"
"http://crl.globalsign.com/root-r3.crl;3"
"http://crl.harica.gr/HaricaECCRootCA2015.crl;3"
"http://crls.ssl.com/ssl.com-ecc-RootCA.crl;3"
"http://repository.secomtrust.net/SC-Root2/SCRoot2CRL.crl;3"
"http://service.globaltrust.eu/static/globaltrust-2020.crl;3"
"http://crl.comodoca.com/AAACertificateServices.crl;2"
"http://crl.comodoca.com/COMODOECCCertificationAuthority.crl;2"
"http://crl.emsign.com?RootCAC3.crl;2"
"http://crl.entrust.net/csbr1.crl;2"
"http://crl.global.sheca.com/root/evg1.crl;2"
"http://crl.globalsign.com/gsgccr45codesignca2020.crl;2"
"http://crl.harica.gr/HARICA-CodeSigning-Root-2021-ECC.crl;2"
"http://crl.harica.gr/HARICA-CodeSigning-Root-2021-RSA.crl;2"
"http://crl.sectigo.com/SectigoPublicCodeSigningRootE46.crl;2"
"http://crl.wt.trustasia.com/TrustAsiaGlobalRootCAG3.crl;2"
"http://crl.wt.trustasia.com/TrustAsiaGlobalRootCAG4.crl;2"
"http://crl05.actalis.it/Repository/AUTH-ROOT/getLastCRL;2"
"http://crls.ssl.com/SSL.com-Enterprise-Intermediate-codeSigning-RSA-4096-R1.crl;2"
"http://crls.ssl.com/ssl.com-EVecc-RootCA.crl;2"
"http://crlv1.harica.gr/HaricaECCRootCA2015/crlv1.der.crl;2"
"http://repo.bjca.cn/global/crl/BJCA_Global_Root_CA2.crl;2"
"http://subca.crl.certum.pl/ctnca.crl;2"
"http://crl.cfca.com.cn/evrca/RSA/crl1.crl;1"
"http://crl.emsign.com/?rootcscag3.crl;1"
"http://crl.entrust.net/evcs2.crl;1"
"http://crl.firmaprofesional.com/fproot.crl;1"
"http://crl.gdca.com.cn/crl/GDCA_TrustAUTH_R5_ROOT.crl;1"
"http://crl.global.sheca.com/root/globalg2.crl;1"
"http://crl.globalsign.com/gsgccr45evcodesignca2020.crl;1"
"http://crl.globalsign.com/root-r5.crl;1"
"http://crl.globalsign.com/root-r6.crl;1"
"http://crl.globalsign.com/root.crl;1"
"http://crl.godaddy.com/gdroot-g2.crl;1"
"http://crl.godaddy.com/repository/gdroot-g2.crl;1"
"http://crl.izenpe.com/cgi-bin/crlinterna2;1"
"http://crl.sectigo.com/SectigoPublicCodeSigningCAEVE36.crl;1"
"http://crl.sslcom.cn/SSLcom-RootCA-EV-RSA-4096-R2.crl;1"
"http://crl.sslcom.cn/SSLcom-RootCA-RSA-4096-R1.crl;1"
"http://crl.starfieldtech.com/repository/sfroot-g2.crl;1"
"http://crl.starfieldtech.com/sfroot-g2.crl;1"
"http://crl.trust-provider.com/USERTrustECCCertificationAuthority.crl;1"
"http://crl.trust-provider.com/USERTrustRSACertificationAuthority.crl;1"
"http://crl.trustwave.com/STCA.crl;1"
"http://crl.trustwave.com/TWGCA.crl;1"
"http://crl.trustwave.com/TWGP256CA.crl;1"
"http://crl.trustwave.com/TWGP384CA.crl;1"
"http://crl.vikingcloud.com/TWGCA.crl;1"
"http://crl3.digicert.com/DigiCertGlobalG3CodeSigningECCSHA3842021CA1.crl;1"
"http://crl4.digicert.com/DigiCertGlobalG3CodeSigningECCSHA3842021CA1.crl;1"
"http://crls.ssl.com/SSLXYZ-Intermediate-codeSigning-RSA-4096-R1.crl;1"
"http://crls.ssl.com/SSLcom-RootCA-ECC-384-R1.crl;1"
"http://crls.ssl.com/SSLcom-RootCA-EV-ECC-384-R1.crl;1"
"http://crls.ssl.com/SSLcom-RootCA-RSA-4096-R1.crl;1"
"http://crls.ssl.com/SSLcom-SubCA-CodeSigning-RSA-4096-R1.crl;1"
"http://ldap2.sheca.com/root/evg1.crl;1"
"http://ldap2.sheca.com/root/globalg2.crl;1"
"http://pki-crl.atos.net/crl/Atos_TrustedRoot_CA_2011.crl;1"
"http://repository.secomtrust.net/SC-Root3/SCRoot3CRL.crl;1"
"http://validation.identrust.com/crl/trustidevcodesigning4.crl;1"
)

# Temporary directory to store downloaded CRLs
TEMP_DIR="/tmp/apple_crls"

# Create the temporary directory
mkdir -p "$TEMP_DIR"

# Loop over the CRL URLs
for CRL_URL in "${CRL_URLS[@]}"; do
    # Extract the filename from the URL
    FILENAME="$(basename "$CRL_URL")"
    CRL_FILE="$TEMP_DIR/$FILENAME"

    # Download the CRL
    echo "Downloading CRL from $CRL_URL..."
    curl -s -o "$CRL_FILE" "$CRL_URL"

    # Check if the download was successful
    if [[ $? -ne 0 ]]; then
        echo "Failed to download the CRL from $CRL_URL."
        continue
    fi

    # Import the CRL into the system keychain
    echo "Importing the CRL from $FILENAME into the system keychain..."
    sudo security import "$CRL_FILE" -f raw  -k "/Library/Keychains/System.keychain"

    # Check if the import was successful
    if [[ $? -ne 0 ]]; then
        echo "Failed to import the CRL from $FILENAME."
        continue
    fi
done

# Clean up the temporary directory
rm -rf "$TEMP_DIR"

echo "All CRLs have been processed."
