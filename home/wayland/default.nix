{pkgs, ...}: {
  imports = [
    # ./dunst
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

  xdg = {
    mime.enable = true;

    mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/http" = "helium.desktop";
        "x-scheme-handler/https" = "helium.desktop";
      };
    };
  };
}
