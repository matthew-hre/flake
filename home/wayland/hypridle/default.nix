{
  config,
  hostname,
  lib,
  pkgs,
  ...
}: let
  lock = "${pkgs.systemd}/bin/loginctl lock-session";

  timeout =
    if hostname == "thwomp"
    then 1800
    else 300;
in {
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = lib.getExe config.programs.hyprlock.package;
        unlock_cmd = "${pkgs.systemd}/bin/systemctl --user restart quickshell.service";
      };

      listener = [
        {
          timeout = timeout - 10;
          on-timeout = "brightnessctl -s set 1";

          on-resume = "brightnessctl -r";
        }
        {
          inherit timeout;
        }
        {
          timeout = timeout + 10;
          on-timeout = lock;
        }
      ];
    };
  };
}
