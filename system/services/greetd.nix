{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.services.greetd.enable = lib.mkEnableOption "greetd support";

  config = lib.mkIf config.modules.services.greetd.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --asterisks --theme border=green;text=white;prompt=green;time=green;action=purple;button=green;container=black;input=white";
          user = "greeter";
        };
      };
    };
  };
}
