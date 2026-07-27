{
  lib,
  pkgs,
  ...
}: {
  # Gradual HM cutover on Debian (toad dual-boot). Add modules one at a time.
  imports = [
    ./home-base.nix
    ../../home/configs/bat.nix # pager used by git
    ../../home/configs/btop.nix
    ../../home/configs/fzf.nix
    ../../home/shell/fish.nix
    ../../home/configs/git.nix
    ../../home/shell/ghostty.nix
    ../../home/editors/language-servers.nix
    # ../../home/editors/helix  # next: merge local ~/.config/helix
  ];

  targets.genericLinux.enable = true;

  home.packages = with pkgs; [
    eza
  ];

  # Work identity on this host (personal email stays the NixOS default).
  programs.git.settings.user.email = lib.mkForce "matthew@purelend.ai";

  # themes.gitconfig is not present on this machine yet.
  programs.git.settings.include = lib.mkForce {};

  programs.ghostty.settings = {
    theme = lib.mkForce "Cursor Dark";
    window-padding-x = lib.mkForce 8;
    window-padding-y = lib.mkForce 8;
    background-blur = lib.mkForce false;
    background-opacity = lib.mkForce 1.0;
  };

  # mise is installed under ~/.local on this host (not via nix).
  # Login shell is bash (interactive sessions exec into fish). Put shims on the
  # session PATH so non-interactive bash — Cursor agents, scripts — can resolve
  # tools without fish activation. Additive: HM prepends these to existing PATH.
  # https://mise.en.dev/dev-tools/shims.html
  home.sessionPath = [
    "$HOME/.local/share/mise/shims"
    "$HOME/.local/bin"
  ];

  programs.fish.interactiveShellInit = lib.mkAfter ''
    fish_add_path $HOME/.local/bin
    mise activate fish | source
  '';
  programs.fish.shellInit = lib.mkAfter ''
    if not status is-interactive
        mise activate fish --shims | source
    end
  '';
}
