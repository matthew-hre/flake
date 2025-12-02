{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./dunst
    ./gtk
    ./hypridle
    ./hyprlock
    ./niri
    ./quickshell
    ./waybar
    ./wlsunset
    ./vicinae
  ];

  home.packages = with pkgs; [
    amberol
    (celluloid.override {youtubeSupport = true;})
    file-roller
    loupe
    nautilus
    pwvucontrol

    cliphist
    hyprpicker

    networkmanagerapplet
    brightnessctl

    xwayland-satellite

    nmgui
  ];
}
