{
  config,
  inputs,
  lib,
  ...
}: {
  options.home.editors.vscode = {
    enable = lib.mkEnableOption "vscode configuration";
  };

  config = lib.mkIf config.home.editors.vscode.enable {
    programs.vscode = {
      enable = true;
    };
  };
}
