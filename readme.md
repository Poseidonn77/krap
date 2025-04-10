

(parsed.extensions.extended_key_usage.code_signing=true AND parsed.extensions.crl_distribution_points="*") and labels=`ever-trusted`
# CRL Downloader and Importer Script

This script automates the process of downloading and importing Certificate Revocation Lists (CRLs) from specified URLs into the system keychain on a macOS system. Keeping CRLs up-to-date is essential for maintaining the security and integrity of your system's SSL/TLS infrastructure.

## Table of Contents

- [Prerequisites](#prerequisites)
- [How the Script Works](#how-the-script-works)
  - [Configuration](#configuration)
  - [Temporary Directory Setup](#temporary-directory-setup)
  - [Downloading and Importing CRLs](#downloading-and-importing-crls)
  - [Cleanup](#cleanup)
  - [Final Messaging](#final-messaging)
- [Usage](#usage)
- [Caution](#caution)

## Prerequisites

- **Z shell (zsh)**: The script is written in zsh, which is the default shell in macOS.
- **`curl`**: A command-line tool for transferring data with URLs, pre-installed on macOS.
- **Administrative Privileges**: The script uses `sudo` to import CRLs into the system keychain, requiring administrative access.

## How the Script Works

### Configuration

The script starts by defining an array `CRL_URLS` containing the URLs of the CRLs to be downloaded and imported. You can modify this list to include any other CRL URLs your system requires.

```zsh
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
```

### Temporary Directory Setup

A temporary directory is created to store the downloaded CRL files. The `mkdir -p` command ensures that the directory is created if it doesn't already exist.

```zsh
# Temporary directory to store downloaded CRLs
TEMP_DIR="/tmp/apple_crls"

# Create the temporary directory
mkdir -p "$TEMP_DIR"
```

### Downloading and Importing CRLs

The script loops over each URL in the `CRL_URLS` array, performing the following steps:

1. **Extract the Filename**: The filename is extracted from the URL using the `basename` command.

    ```zsh
    # Extract the filename from the URL
    FILENAME="$(basename "$CRL_URL")"
    CRL_FILE="$TEMP_DIR/$FILENAME"
    ```

2. **Download the CRL**: The CRL is downloaded using `curl` and saved to the temporary directory.

    ```zsh
    # Download the CRL
    echo "Downloading CRL from $CRL_URL..."
    curl -s -o "$CRL_FILE" "$CRL_URL"
    ```

3. **Check Download Success**: The script checks if the download was successful by examining the exit status of the `curl` command.

    ```zsh
    # Check if the download was successful
    if [[ $? -ne 0 ]]; then
        echo "Failed to download the CRL from $CRL_URL."
        continue
    fi
    ```

4. **Import the CRL into the System Keychain**: The downloaded CRL is imported using the `security` command. Since modifying the system keychain requires administrative privileges, `sudo` is used.

    ```zsh
    # Import the CRL into the system keychain
    echo "Importing the CRL from $FILENAME into the system keychain..."
    sudo security import "$CRL_FILE" -f raw  -k "/Library/Keychains/System.keychain"
    ```

5. **Check Import Success**: The script checks if the import operation was successful.

    ```zsh
    # Check if the import was successful
    if [[ $? -ne 0 ]]; then
        echo "Failed to import the CRL from $FILENAME."
        continue
    fi
    ```

### Cleanup

After all CRLs have been processed, the temporary directory and its contents are deleted to clean up the system.

```zsh
# Clean up the temporary directory
rm -rf "$TEMP_DIR"
```

### Final Messaging

The script ends by confirming that all CRLs have been processed.

```zsh
echo "All CRLs have been processed."
```

## Usage

Follow these steps to use the script:

1. **Save the Script**: Copy the script into a file named `download_and_import_crls.zsh`.

2. **Make the Script Executable**: Open Terminal and run:

    ```bash
    chmod +x download_and_import_crls.zsh
    ```

3. **Run the Script**: Execute the script with:

    ```bash
    ./download_and_import_crls.zsh
    ```

4. **Provide Administrative Password**: When prompted, enter your password. This is necessary because the script uses `sudo` to import CRLs into the system keychain.

## Caution

- **Security Risks**: Ensure that the URLs in the `CRL_URLS` array are from trusted sources. Importing CRLs from unverified sources can compromise your system's security.
- **System Modifications**: The script modifies your system keychain. Understand the implications or consult with a system administrator before proceeding.
- **Administrative Privileges Required**: The script requires `sudo` access to function correctly. Use caution when executing scripts with elevated privileges.
