{
  lib,
  pkgs,
  ...
}: let
  recordRegion = pkgs.writeShellApplication {
    name = "record-region";
    runtimeInputs = with pkgs; [
      coreutils
      slurp
      wf-recorder
      wl-clipboard
    ];
    text = ''
      geometry="$(slurp)" || exit 1
      output_dir="''${XDG_VIDEOS_DIR:-$HOME/Videos}/Screen Recordings"
      output="$output_dir/screen-recording-$(date +%Y-%m-%d_%H-%M-%S).mp4"

      mkdir -p "$output_dir"
      echo "Recording $geometry; press Ctrl+C to stop."
      wf-recorder -g "$geometry" -f "$output"

      wl-copy --type video/mp4 < "$output"
      echo "Saved and copied to the clipboard: $output"
    '';
  };
in {
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
    gpu-screen-recorder
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
    recordRegion
    ripgrep
    slurp
    strace
    stripe-cli
    supabase-cli
    unzip
    usbutils
    wf-recorder
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

  programs.fish.functions.nom-shell = ''
    for arg in $argv
      switch $arg
        case --run --command '--run=*' '--command=*' --help --version
          command nom-shell $argv
          return
      end
    end

    command nom-shell $argv --run fish
  '';

  programs.fish.shellAliases.nix-shell = "nom-shell";

  home.sessionVariables.PNPM_HOME = "$HOME/.local/share/pnpm";

  home.sessionPath = [
    "$HOME/.nix-profile/bin"
    "/nix/var/nix/profiles/default/bin"
    "$HOME/.local/bin"
    "$HOME/.local/share/pnpm/bin"
  ];

  systemd.user.sessionVariables.PATH = "$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$HOME/.local/bin:$HOME/.local/share/pnpm/bin\${PATH:+:\$PATH}";

  programs.fish.shellInit = lib.mkBefore ''
    # Determinate Nix supplies nixpkgs through nix.conf; an inherited channel path
    # masks it and breaks nix-shell when that channel no longer exists.
    set -e NIX_PATH

    # Graphical/systemd sessions can export __HM_SESS_VARS_SOURCED without nix on PATH,
    # which makes hm-session-vars.fish skip PATH setup. Add missing HM paths without
    # overriding paths supplied by dev shells.
    for path in $HOME/.nix-profile/bin /nix/var/nix/profiles/default/bin $HOME/.local/share/pnpm/bin
      contains -- $path $PATH; or set -ga PATH $path
    end
  '';
}
