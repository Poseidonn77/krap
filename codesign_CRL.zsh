#!/bin/zsh

CRL_URLS=(
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
"http://crl.usertrust.com/USERTrustRSACertificationAuthority.crl"
"http://crl.usertrust.com/USERTrustECCCertificationAuthority.crl"
"http://crl3.digicert.com/DigiCertTrustedRootG4.crl"
"http://crl3.digicert.com/DigiCertHighAssuranceEVRootCA.crl"
"http://crl3.digicert.com/DigiCertAssuredIDRootCA.crl"
"http://crl4.digicert.com/DigiCertAssuredIDRootCA.crl"
"http://crl4.digicert.com/DigiCertHighAssuranceEVRootCA.crl"
"http://crl3.digicert.com/DigiCertTrustedG4CodeSigningRSA4096SHA3842021CA1.crl"
"http://crl4.digicert.com/DigiCertTrustedG4CodeSigningRSA4096SHA3842021CA1.crl"
"http://crls.ssl.com/ssl.com-rsa-RootCA.crl"
"http://rootca2017-crl1.e-szigno.hu/rootca2017.crl"
"http://rootca2017-crl2.e-szigno.hu/rootca2017.crl"
"http://rootca2017-crl3.e-szigno.hu/rootca2017.crl"
"http://crl.comodoca.com/COMODORSACertificationAuthority.crl"
"http://crl3.digicert.com/DigiCertAssuredIDRootG2.crl"
"http://crl3.digicert.com/DigiCertCSRSA4096RootG5.crl"
"http://crl.certum.pl/ctnca.crl"
"http://crl.certum.pl/ctnca2.crl"
"http://crl.emsign.com/?rootcscag2.crl"
"http://crl.emsign.com/?rootcscag3.crl"
"http://crl.globalsign.com/codesigningrootr45.crl"
"http://crl.harica.gr/HaricaRootCA2015.crl"
"http://crl.sectigo.com/SectigoPublicCodeSigningCAR36.crl"
"http://crl.sectigo.com/SectigoPublicCodeSigningRootR46.crl"
"http://crl3.digicert.com/DigiCertCSECCP384RootG5.crl"
"http://crl3.digicert.com/DigiCertGlobalRootG3.crl"
"http://crls.ssl.com/SSLcom-RootCA-EV-RSA-4096-R2.crl"
"http://repo.bjca.cn/global/crl/BJCA_Global_Root_CA1.crl"
"http://rtcrl.cybertrust.ne.jp/SecureSign/rtca14/cdp.crl"
"http://rtcrl.cybertrust.ne.jp/SecureSign/rtca15/cdp.crl"
"http://validation.identrust.com/crl/commercialrootca1.crl"
"http://crl.emsign.com?RootCAG2.crl"
"http://crl.emsign.com?RootCAG3.crl"
"http://crl.entrust.net/g2ca.crl"
"http://crl.globalsign.com/root-r3.crl"
"http://crl.harica.gr/HaricaECCRootCA2015.crl"
"http://crl.microsoft.com/pki/crl/products/MicRooCerAut2011_2011_03_22.crl"
"http://crls.ssl.com/ssl.com-ecc-RootCA.crl"
"http://repository.secomtrust.net/SC-Root2/SCRoot2CRL.crl"
"http://service.globaltrust.eu/static/globaltrust-2020.crl"
"http://crl.comodoca.com/AAACertificateServices.crl"
"http://crl.comodoca.com/COMODOECCCertificationAuthority.crl"
"http://crl.emsign.com?RootCAC2.crl"
"http://crl.emsign.com?RootCAC3.crl"
"http://crl.entrust.net/csbr1.crl"
"http://crl.global.sheca.com/root/evg1.crl"
"http://crl.harica.gr/HARICA-CodeSigning-Root-2021-ECC.crl"
"http://crl.harica.gr/HARICA-CodeSigning-Root-2021-RSA.crl"
"http://crl.sectigo.com/SectigoPublicCodeSigningRootE46.crl"
"http://crl.startssl.com/sfsca.crl"
"http://crl.wt.trustasia.com/TrustAsiaGlobalRootCAG3.crl"
"http://crl.wt.trustasia.com/TrustAsiaGlobalRootCAG4.crl"
"http://crl05.actalis.it/Repository/AUTH-ROOT/getLastCRL"
"http://crls.ssl.com/SSL.com-Enterprise-Intermediate-codeSigning-RSA-4096-R1.crl"
"http://crls.ssl.com/ssl.com-EVecc-RootCA.crl"
"http://crls1.wosign.com/ca1.crl"
"http://crlv1.harica.gr/HaricaECCRootCA2015/crlv1.der.crl"
"http://repo.bjca.cn/global/crl/BJCA_Global_Root_CA2.crl"
"http://subca.crl.certum.pl/ctnca.crl"
"http://www.microsoft.com/pkiops/crl/MicCodSigPCA2011_2011-07-08.crl"
"http://crl.apple.com/codesigning.crl"
"http://crl.apple.com/codesigningcag2.crl"
"http://crl.apple.com/root.crl"
"http://crl.cfca.com.cn/evrca/RSA/crl1.crl"
"http://crl.firmaprofesional.com/fproot.crl"
"http://crl.gdca.com.cn/crl/GDCA_TrustAUTH_R5_ROOT.crl"
"http://crl.geotrust.com/crls/msftentmobilerootca.crl"
"http://crl.global.sheca.com/root/globalg2.crl"
"http://crl.globalsign.com/gsgccr45codesignca2020.crl"
"http://crl.globalsign.com/gsgccr45evcodesignca2020.crl"
"http://crl.globalsign.com/root-r5.crl"
"http://crl.globalsign.com/root-r6.crl"
"http://crl.globalsign.com/root.crl"
"http://crl.godaddy.com/gdroot-g2.crl"
"http://crl.godaddy.com/repository/gdroot-g2.crl"
"http://crl.izenpe.com/cgi-bin/crlinterna2"
"http://crl.microsoft.com/pki/crl/products/MicRooCerAut_2010-06-23.crl"
"http://crl.sectigo.com/SectigoPublicCodeSigningCAEVE36.crl"
"http://crl.sslcom.cn/SSLcom-RootCA-EV-RSA-4096-R2.crl"
"http://crl.sslcom.cn/SSLcom-RootCA-RSA-4096-R1.crl"
"http://crl.starfieldtech.com/repository/sfroot-g2.crl"
"http://crl.starfieldtech.com/sfroot-g2.crl"
"http://crl.trust-provider.com/USERTrustECCCertificationAuthority.crl"
"http://crl.trust-provider.com/USERTrustRSACertificationAuthority.crl"
"http://crl.trustcor.ca/root/ca1.crl"
"http://crl.trustcor.ca/root/ca2.crl"
"http://crl.trustwave.com/STCA.crl"
"http://crl.trustwave.com/TWGCA.crl"
"http://crl.trustwave.com/TWGP256CA.crl"
"http://crl.trustwave.com/TWGP384CA.crl"
"http://crl.vikingcloud.com/TWGCA.crl"
"http://crl1.camerfirma.com/chambersignroot-2008.crl"
"http://crl1.camerfirma.com/chambersofcommerceroot-2016.crl"
"http://crl1.camerfirma.com/chambersroot-2008.crl"
"http://crl3.digicert.com/DigiCertGlobalG3CodeSigningECCSHA3842021CA1.crl"
"http://crl4.digicert.com/DigiCertGlobalG3CodeSigningECCSHA3842021CA1.crl"
"http://crls.ssl.com/SSLXYZ-Intermediate-codeSigning-RSA-4096-R1.crl"
"http://crls.ssl.com/SSLcom-CodeSigning-Root-2022-RSA.crl"
"http://crls.ssl.com/SSLcom-RootCA-ECC-384-R1.crl"
"http://crls.ssl.com/SSLcom-RootCA-EV-ECC-384-R1.crl"
"http://crls.ssl.com/SSLcom-RootCA-RSA-4096-R1.crl"
"http://crls.ssl.com/SSLcom-SubCA-CodeSigning-RSA-4096-R1.crl"
"http://crls.ssl.com/ssl.com-EVrsa-RootCA.crl"
"http://crls2.wosign.cn/ca2.crl"
"http://g.symcb.com/GeoTrustPCA.crl"
"http://ldap2.sheca.com/root/evg1.crl"
"http://ldap2.sheca.com/root/globalg2.crl"
"http://pki-crl.atos.net/crl/Atos_TrustedRoot_CA_2011.crl"
"http://repository.secomtrust.net/SC-Root3/SCRoot3CRL.crl"
"http://s.symcb.com/pca3-g5.crl"
"http://s.symcb.com/universal-root.crl"
"http://t.symcb.com/ThawtePCA-G3.crl"
"http://validation.identrust.com/crl/trustidevcodesigning4.crl"
"http://www.anf.es/crl/ANF_Global_Root_CA_SHA1.crl"
"http://www.apple.com/appleca/root.crl"
"http://www.microsoft.com/pkiops/crl/Microsoft%20ECC%20Product%20Root%20Certificate%20Authority%202018.crl"
)

