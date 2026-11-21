# ChillBon production deployment

The **Volt v1.0.14** client artifact is built and verified by [GitHub Actions](../.github/workflows/prepare-volt.yml), but this does **not** mean a playable hotel is online.

The recommended route is the official PlusEMU installer, which provisions **Volt, PlusEMU, Atom CMS, MariaDB, nginx and hotel assets** together. Do not attempt to use GitHub Pages as the emulator server.

## Requirements

- Fresh Debian 12/13 or Ubuntu 22.04/24.04/26.04 VPS, root/sudo access, 10 GB+ free disk
- Domain name in a Cloudflare account
- Public IP and access to the VPS terminal
- A budget/hosting account for a server that stays online

## Install

On the **new VPS**, clone the ChillBon repository or copy `deploy/install-server.sh` to the server, then run:

```bash
sudo bash deploy/install-server.sh
```

The script checks the OS, requires explicit confirmation and downloads the upstream installer. The upstream installer prompts for domain, WebSocket URL, hotel name (**ChillBon**), admin username and email, then provisions the stack. Do not enter credentials into GitHub or commit them.

Follow the installer's Cloudflare/HTTPS instructions. Use a secure `wss://` endpoint for players.

## Verify before launch

1. Open the public domain over HTTPS.
2. Create/sign in to a test account and confirm the SSO ticket is issued.
3. Enter a room and confirm room tiles, furniture and avatar assets load.
4. Check movement and chat with **two browsers**.
5. Confirm housekeeping, backups, database and logs work.
6. Keep the original GitHub Pages site on `main` unchanged until these checks pass.

## Sources

- https://github.com/plus-emulator/plusemu-installer
- https://github.com/plus-emulator/Volt
- https://docs.plusemu.dev/getting-started/installation/

**Security:** The installer configures networking and database services. Run it only on a dedicated VPS, not on your personal computer. Review the upstream code before executing it.
