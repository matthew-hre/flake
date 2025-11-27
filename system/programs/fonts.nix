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
      fira-code
      fira-code-symbols
      work-sans
      nerd-fonts.fira-code
    ];
  };
}
