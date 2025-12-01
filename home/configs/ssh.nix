{
  config,
  lib,
  ...
}: {
  options.home.ssh = {
    enable = lib.mkEnableOption "ssh configuration";
  };

  config =
    lib.mkIf config.home.ssh.enable {
      programs.ssh = {
        enable = true;
        extraConfig = "
Host *
  IdentityAgent ~/.1password/agent.sock
    ";
      };
    };
}
