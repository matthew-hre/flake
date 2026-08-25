{
  config,
  lib,
  ...
}: {
  options.modules.services.security.fingerprintPam.enable = lib.mkEnableOption "fingerprint PAM integration";

  config = {
    security.sudo.enable = true;
    security.rtkit.enable = true;
    security.pam.services = {
      greetd.enableGnomeKeyring = true;
      login.enableGnomeKeyring = true;
    };

    security.pam.services."polkit-1".fprintAuth = config.modules.services.security.fingerprintPam.enable;
  };
}
