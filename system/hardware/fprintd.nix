{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.hardware.fprintd.enable = lib.mkEnableOption "fprintd support";

  config = lib.mkIf config.modules.hardware.fprintd.enable {
    environment.systemPackages = with pkgs; [
      fprintd
    ];

    services.fprintd.enable = true;
    services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090;

    security.pam.services."1password".fprintAuth = true;
  };
}
