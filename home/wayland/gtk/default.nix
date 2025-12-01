{
  config,
  lib,
  pkgs,
  ...
}: {
  options.home.wayland.gtk = {
    enable = lib.mkEnableOption "GTK configuration";
  };

  config = lib.mkIf config.home.wayland.gtk.enable {
    gtk = {
      enable = true;
      theme = {
        package = pkgs.dracula-theme;
        name = "Dracula";
      };
    };
  };
}
