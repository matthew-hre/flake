{pkgs, ...}: {
  imports = [
    ./dms
    ./gtk
    ./niri
    ./vicinae
  ];

  home.packages = with pkgs; [
    amberol
    (celluloid.override {youtubeSupport = true;})
    file-roller
    grim
    imagemagick
    img2pdf
    jq
    loupe
    nautilus
    pwvucontrol
    satty
    slurp
    tesseract
    wl-clipboard
    zbar

    xwayland-satellite
  ];

  xdg = {
    mime.enable = true;

    mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/http" = "helium.desktop";
        "x-scheme-handler/https" = "helium.desktop";
        "inode/directory" = "org.gnome.Nautilus.desktop";
        "application/x-gnome-saved-search" = "org.gnome.Nautilus.desktop";
      };
    };
  };
}
