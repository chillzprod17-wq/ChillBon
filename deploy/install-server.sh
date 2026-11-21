#!/usr/bin/env bash
# ChillBon server bootstrap. Run on a NEW Debian/Ubuntu VPS as root.
set -Eeuo pipefail

if [[ ${EUID} -ne 0 ]]; then
  echo "Run as root: sudo bash deploy/install-server.sh" >&2
  exit 1
fi

if [[ ! -f /etc/os-release ]]; then
  echo "Unsupported system: /etc/os-release missing" >&2
  exit 1
fi
. /etc/os-release
case "${ID:-}" in
  ubuntu|debian) ;;
  *) echo "Use a fresh Debian 12/13 or Ubuntu 22.04/24.04/26.04 VPS." >&2; exit 1 ;;
esac

if [[ ! -t 0 ]]; then
  echo "Interactive terminal required: installer asks for domain and admin account." >&2
  exit 1
fi

echo "ChillBon / PlusEMU production installer"
echo "This will install nginx, MariaDB, PHP, PlusEMU, Volt and Atom CMS."
echo "Use a NEW VPS with >=10 GB free and a domain configured in Cloudflare."
read -r -p "Type INSTALL to proceed: " confirmation
[[ "$confirmation" == "INSTALL" ]] || { echo "Cancelled."; exit 1; }

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
curl --fail --silent --show-error --location --retry 3 \
  https://raw.githubusercontent.com/plus-emulator/plusemu-installer/main/install.sh \
  --output "$tmp/install.sh"
echo "Downloaded upstream PlusEMU installer. Inspect if needed: $tmp/install.sh"
bash "$tmp/install.sh"
