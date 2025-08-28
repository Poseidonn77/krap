#!/bin/zsh
set -euo pipefail

# Array of CRL URLs
CRL_URLS=(
    "https://www.apple.com/appleca/root.crl"
    "https://www.apple.com/certificateauthority/root.crl"
    "https://crl.apple.com/softwareupdateca.crl"
    "https://crl.apple.com/timestamp.crl"
    "https://developer.apple.com/certificationauthority/wwdrca.crl"
    "https://crl.apple.com/apsrsa12g1.crl"
    "https://crl.apple.com/apsecc12g1.crl"
    "https://crl.apple.com/appleistca2g1.crl"
    "https://crl.apple.com/appleistca8g1.crl"
    "https://crl.apple.com/apevsrsa1g1.crl"
    "https://crl.apple.com/apevsrsa2g1.crl"
    "https://crl.apple.com/apevsrsaca3g1.crl"
    "https://crl.apple.com/apevsecc1g1.crl"
    "https://crl.apple.com/aptrsa1g1.crl"
    "https://crl.apple.com/aptecc1g1.crl"
)

# Temporary directory to store downloaded CRLs
TEMP_DIR="/tmp/apple_crls"

# Ensure cleanup on exit
cleanup() {
  rm -rf "$TEMP_DIR" || true
}
trap cleanup EXIT

# Create the temporary directory
mkdir -p "$TEMP_DIR"

# Pre-authenticate sudo once up front
echo "Requesting sudo access to import into System keychain..."
sudo -v

# Loop over the CRL URLs
for CRL_URL in "${CRL_URLS[@]}"; do
    # Extract the filename from the URL
    FILENAME="$(basename "$CRL_URL")"
    CRL_FILE="$TEMP_DIR/$FILENAME"

    # Download the CRL
    echo "Downloading CRL from $CRL_URL..."
    if ! curl -fsSL -o "$CRL_FILE" "$CRL_URL"; then
        echo "Failed to download the CRL from $CRL_URL."
        continue
    fi

    # Ensure the file is non-empty
    if [[ ! -s "$CRL_FILE" ]]; then
        echo "Downloaded file is empty for $CRL_URL. Skipping."
        continue
    fi

    # Import the CRL into the system keychain
    echo "Importing the CRL from $FILENAME into the system keychain..."
    sudo security import "$CRL_FILE" -f raw -k "/Library/Keychains/System.keychain"

    # Check if the import was successful
    if [[ $? -ne 0 ]]; then
        echo "Failed to import the CRL from $FILENAME."
        continue
    fi
done

echo "All CRLs have been processed."
