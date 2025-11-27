{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.programs.libre.enable = lib.mkEnableOption "libreoffice support";

  config = lib.mkIf config.modules.programs.libre.enable {
    environment.systemPackages = with pkgs; [
      hunspell
      hunspellDicts.en_CA
      hunspellDicts.en_US

      libreoffice-qt
    ];
  };
}
