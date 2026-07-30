# Debian cutover TODO (purelend)

Gradual home-manager migration on Debian. Host: **purelend** (`users/matthew_hre/purelend.nix`).

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
- [x] jujutsu — `home/configs/jujutsu.nix`
- [x] language servers — `home/editors/language-servers.nix`
- [x] lazygit — `home.packages`
- [x] lazydocker — `home.packages`
- [x] mise — `programs.mise` in `purelend.nix`
- [x] nix-output-monitor — `home.packages`
- [x] onefetch — `home.packages`
- [x] pciutils / usbutils — `home.packages`
- [x] ripgrep — `home.packages`
- [x] ssh config — `home/configs/ssh.nix`
- [x] strace / ltrace — `home.packages`
- [x] wl-clipboard / xclip — `home.packages`
- [x] yazi — `home/configs/yazi.nix`
- [x] zip / xz / unzip / p7zip — `home.packages`

---

## Easy — existing module, add an import

_All done._

---

## Easy — one-liner in `home.packages` (already in `home.nix`)

_All done._

---

## Medium — flake module exists, needs config merge or Debian adaptation

| Program | Flake location | Apt / install | Blocker |
|---------|----------------|---------------|---------|
| helix | `home/editors/helix` | `helix` | Merge local `~/.config/helix` first (already noted in `purelend.nix`) |
| nh + dustpan | `home/configs/garbage.nix` | — | `nh` targets NixOS; on Debian only `nh clean` / dustpan may apply |
| LLM agents | `home.nix` → `inputs.llm-agents` | `~/.local/bin/{cursor-agent,claude,agent,...}` | cursor-agent, amp, claude-code, crush — overlap with pipx/local installs |
| zoxide | via `fish.nix` | — | Already on PATH from HM; confirm no apt duplicate |

---

## Medium — wayland stack (big bang, import `home/wayland`)

These are wired together on NixOS. Cutting over piecemeal is harder than importing the whole wayland tree.

| Program | Flake location | Apt / install | Notes |
|---------|----------------|---------------|-------|
| niri | `home/wayland/niri` + `inputs.niri` | `niri` | Full config in flake; apt niri can conflict |
| quickshell | `home/wayland/quickshell` + `inputs.quickshell-config` | `quickshell` | `devPath` hardcoded for `toad` — needs purelend override |
| waybar | `home/wayland/waybar` | — | |
| xwayland-satellite | `home/wayland/default.nix` | `xwayland-satellite` | |
| vicinae | `home/wayland/vicinae` | — | Launcher; references helium + 1password |
| hypridle / hyprlock / wlsunset | `home/wayland/*` | — | Session services |
| matugen | — | `matugen` | Used by quickshell theming; not in flake yet |
| dgop | — | `dgop` | Not in flake |

Also ships via wayland module: amberol, celluloid, nautilus, loupe, file-roller, cliphist, etc. — mostly covered by Debian GNOME already.

---

## Hard — proprietary / no nix module / system-level

| Program | Current install | Flake status | Recommendation |
|---------|-----------------|--------------|----------------|
| Cursor | apt (`cursor`) + `~/.local/bin/cursor*` | Not in flake | Keep apt or AppImage; unfree packaging is painful |
| Google Chrome | apt (`google-chrome-stable`) | Not in flake | Keep apt |
| Microsoft Edge | apt (`microsoft-edge-stable`) | Not in flake | Keep apt |
| Helium | apt (`helium-bin`) | `inputs.helium` (NixOS `system/base.nix` only) | Could add to `home.packages` via flake input |
| 1Password | apt (`1password`) | NixOS `programs._1password-gui` | Keep apt on Debian; polkit setup differs |
| Bitwarden | apt (`bitwarden`) | Not in flake | Keep apt |
| OpenScreen | apt (`openscreen`) + `~/bin/openscreen.AppImage` | Not in flake | Pick one source |
| DMS | apt (`dms`) | Not in flake | Keep apt or evaluate nix packaging |
| Docker | apt (`docker-ce` + plugins) | NixOS `services/docker.nix` | Keep apt on Debian; no NixOS on this host |
| Tailscale | apt (`tailscale`) | NixOS `services/vpn.nix` | Keep apt; needs system daemon |
| keyd | apt (`keyd`) | NixOS `system/programs/niri.nix` | Keep apt; needs system service |
| PostgreSQL | apt (`postgresql`) | Not in flake | Keep apt unless you want HM service module |
| Vanta | apt (`vanta`) | Not in flake | Enterprise agent — keep apt |
| pipx | apt (`pipx`) + `~/.local/bin/pipx` | Not in flake | Keep; manages Python tools outside nix |
| GNOME Extension Manager | apt | Not in flake | Debian-specific; keep apt |
| snapd | apt | Not in flake | Debian infra — keep |

---

## mise tools (optional cutover)

Currently via mise, not flake. Could stay in mise or move to `home.packages` / dev shells.

| Tool | mise version |
|------|--------------|
| bun | 1.3.14 |
| deno | 2.8.3 |
| gcloud | 569.0.0 |
| node | 22.17.1 |
| opentofu | 1.10.1 / 1.12.2 |
| pnpm | 10.16.0 |
| stripe | 1.42.13 |
| supabase | 2.101.0 |

Note: jujutsu is in both mise (0.42.0) and HM (0.43.0) — HM wins on PATH.

---

## ~/.local/bin (not flake-managed)

| Binary | Likely source |
|--------|---------------|
| cursor-agent | Cursor / llm-agents |
| agent, claude, cr | LLM CLI tools |
| coderabbit | pipx / manual |
| parallel-cli | manual |
| uv, uvx | astral installer |
| pipx | apt + shim |

Most overlap with `inputs.llm-agents` in `home.nix`. Cutting over LLM agents module would consolidate these.

---

## ~/.cargo/bin (rustup toolchain)

Removed — was only `linear`/`linear-update` plus rustup. Re-add via flake when needed.

---

## Suggested order

1. ~~**direnv**~~ — done
2. ~~**ripgrep + gh + glow + lazydocker**~~ — done
3. ~~**yazi**~~ — done
4. **helix** — after merging `~/.config/helix`
5. **LLM agents** — replace `~/.local/bin` shims
6. **helium** — wire `inputs.helium` into `home.packages`
7. **wayland stack** — niri + quickshell + waybar as one cutover (needs purelend-specific quickshell path)

---

## Skip (Debian/GNOME base — not worth nixifying)

GNOME apps installed via apt with desktop entries: Calculator, Calendar, Terminal, Files, Settings, LibreOffice, Firefox ESR, etc. These come from the Debian desktop metapackages (`task-gnome-desktop`) and should stay on apt.
