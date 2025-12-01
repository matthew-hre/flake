{
  config,
  lib,
  ...
}: {
  options.modules.services.security = {
    enable = lib.mkEnableOption "base security";
    fingerprintPam.enable = lib.mkEnableOption "fingerprint PAM integration";
  };

  config = let
    cfg = config.modules.services.security;
  in
    lib.mkMerge [
      {
        security.sudo.enable = true;
        security.rtkit.enable = true;
      }

      (lib.mkIf cfg.fingerprintPam.enable {
        security.pam.services = {
          hyprlock = {
            text = "auth include login";
            enableGnomeKeyring = true;
          };
          "polkit-1".fprintAuth = true;
          greetd.enableGnomeKeyring = true;
          login.enableGnomeKeyring = true;
        };
      })
    ];
}
