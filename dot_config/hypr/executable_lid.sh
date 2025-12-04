#!/usr/bin/env bash
set -euo pipefail

LAPTOP="eDP-1"
EXTERNAL="DP-2"  # from your hyprctl output

# Check if external is connected
external_connected() {
  for path in /sys/class/drm/card*-"$EXTERNAL"/status; do
    [[ -r "$path" ]] || continue
    if grep -q '^connected' "$path"; then
      return 0
    fi
  done

  # Fallback via hyprctl
  hyprctl monitors 2>/dev/null | awk -v m="$EXTERNAL" \
    '$1=="Monitor" && $2==m {found=1} END {exit !found}'
}

case "${1:-}" in
  open)
    if external_connected; then
      # Re-enable both monitors with your preferred layout
      hyprctl keyword monitor "$LAPTOP,1920x1080,0x0,1.5"
      hyprctl keyword monitor "$EXTERNAL,3840x2160,1280x0,1.5"

      # Reassert workspace bindings: 1 on laptop, 2–10 on external
      hyprctl keyword workspace "1,monitor:$LAPTOP"
      for ws in 2 3 4 5 6 7 8 9 10; do
        hyprctl keyword workspace "$ws,monitor:$EXTERNAL"
      done
    else
      # No external: just run internal display
      hyprctl keyword monitor "$LAPTOP,1920x1080,0x0,1.5"
      # All workspaces will end up on eDP-1
    fi
    ;;

  close)
    if external_connected; then
      # Move all workspaces 1–10 to the external first
      for ws in 1 2 3 4 5 6 7 8 9 10; do
        hyprctl dispatch moveworkspacetomonitor "$ws $EXTERNAL" || true
      done

      # Disable laptop panel
      hyprctl keyword monitor "$LAPTOP,disable"

      # Ensure Hyprland thinks all workspaces belong to the external now
      for ws in 1 2 3 4 5 6 7 8 9 10; do
        hyprctl keyword workspace "$ws,monitor:$EXTERNAL"
      done
    else
      # Lid closed, no external – choose your preferred behavior:
      # suspend is often nicest
      systemctl suspend
    fi
    ;;

  *)
    echo "Usage: $0 {open|close}" >&2
    exit 1
    ;;
esac
