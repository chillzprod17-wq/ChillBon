#!/usr/bin/env bash
# ChillBon server readiness checks (safe: read-only)
set -u
fail=0
ok() { printf '[OK] %s\n' "$1"; }
warn() { printf '[WARN] %s\n' "$1"; fail=1; }

if [ -r /etc/os-release ]; then
  . /etc/os-release
  case "${ID:-}:${VERSION_ID:-}" in
    debian:12|debian:13|ubuntu:22.04|ubuntu:24.04|ubuntu:26.04) ok "Supported OS: $PRETTY_NAME" ;;
    *) warn "Unsupported or untested OS: ${PRETTY_NAME:-unknown}" ;;
  esac
else
  warn "Cannot identify operating system"
fi

arch="$(uname -m)"
case "$arch" in x86_64|aarch64) ok "CPU architecture: $arch";; *) warn "Unsupported CPU architecture: $arch";; esac

disk_kb="$(df -Pk / | awk 'NR==2 {print $4}')"
if [ -n "$disk_kb" ] && [ "$disk_kb" -ge 10485760 ]; then
  ok "Free disk: $((disk_kb / 1048576)) GiB"
else
  warn "Less than 10 GiB free on /"
fi

if command -v free >/dev/null 2>&1; then
  mem_kb="$(awk '/MemTotal:/ {print $2}' /proc/meminfo)"
  if [ "${mem_kb:-0}" -ge 2097152 ]; then
    ok "Memory: $((mem_kb / 1024)) MiB"
  else
    warn "Less than 2 GiB RAM; performance may be poor (not an official minimum)"
  fi
fi

for command in curl bash; do
  if command -v "$command" >/dev/null 2>&1; then ok "Command available: $command"; else warn "Missing command: $command"; fi
done

for port in 80 3306 2096 8080 30001; do
  if command -v ss >/dev/null 2>&1 && ss -H -ltn "( sport = :$port )" 2>/dev/null | grep -q .; then
    warn "Port $port is already in use"
  else
    ok "Port $port not detected as listening"
  fi
done

echo
if [ "$fail" -eq 0 ]; then
  echo "Preliminary checks passed. This does NOT deploy the hotel or verify DNS, HTTPS or hosting."
else
  echo "Some checks need attention before deployment."
fi
exit "$fail"
