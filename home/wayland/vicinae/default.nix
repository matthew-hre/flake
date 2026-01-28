{inputs, ...}: {
  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

  services.vicinae = {
    enable = true;
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
    };
  };
}
