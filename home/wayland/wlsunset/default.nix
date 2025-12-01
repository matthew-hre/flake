{
  config,
  lib,
  ...
}: {
  options.home.wayland.wlsunset = {
    enable = lib.mkEnableOption "wlsunset configuration";
  };

  config = lib.mkIf config.home.wayland.wlsunset.enable {
    services.wlsunset = {
      enable = true;
      latitude = 51;
      longitude = -114;
    };
  };
}
