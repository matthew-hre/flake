{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.programs.fonts.enable = lib.mkEnableOption "fonts support";

  config = lib.mkIf config.modules.programs.fonts.enable {
    fonts.packages = with pkgs; [
      departure-mono
      work-sans
      ibm-plex
      nerd-fonts.lilex
    ];
  };
}
