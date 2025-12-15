{
  config,
  pkgs,
  lib,
  ...
}: {
  options.modules.services.power.enable = lib.mkEnableOption "power support";

  config = lib.mkIf config.modules.services.power.enable {
    services.power-profiles-daemon.enable = false;

    services.tlp = {
      enable = true;
      settings = {
        TLP_DEFAULT_MODE = "BAT";

        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "power";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 75;
      };
    };

    # refresh rate switching based on AC power
    services.udev.extraRules = ''
      SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ACTION=="change", TAG+="systemd", ENV{SYSTEMD_WANTS}="niri-refresh-rate.service"
    '';

    systemd.services.niri-refresh-rate = {
      description = "Switch niri refresh rate based on power state";
      serviceConfig = {
        Type = "oneshot";
        User = "matthew_hre";
        Environment = "XDG_RUNTIME_DIR=/run/user/1000";
        ExecStart = pkgs.writeShellScript "niri-refresh-rate" ''
          NIRI_SOCKET=$(${pkgs.findutils}/bin/find /run/user/1000 -maxdepth 1 -name 'niri.*.sock' 2>/dev/null | ${pkgs.coreutils}/bin/head -1)
          [ -z "$NIRI_SOCKET" ] && exit 0
          export NIRI_SOCKET

          ONLINE=$(${pkgs.coreutils}/bin/cat /sys/class/power_supply/ACAD/online 2>/dev/null || echo "0")
          if [ "$ONLINE" = "1" ]; then
            ${pkgs.niri}/bin/niri msg output eDP-1 mode 2880x1920@120.000
          else
            ${pkgs.niri}/bin/niri msg output eDP-1 mode 2880x1920@60.001
          fi
        '';
      };
      wantedBy = []; # only triggered by udev
    };
  };
}
