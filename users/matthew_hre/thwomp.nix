{
  imports = [./default.nix];

  home-manager.users.matthew_hre.home = {
    bat.enable = true;
    btop.enable = true;
    btop.amdGpuSupport = true;
    direnv.enable = true;
    fastfetch.enable = true;
    fuzzel.enable = true;
    garbage.enable = true;
    git.enable = true;
    ssh.enable = true;
    vicinae.enable = false;

    editors.helix.enable = true;
    editors.nvf.enable = true;
    editors.vscode.enable = true;

    shell.fish.enable = true;
    shell.ghostty.enable = true;
  };
}
