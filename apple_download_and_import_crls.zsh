#!/bin/zsh
set -euo pipefail

# NOTE:
# macOS Keychain generally does NOT support importing CRLs via `security import`.
# This script will still download all CRLs and *attempt* an import, but will
# continue on failures (so one bad/unsupported import won't kill the whole run).

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
)

# Use a unique temp dir per run
TEMP_DIR="$(mktemp -d /tmp/apple_crls.XXXXXX)"

cleanup() {
  rm -rf "$TEMP_DIR" || true
}
trap cleanup EXIT

echo "Downloading CRLs into: $TEMP_DIR"

# Pre-authenticate sudo once up front (optional if you keep the import step)
echo "Requesting sudo access..."
sudo -v

# Optional: keep sudo alive while the script runs
# (prevents failures if the loop takes longer than sudo timeout)
while true; do
  sudo -n true 2>/dev/null || exit 0
  sleep 60
done &
SUDO_KEEPALIVE_PID=$!
trap 'kill "$SUDO_KEEPALIVE_PID" 2>/dev/null || true; cleanup' EXIT

for CRL_URL in "${CRL_URLS[@]}"; do
  FILENAME="$(basename "$CRL_URL")"
  CRL_FILE="$TEMP_DIR/$FILENAME"

  echo "Downloading: $CRL_URL"
  if ! curl -fsSL \
      --retry 3 --retry-delay 1 --connect-timeout 10 --max-time 60 \
      -o "$CRL_FILE" "$CRL_URL"
  then
    echo "  ERROR: download failed, skipping."
    continue
  fi

  if [[ ! -s "$CRL_FILE" ]]; then
    echo "  ERROR: downloaded file is empty, skipping."
    continue
  fi

  echo "Attempting import into System.keychain: $FILENAME"
  # IMPORTANT: This commonly fails because Keychain doesn't import CRLs.
  # Use `if ! ...; then ...; fi` so `set -e` doesn't abort the whole script.
  if ! sudo security import "$CRL_FILE" -f raw -k "/Library/Keychains/System.keychain" >/dev/null 2>&1; then
    echo "  WARN: import failed/unsupported for CRL ($FILENAME). Leaving it downloaded."
    continue
  fi

  echo "  OK: imported (if supported)."
done

echo "All CRLs have been processed."
echo "Downloaded files remain available until exit at: $TEMP_DIR"
