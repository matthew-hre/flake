{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./home-base.nix
    ../../home/configs
    ../../home/editors
    ../../home/shell
  ];

  home = {
    packages = with pkgs; [
      zip
      xz
      unzip
      p7zip
      ripgrep
      eza
      fd
      zoxide
      wl-clipboard
      gh
      lazygit
      lazydocker
      alejandra
      nix-output-monitor
      nh
      strace
      ltrace
      pciutils
      usbutils
      xclip
      tray-tui
      inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.cursor-agent
      inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.amp
      inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-code
      inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.crush
    ];

    sessionVariables = {
      EDITOR = "hx";
      BROWSER = "helium";
      TERMINAL = "ghostty";
      DELTA_PAGER = "less -R";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      MANROFFOPT = "-c";
    };
  };
}
