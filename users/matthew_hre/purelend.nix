{lib, ...}: {
  # Gradual HM cutover on Debian (toad dual-boot). Add modules one at a time, e.g.:
  #   ../../home/configs/jujutsu.nix
  #   ../../home/shell/fish.nix
  #   ../../home/editors/helix
  imports = [
    ./home-base.nix
    ../../home/configs/bat.nix # pager used by git
    ../../home/configs/btop.nix
    ../../home/configs/git.nix
  ];

  # Work identity on this host (personal email stays the NixOS default).
  programs.git.settings.user.email = lib.mkForce "matthew@purelend.ai";

  # themes.gitconfig is not present on this machine yet.
  programs.git.settings.include = lib.mkForce {};
}
