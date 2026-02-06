{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  options.modules.programs.niri.enable = lib.mkEnableOption "niri support";

  config = let
    stashPkg = inputs.stash.packages.x86_64-linux.stash;
  in
    lib.mkIf config.modules.programs.niri.enable {
      environment.systemPackages = with pkgs; [
        swww # needs to be installed at the system level
        polkit_gnome
        stashPkg
      ];

      systemd.packages = [stashPkg];

      programs.niri = {
        enable = true;
        package = pkgs.niri;
      };

      # install here to handle security permissions properly
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

      systemd = {
        user.services.polkit-gnome-authentication-agent-1 = {
          description = "polkit-gnome-authentication-agent-1";
          wantedBy = ["graphical-session.target"];
          wants = ["graphical-session.target"];
          after = ["graphical-session.target"];
          serviceConfig = {
            Type = "simple";
            ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
          };
        };
      };
    };
}
