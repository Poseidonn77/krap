# CRL Tools (macOS + Windows)

This repository contains small utilities for working with Certificate Revocation Lists (CRLs):

- `apple_download_and_import_crls.zsh`: Sequential CRL downloader/importer for macOS.
- `codesign_CRL.zsh`: Parallel CRL downloader/importer for macOS with a larger URL set.
- `windowspowershellCRLImport.ps1`: CRL downloader/importer for Windows (uses `certutil`).
- `codesignList.zsh`: Helper to query CRL distribution points from Censys (requires credentials and `jq`).
- `ever-trusted-root-crl.txt`, `rootcrl.txt`: Example CRL lists.

## Table of Contents

- [Prerequisites](#prerequisites)
- [macOS Scripts](#macos-scripts)
  - [How They Work](#how-they-work)
  - [Usage](#usage)
- [Windows Script](#windows-script)
- [Optional: Collect CRL URLs via Censys](#optional-collect-crl-urls-via-censys)
- [Caution](#caution)

## Prerequisites

- **macOS**: `zsh` and `curl` (preinstalled); administrative privileges for keychain imports.
- **Windows**: PowerShell, `certutil` (preinstalled), run as Administrator.
- Optional: `jq` (for `codesignList.zsh`) and valid Censys API credentials.

## macOS Scripts

### How They Work

Both macOS scripts define an array `CRL_URLS` containing CRL endpoints to fetch. Downloads are written to a temporary directory and then imported into the System keychain. The `codesign_CRL.zsh` variant runs multiple downloads/imports in parallel to speed things up on large lists.

Note: CRL distribution points are often served over HTTP by design. Where HTTPS is available (e.g., many Apple endpoints), these scripts prefer HTTPS.

High level steps per CRL URL:
- Extract filename; download to temp dir with `curl`.
- Import into the System keychain via `security`.
- Clean up temporary files on exit.

### Usage

For the simple sequential macOS variant:

- Make executable: `chmod +x apple_download_and_import_crls.zsh`
- Run: `./apple_download_and_import_crls.zsh`

For the parallel macOS variant:

- Make executable: `chmod +x codesign_CRL.zsh`
- Run: `./codesign_CRL.zsh`

## Windows Script

- Run PowerShell as Administrator.
- Execute: `.\windowspowershellCRLImport.ps1`
- The script downloads each CRL and adds it to the Windows certificate stores using `certutil` (defaults to the `CA` store).

## Optional: Collect CRL URLs via Censys

`codesignList.zsh` calls the Censys v2 aggregate API to enumerate common CRL distribution points from publicly trusted code signing certificates.

- Requires: `jq`, Censys API ID/Secret. Set `API_ID` and `API_SECRET` in the script before running.
- Output: `crl_urls_with_counts.txt` (URL + count) and `crl_urls.txt` (URL only).

Note: Network calls are not used by the import scripts themselves; only `codesignList.zsh` uses the network.

## Caution

- **Trusted sources**: Only import CRLs from trusted CAs you rely on.
- **Keychain/Store changes**: Importing affects system-wide certificate processing. Validate in a test environment first.
- **Admin privileges**: macOS scripts use `sudo`; Windows requires an elevated PowerShell.
