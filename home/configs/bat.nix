{
  config,
  lib,
  ...
}: {
  options.home.bat = {
    enable = lib.mkEnableOption "bat configuration";
  };

  config = lib.mkIf config.home.bat.enable {
    programs.bat = {
      enable = true;
      config.theme = "Dracula";
    };
  };
}
