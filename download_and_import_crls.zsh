#!/bin/zsh

# Array of CRL URLs
CRL_URLS=(
"http://www.suscerte.gob.ve/lcr"
"http://ac.economia.gob.mx/last.crl"
"http://acraiz.icpbrasil.gov.br/LCRacraizv10.crl"
"http://acraiz.icpbrasil.gov.br/LCRacraizv5.crl"
"http://cert.startcom.org/sfsca-crl.crl"
"http://certs.oati.net/repository/OATICA2.crl"
"http://certs.oaticerts.com/repository/OATICA2.crl"
"http://crl.certigna.fr/certignarootca.crl"
"http://crl.chambersign.org/chambersignroot.crl"
"http://crl.chambersign.org/chambersroot.crl"
"http://crl.comodo.net/SecureCertificateServices.crl"
"http://crl.comodo.net/TrustedCertificateServices.crl"
"http://crl.comodoca.com/COMODOCertificationAuthority.crl"
"http://crl.comodoca.com/SecureCertificateServices.crl"
"http://crl.comodoca.com/TrustedCertificateServices.crl"
"http://crl.d-trust.net/crl/d-trust_br_root_ca_1_2020.crl"
"http://crl.d-trust.net/crl/d-trust_ev_root_ca_1_2020.crl"
"http://crl.d-trust.net/crl/d-trust_root_ca_3_2013.crl"
"http://crl.dhimyotis.com/certignarootca.crl"
"http://crl.netsolssl.com/NetworkSolutionsCertificateAuthority.crl"
"http://crl.oces.trust2408.com/oces.crl"
"http://crl.postsignum.cz/crl/psrootqca4.crl"
"http://crl.postsignum.eu/crl/psrootqca4.crl"
"http://crl.securetrust.com/SGCA.crl"
"http://crl.securetrust.com/STCA.crl"
"http://crl.ssc.lt/root-a/cacrl.crl"
"http://crl.ssc.lt/root-b/cacrl.crl"
"http://crl.ssc.lt/root-c/cacrl.crl"
"http://crl.startcom.org/sfsca-crl.crl"
"http://crl.xrampsecurity.com/XGCA.crl"
"http://crl1.comsign.co.il/crl/comsignglobalrootca.crl"
"http://crl2.postsignum.cz/crl/psrootqca4.crl"
"http://fedir.comsign.co.il/crl/ComSignAdvancedSecurityCA.crl"
"http://fedir.comsign.co.il/crl/ComSignCA.crl"
"http://fedir.comsign.co.il/crl/ComSignSecuredCA.crl"
"http://fedir.comsign.co.il/crl/comsignglobalrootca.crl"
"http://postsignum.ttc.cz/crl/psrootqca2.crl"
"http://sertifikati.ca.posta.rs/crl/PostaCARoot.crl"
"http://web.ncdc.gov.sa/crl/nrcacomb1.crl"
"http://web.ncdc.gov.sa/crl/nrcaparta1.crl"
"http://www.accv.es/fileadmin/Archivos/certificados/raizaccv1_der.crl"
"http://www.agesic.gub.uy/acrn/acrn.crl"
"http://www.certeurope.fr/reference/root2.crl"
"http://www.d-trust.net/crl/d-trust_root_class_3_ca_2_2009.crl"
"http://www.d-trust.net/crl/d-trust_root_class_3_ca_2_ev_2009.crl"
"http://www.postsignum.cz/crl/psrootqca2.crl"
"http://www.trustcenter.de/crl/v2/tc_class_2_ca_II.crl"
"http://www.trustcenter.de/crl/v2/tc_class_3_ca_II.crl"
"http://www.uce.gub.uy/acrn/acrn.crl"
"http://www2.postsignum.cz/crl/psrootqca2.crl"
"https://www.apple.com/certificateauthority/root.crl"
"http://hhspkicrl.managed.entrust.com/CRLs/HHSEntrustCA2.crl"
"http://proxy.fineid.fi/crl/dvvshsp3rc.crl"
"http://pki.intranet.eon.com/crls/eon_group_ca_v2.crl"
"http://www.trustcenter.de/crl/v2/eon_group_ca_v2.crl"
"http://proxy.fineid.fi/crl/dvvsp5rc.crl"
"http://crl.tcclass2-ii.trustcenter.de/crl/v2/tc_class_2_ca_II.crl"
"http://sspweb.managed.entrust.com/CRLs/EMSSSPCA3.crl"
"http://crl.tcuniversal-I.trustcenter.de/crl/v2/tc_universal_root_I.crl"
"http://http.fpki.gov/fcpca/fcpca.crl"
"http://ssp-crl.digicert.com/SSP/SSPG5.crl"
"http://www.trustcenter.de/crl/v2/tc_class_2_ca_II.crl"
"http://get-crl.certificat.com/public/opentrustcaforaatlg1.crl"
"http://rootweb.managed.entrust.com/CRLs/EMSRootCA3.crl"
"http://crl.omniroot.com/ctglobal.crl"
"http://get-crl.certificat.com/public/opentrustrootcag1.crl"
"http://proxy.fineid.fi/crl/dvvsp5ec.crl"
"http://rootweb.managed.entrust.com/CRLs/EMSRootCA2.crl"
"http://cdp1.ssp-strong-id.net/CDP/VZ-SSP-CA-A2.crl"
"hhtp://www.suscerte.gob.ve/lcr"
"http://cdp.jackhenry.com/crl/jh_group_ca_I.crl"
"http://cdp.jackhenry.com/crl/tc_class_2_ca_II.crl"
"http://cdp1.ssp-strong-id.net/CDP/VACAB3.crl"
"http://crl.IV.tcclass2-II.trustcenter.de/crl/v2/tc_class2-II_L1_CA_IV.crl"
"http://crl.comodo.net/SecureCertificateServices.crl"
"http://crl.comodo.net/TrustedCertificateServices.crl"
"http://crl.comodoca.com/SecureCertificateServices.crl"
"http://crl.comodoca.com/TrustedCertificateServices.crl"
"http://crl.ge.com/crl/v2/tc_class_2_ca_II.crl"
"http://crl.pki.va.gov/PKI/CRL/VACAB3.crl"
"http://crl.tcclass1.trustcenter.de/crl/v2/tc_class_1_ca.crl"
"http://crl.tcclass2-II.trustcenter.de/crl/v2/tc_class_2_ca_II.crl"
"http://crl.tcclass2.trustcenter.de/crl/v2/tc_class_2_ca.crl"
"http://crl.tcuniversal-III.trustcenter.de/crl/v2/tc_universal_root_III.crl"
"http://crl.wt.trustasia.com/TrustAsiaDVTLSECCCAG4.crl"
"http://feddcsweb.managed.entrust.com/CRLs/EMSRootCA2.crl"
"http://pki.intranet.eon.com/crls/tc_class_2_ca_II.crl"
"http://sspweb.managed.entrust.com/CRLs/EMSSSPCAc20894.crl"
"http://www.trustcenter.de/crl/v2/jh_group_ca_I.crl"
"http://www.trustcenter.de/crl/v2/tcclass1.crl"
"http://www.trustcenter.de/crl/v2/tcclass2.crl"
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
