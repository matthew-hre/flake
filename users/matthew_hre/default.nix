{
  inputs,
  pkgs,
  ...
}: {
  # System-level user definition
  users.users.matthew_hre = {
    isNormalUser = true;
    home = "/home/matthew_hre";
    description = "Matthew Hrehirchuk";
    extraGroups = ["wheel" "networkmanager" "docker" "wireshark"];
    shell = pkgs.fish;
  };

  users.defaultUserShell = pkgs.fish;

  home-manager.users.matthew_hre = {
    imports = [
      ./home.nix
      ../../home/wayland
    ];

    home.sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";
    };
  };
}
