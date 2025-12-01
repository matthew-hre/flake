{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  options.home.wayland.quickshell = {
    enable = lib.mkEnableOption "quickshell configuration";
  };

  config = lib.mkIf config.home.wayland.quickshell.enable {
    home.packages = [
      inputs.quickshell.packages.${pkgs.system}.default
      pkgs.qt6Packages.qt5compat
      pkgs.libsForQt5.qt5.qtgraphicaleffects
      pkgs.kdePackages.qtbase
      pkgs.kdePackages.qtdeclarative
      pkgs.kdePackages.qtstyleplugin-kvantum
      pkgs.wallust
      pkgs.material-symbols
      pkgs.material-icons
      pkgs.cava
      pkgs.gpu-screen-recorder
    ];

    home.sessionVariables = {
      QML_IMPORT_PATH = "${pkgs.qt6.qt5compat}/lib/qt-6/qml:${pkgs.qt6.qtdeclarative}/lib/qt-6/qml";
    };
  };
}
