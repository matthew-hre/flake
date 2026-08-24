{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./home-base.nix
    ../../home/ai
    ../../home/configs/bat.nix
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
    ../../home/editors/helix
  ];

  targets.genericLinux.enable = true;

  home.packages = with pkgs; [
    eza
    fd
    gh
    glow
    google-cloud-sdk
    lazygit
    lazydocker
    ltrace
    nix-output-monitor
    nodejs_24
    onefetch
    opentofu
    p7zip
    pciutils
    pnpm
    ripgrep
    strace
    stripe-cli
    supabase-cli
    unzip
    usbutils
    wl-clipboard
    xclip
    xz
    zip
  ];

  programs.git.settings.user.email = lib.mkForce "matthew@purelend.ai";
  programs.jujutsu.settings.user.email = lib.mkForce "matthew@purelend.ai";

  programs.ssh.matchBlocks."knot.matthew-hre.com" = {
    identityFile = "~/.ssh/id_ed25519_tangled";
    identitiesOnly = true;
  };

  programs.ssh.matchBlocks."tangled.org" = {
    hostname = "tangled.org";
    user = "git";
    identityFile = "~/.ssh/id_ed25519_tangled";
    identitiesOnly = true;
    addressFamily = "inet";
  };

  programs.git.settings.include = lib.mkForce {};

  programs.ghostty.settings = {
    theme = lib.mkForce "Cursor Dark";
    background-blur = lib.mkForce false;
    background-opacity = lib.mkForce 1.0;

    command = lib.mkForce "${pkgs.fish}/bin/fish";
    shell-integration = lib.mkForce "fish";
    shell-integration-features = lib.mkForce "cursor,sudo,title,no-cursor";
  };

  home.sessionVariables.PNPM_HOME = "$HOME/.local/share/pnpm";

  home.sessionPath = [
    "$HOME/.nix-profile/bin"
    "/nix/var/nix/profiles/default/bin"
    "$HOME/.local/bin"
    "$HOME/.local/share/pnpm/bin"
  ];

  systemd.user.sessionVariables.PATH = "$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$HOME/.local/bin:$HOME/.local/share/pnpm/bin\${PATH:+:\$PATH}";

  programs.fish.shellInit = lib.mkBefore ''
    # Graphical/systemd sessions can export __HM_SESS_VARS_SOURCED without nix on PATH,
    # which makes hm-session-vars.fish skip PATH setup. Ensure HM tools resolve anyway.
    fish_add_path -m $HOME/.nix-profile/bin /nix/var/nix/profiles/default/bin $HOME/.local/share/pnpm/bin
  '';
}