TEMP_DIR="/tmp/apple_crls.parallel"
MAX_PROCS=6   # Number of simultaneous parallel jobs

mkdir -p "$TEMP_DIR"

do_crl() {
    local url="$1"
    local filename="$(basename "$url")"
    local crl_file="$TEMP_DIR/$filename"

    {
#        echo "[PID $$] Downloading $url..."
        if ! curl -s -o "$crl_file" "$url"; then
            echo "[PID $$] Failed to download $url"
            return 1
        fi

#        echo "[PID $$] Importing $filename into system keychain..."
        if ! sudo security import "$crl_file" -f raw -k "/Library/Keychains/System.keychain"; then
#            echo "[PID $$] Failed to import $filename"
            return 2
        fi

        echo "[PID $$] Success: $filename"
    } >"$TEMP_DIR/$filename.log" 2>&1
}

jobs_active() {
    # On zsh: count just background jobs attached to this shell
    jobs -p | wc -l | awk '{print $1}' 
}

for CRL_URL in "${CRL_URLS[@]}"; do
    # Limit active jobs
    while [[ $(jobs_active) -ge $MAX_PROCS ]]; do
        sleep 0.1
    done

    do_crl "$CRL_URL" &
done

wait   # Wait for all child/background jobs

cat "$TEMP_DIR"/*.log  # show all logs (optional)
rm -rf "$TEMP_DIR"

echo "All CRLs have been processed in parallel."
