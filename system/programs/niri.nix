{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.programs.niri.enable = lib.mkEnableOption "niri support";

  config = lib.mkIf config.modules.programs.niri.enable {
    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };

    programs.gpu-screen-recorder.enable = true;

    # shoutout @CodedNil on gh for the fix
    # waiting on https://github.com/YaLTeR/niri/pull/1923 for a real fix
    services.keyd = {
      enable = true;
      keyboards.default = {
        ids = ["*"];
        settings.global = {
          overload_tap_timeout = 200; #ms
        };
        settings.main = {
          compose = "layer(meta)";
          leftmeta = "overload(meta, macro(leftmeta+z))";
        };
      };
    };

    # turns out i've been using this the whole time!
    # i believe niri uses this automatically, but it doesn't hurt to set it
    services.gnome.gnome-keyring.enable = true;
  };
}
