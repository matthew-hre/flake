# Debian cutover TODO (purelend)

Gradual home-manager migration on Debian. Host: **purelend** (`users/matthew_hre/purelend.nix`). Dual-boot of toad (Framework 13).

After each item: `home-manager switch --flake ~/flake#purelend`, verify, then `sudo apt remove <package>`.

---

## Done

- [x] bat — `home/configs/bat.nix`
- [x] btop — `home/configs/btop.nix`
- [x] direnv — `home/configs/direnv.nix`
- [x] eza — `home.packages`
- [x] fastfetch — `home/configs/fastfetch.nix`
- [x] fd — `home.packages`
- [x] fish — `home/shell/fish.nix`
- [x] fzf — `home/configs/fzf.nix`
- [x] gh — `home.packages`
- [x] ghostty — `home/shell/ghostty.nix`
- [x] git — `home/configs/git.nix`
- [x] glow — `home.packages`
- [x] helix — `home/editors/helix` (local `~/.config/helix` merged; apt removed)
- [x] jujutsu — `home/configs/jujutsu.nix`
- [x] language servers — `home/editors/language-servers.nix`
- [x] lazygit — `home.packages`
- [x] lazydocker — `home.packages`
- [x] LLM agents — `home/ai` (`cursor-agent`, `agent`, `amp`, `claude-code`, `codex`, `crush`)
- [x] nix-output-monitor — `home.packages`
- [x] onefetch — `home.packages`
- [x] pciutils / usbutils — `home.packages`
- [x] ripgrep — `home.packages`
- [x] ssh config — `home/configs/ssh.nix`
- [x] strace / ltrace — `home.packages`
- [x] wl-clipboard / xclip — `home.packages`
- [x] yazi — `home/configs/yazi.nix`
- [x] zip / xz / unzip / p7zip — `home.packages`
- [x] zoxide — via `fish.nix` (`programs.zoxide`; apt removed)

---

## Easy — existing module, add an import

_All done._

---

## Easy — one-liner in `home.packages` (already in `home.nix`)

_All done._

---

## Medium — flake module exists, needs Debian adaptation

| Program | Flake location | Apt / install | Blocker |
|---------|----------------|---------------|---------|
| nh + dustpan | `home/configs/garbage.nix` | — | `nh` targets NixOS; on Debian only `nh clean` / dustpan may apply |
| helium | `inputs.helium` (NixOS `system/base.nix` only) | apt (`helium-bin`) | Could add to `home.packages` via flake input |

---

## Medium — wayland stack (big bang, import `home/wayland`)

These are wired together on NixOS. Cutting over piecemeal is harder than importing the whole wayland tree.

**Live session today:** apt `niri` + apt `dms` + `/usr/local/bin/vicinae`. Flake uses **DMS**, not quickshell/waybar.

| Program | Flake location | Apt / install | Notes |
|---------|----------------|---------------|-------|
| niri | `home/wayland/niri` + `inputs.niri` | `niri` | Laptop branch only sets `eDP-1` 2880×1920@60.001. This host also has Dell S2716DG on `DP-3`; panel prefers 120 Hz |
| DMS | `home/wayland/dms` + `inputs.dms` | `dms` | Wallpaper path `/home/matthew_hre/Pictures/Wallpapers/outer-wilds-dark.png` is missing here. Laptop lock/suspend timeouts should be fine (`hostname != donkeykong`) |
| vicinae | `home/wayland/vicinae` | `/usr/local/bin/vicinae` | Launcher; references helium + 1password |
| xwayland-satellite | `home/wayland/default.nix` | `xwayland-satellite` | |
| matugen | via DMS | `matugen` | Apt leftover from current DMS install |
| dgop | via DMS | `dgop` | Apt leftover from current DMS install |
| quickshell | — | `quickshell` | Not in flake anymore; apt leftover used by `dms run` |

Also ships via wayland module: amberol, celluloid, nautilus, loupe, file-roller, etc. — nautilus/loupe/file-roller already stay on apt.

