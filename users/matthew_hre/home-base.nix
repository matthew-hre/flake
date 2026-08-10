{
  imports = [
    ../../home/programs/sidra.nix
  ];

  home = {
    username = "matthew_hre";
    homeDirectory = "/home/matthew_hre";
    stateVersion = "23.11";
    enableNixpkgsReleaseCheck = false;
  };

  programs.home-manager.enable = true;
}
