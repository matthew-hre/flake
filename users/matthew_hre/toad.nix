{inputs, ...}: {
  imports = [./default.nix];

  home-manager.users.matthew_hre = {
    imports = [
      # niri needs to be specified here, since
      # it builds from source regardless of whether
      # it's enabled or not, and i don't want it
      # on thwomp
      inputs.niri.homeModules.niri
      ../../home/wayland
    ];

    home = {
      bat.enable = true;
      btop.enable = true;
      direnv.enable = true;
      fastfetch.enable = true;
      fuzzel.enable = true;
      garbage.enable = true;
      git.enable = true;
      ssh.enable = true;
      vicinae.enable = true;

      editors.helix.enable = true;
      editors.nvf.enable = true;
      editors.vscode.enable = true;

      shell.fish.enable = true;
      shell.ghostty.enable = true;

      wayland.enable = true;
      wayland.waybar.enable = false;
      wayland.quickshell.enable = true;
    };
  };
}
