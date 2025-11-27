{
  hostname,
  lib,
  ...
}: let
  toad = hostname == "toad";
in {
  security = {
    sudo.enable = true;
    rtkit.enable = true;

    pam.services = lib.mkIf toad {
      hyprlock = {
        text = "auth include login";
        enableGnomeKeyring = true;
      };

      "polkit-1" = {
        fprintAuth = true;
      };

      greetd.enableGnomeKeyring = true;
      login.enableGnomeKeyring = true;
    };
  };
}
