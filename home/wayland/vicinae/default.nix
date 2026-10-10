{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

  programs.vicinae = {
    enable = true;
    # Upstream forces GCC 15, but numen uses nixpkgs' default C++ runtime.
    package = inputs.vicinae.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
      gcc15Stdenv = pkgs.stdenv;
    };
    systemd = {
      enable = true;
      autoStart = true;
    };
    settings = {
      pop_to_root_on_close = true;
      close_on_focus_loss = true;
      favorites = [
        "applications:helium"
        "applications:discord"
        "applications:1password"
        "applications:com.mitchellh.ghostty"
        "applications:steam"
      ];
      theme = {
        light = {
          name = "dracula";
          icon_theme = "default";
        };
        dark = {
          name = "dracula";
          icon_theme = "default";
        };
      };
      launcher_window = {
        opacity = 0.80;
      };
    };
  };
}
