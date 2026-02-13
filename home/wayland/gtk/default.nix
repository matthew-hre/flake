{pkgs, ...}: {
  gtk = {
    enable = true;
    theme = {
      package = pkgs.dracula-theme;
      name = "Dracula";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    gtk3.extraConfig = {
      gtk-font-name = "Work Sans 10";
    };
    gtk4.extraConfig = {
      gtk-font-name = "Work Sans 10";
    };
  };
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      font-name = "Work Sans 10";
      document-font-name = "Work Sans 10";
      monospace-font-name = "Lilex Nerd Font 10";
    };
  };
}
