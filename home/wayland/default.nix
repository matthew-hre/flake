{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.home.wayland;
in {
  imports = [
    ./dunst
    ./gtk
    ./hypridle
    ./hyprlock
    ./niri
    ./quickshell
    ./waybar
    ./wlsunset
  ];

  options.home.wayland.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable all wayland components";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      home.wayland.dunst.enable = lib.mkDefault true;
      home.wayland.gtk.enable = lib.mkDefault true;
      home.wayland.hypridle.enable = lib.mkDefault true;
      home.wayland.hyprlock.enable = lib.mkDefault true;
      home.wayland.niri.enable = lib.mkDefault true;
      home.wayland.waybar.enable = lib.mkDefault true;
      home.wayland.wlsunset.enable = lib.mkDefault true;
    })

    (lib.mkIf (lib.any (x: x) [
        cfg.dunst.enable
        cfg.gtk.enable
        cfg.hypridle.enable
        cfg.hyprlock.enable
        cfg.niri.enable
        cfg.waybar.enable
        cfg.wlsunset.enable
      ]) {
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
      })
  ];
}
