{pkgs, ...}: {
  fonts.packages = with pkgs; [
    departure-mono
    work-sans
    ibm-plex
    nerd-fonts.lilex
  ];
}
