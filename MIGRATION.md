# ChillBon — migration to Volt + PlusEMU

This branch is a staging area. The existing GitHub Pages game on `main` is intentionally untouched.

## Verified upstream projects

- Web client: https://github.com/plus-emulator/Volt
- Renderer: https://github.com/plus-emulator/Volt-Renderer
- Multiplayer emulator: https://github.com/plus-emulator/PlusEMU
- Installer (includes Atom CMS, MariaDB, assets): https://github.com/plus-emulator/plusemu-installer
- Official client instructions: https://docs.plusemu.dev/getting-started/volt-client/

## Recommended deployment approach

1. Provision a server for PlusEMU, MariaDB and Atom CMS. GitHub Pages cannot run these services.
2. Use the official installer or a documented manual setup on that server. The installer also provisions hotel asset files.
3. Obtain the prebuilt `volt-client.zip` from the upstream Volt releases. A release is preferred over a custom source build.
4. In `configuration/`, copy the provided example files to `renderer-config.json`, `ui-config.json`, and `client-mode.json`. Set `socket.url` to the public secure WebSocket endpoint of the emulator.
5. Configure the login/SSO ticket integration and public asset URLs. Do not commit passwords, tickets or database credentials.
6. Test a real account, login, entering a room, avatar movement, chat and furniture before switching the public site.
7. Only after the test passes, deploy the client to the public URL and point the website to the working server.

## Notes

- GitHub Pages hosts static files only. A working client requires a reachable PlusEMU server and configured assets.
- Volt/PlusEMU are GPL-3.0; third-party assets and trademarks require separate authorization.
- Do not merge this branch into `main` until an end-to-end test is successful.
- Upstream releases: https://github.com/plus-emulator/Volt/releases
