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
    ../../home/configs/direnv.nix
    ../../home/configs/fastfetch.nix
    ../../home/configs/fzf.nix
    ../../home/configs/ssh.nix
    ../../home/configs/yazi.nix
    ../../home/shell/fish.nix
    ../../home/configs/git.nix
    ../../home/configs/jujutsu.nix
    ../../home/shell/ghostty.nix
    ../../home/editors/language-servers.nix
    # ../../home/editors/helix  # next: merge local ~/.config/helix
  ];

  targets.genericLinux.enable = true;

  home.packages = with pkgs; [
    eza
    fd
    gh
    glow
    lazygit
    lazydocker
    ltrace
    nix-output-monitor
    onefetch
    p7zip
    pciutils
    ripgrep
    strace
    unzip
    usbutils
    wl-clipboard
    xclip
    xz
    zip
  ];

  # Work identity on this host (personal email stays the NixOS default).
  programs.git.settings.user.email = lib.mkForce "matthew@purelend.ai";
  programs.jujutsu.settings.user.email = lib.mkForce "matthew@purelend.ai";

  # themes.gitconfig is not present on this machine yet.
  programs.git.settings.include = lib.mkForce {};

  programs.ghostty.settings = {
    theme = lib.mkForce "Cursor Dark";
    background-blur = lib.mkForce false;
    background-opacity = lib.mkForce 1.0;

    # genericLinux keeps bash in passwd; launch fish explicitly in ghostty.
    command = lib.mkForce "${pkgs.fish}/bin/fish";
    shell-integration = lib.mkForce "fish";
    shell-integration-features = lib.mkForce "cursor,sudo,title,no-cursor";
  };

  # mise CLI via nix-profile (agents already have ~/.nix-profile/bin on PATH).
  # Interactive fish: HM `activate`. Non-interactive/IDE: shims on session PATH.
  # https://mise.en.dev/dev-tools/shims.html
  programs.mise = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };

  # niri-session imports systemd user env (not your shell). Keep nix/HM on PATH there.
  home.sessionPath = [
    "$HOME/.nix-profile/bin"
    "/nix/var/nix/profiles/default/bin"
    "$HOME/.local/share/mise/shims"
    "$HOME/.local/bin"
  ];

  systemd.user.sessionVariables.PATH =
    "$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$HOME/.local/share/mise/shims:$HOME/.local/bin\${PATH:+:\$PATH}";

  programs.fish.shellInit = lib.mkAfter ''
    if not status is-interactive
        ${lib.getExe pkgs.mise} activate fish --shims | source
    end
  '';
}
