{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  options.modules.programs.plasma.enable = lib.mkEnableOption "plasma support";

  config = lib.mkIf config.modules.programs.plasma.enable {
    services.desktopManager.plasma6.enable = true;
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      kate
      okular
    ];

    environment.systemPackages = with pkgs; [
      inputs.kwin-effects-forceblur.packages.${pkgs.system}.default
      kdePackages.kconfig
    ];
  };
}
