{
  config,
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
  };
}
