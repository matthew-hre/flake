{
  config,
  lib,
  ...
}: {
  options.modules.services.openssh.enable = lib.mkEnableOption "openssh support";

  config = lib.mkIf config.modules.services.openssh.enable {
    services.openssh.enable = true;
  };
}
