# ChillBon Volt client deployment

This directory documents the real client deployment. No secrets are stored in Git.

1. In GitHub, select **Actions → Prepare real Volt client → Run workflow** on branch `volt-migration`.
2. Download the resulting `chillbon-volt-v1.0.14` artifact.
3. Copy upstream config examples in `configuration/` to their active filenames:
   - `renderer-config.json.example.json` → `renderer-config.json`
   - `ui-config.example` → `ui-config.json`
   - `client-mode.example` → `client-mode.json`
4. Set `socket.url` to the PlusEMU `wss://` endpoint, configure asset URLs and website SSO integration.
5. Host the built client on a static web host and PlusEMU + MariaDB + CMS on a separate server.

The workflow intentionally produces a downloadable artifact **without** publishing it to GitHub Pages or changing `main`. The browser client cannot authenticate or enter rooms without the backend and resources.

Volt upstream: https://github.com/plus-emulator/Volt
