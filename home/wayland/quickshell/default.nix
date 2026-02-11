{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [
    inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.qt6Packages.qt5compat
    pkgs.libsForQt5.qt5.qtgraphicaleffects
    pkgs.kdePackages.qtbase
    pkgs.kdePackages.qtdeclarative
    pkgs.kdePackages.qtsvg
    pkgs.kdePackages.qtstyleplugin-kvantum
    pkgs.wallust
    pkgs.material-symbols
    pkgs.material-icons
    pkgs.cava
    pkgs.slurp
  ];

  home.sessionVariables = {
    QML_IMPORT_PATH = "${pkgs.qt6.qt5compat}/lib/qt-6/qml:${pkgs.qt6.qtdeclarative}/lib/qt-6/qml";
  };
}