---

## Hard — proprietary / no nix module / system-level

| Program | Current install | Flake status | Recommendation |
|---------|-----------------|--------------|----------------|
| Cursor | apt (`cursor`) + `~/.local/bin/cursor*` | Not in flake | Keep apt or AppImage; unfree packaging is painful |
| Google Chrome | apt (`google-chrome-stable`) | Not in flake | Keep apt |
| Microsoft Edge | apt (`microsoft-edge-stable`) | Not in flake | Keep apt |
| 1Password | apt (`1password`) | NixOS `programs._1password-gui` | Keep apt on Debian; polkit setup differs |
| Bitwarden | apt (`bitwarden`) | Not in flake | Keep apt |
| OpenScreen | apt (`openscreen`) + `~/bin/openscreen.AppImage` | Not in flake | Pick one source |
| Docker | apt (`docker-ce` + plugins) | NixOS `services/docker.nix` | Keep apt on Debian; no NixOS on this host |
| Tailscale | apt (`tailscale`) | NixOS `services/vpn.nix` | Keep apt; needs system daemon |
| keyd | apt (`keyd`) | NixOS `system/programs/niri.nix` | Keep apt; needs system service |
| PostgreSQL | apt (`postgresql`) | Not in flake | Keep apt unless you want HM service module |
| Vanta | apt (`vanta`) | Not in flake | Enterprise agent — keep apt |
| pipx | apt (`pipx`) + `~/.local/bin/pipx` | Not in flake | Keep; manages Python tools outside nix |
| snapd | apt | Not in flake | Debian infra — keep |
| Nix daemon caches | `/etc/nix/nix.custom.conf` | NixOS uses `lib/caches.nix` | Keep system-managed on Debian; Home Manager must not require root |

---

## Work development tools

Node, pnpm, gcloud, OpenTofu, Stripe CLI, and Supabase CLI are managed in the `purelend` Home Manager profile. Work repositories use the global Node 24 runtime, while pnpm honors each repository's `packageManager` version. No per-repository dev shell or version-manager activation is required.

---

## ~/.local/bin (not flake-managed)

HM agents already win on PATH (`~/.nix-profile/bin` before `~/.local/bin` in this session). Leftover shims:

| Binary | Likely source | Notes |
|--------|---------------|-------|
| cursor-agent, agent | Cursor installer | Duplicate of `home/ai`; safe to drop once PATH order is trusted |
| cr, coderabbit | manual | Not in flake |
| parallel-cli | manual | Not in flake |
| uv, uvx | astral installer | Not in flake |
| pipx | uv tool shim | Keep; also apt `pipx` |
| cursor | wrapper script | Keep with apt Cursor |

---

## ~/.cargo/bin (rustup toolchain)

Removed — was only `linear`/`linear-update` plus rustup. Re-add via flake when needed.

---

## Suggested order

1. ~~**direnv**~~ — done
2. ~~**ripgrep + gh + glow + lazydocker**~~ — done
3. ~~**yazi**~~ — done
4. ~~**helix**~~ — done
5. ~~**LLM agents**~~ — module imported; leftover `~/.local/bin` shims optional cleanup
6. ~~**zoxide**~~ — done (apt removed)
7. **helium** — wire `inputs.helium` into `home.packages`
8. **wayland stack** — niri + DMS + vicinae as one cutover (needs purelend output + wallpaper overrides)

---

## Skip (Debian/GNOME base — not worth nixifying)

GNOME session is gone (`task-gnome-desktop` / GDM / gnome-shell removed 2026-08-13). Login is TTY → `niri-session`.

Still on apt, marked manual: nautilus, loupe, file-roller, evince, seahorse, calculator, disks, simple-scan, gnome-keyring, xdg-desktop-portal-gnome/gtk, LibreOffice. Ghostty is the terminal. Network GUI is `nmtui` / `nmcli` / DMS — `gnome-control-center` is gone.
