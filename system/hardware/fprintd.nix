{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    fprintd
  ];

  services.fprintd.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090;

  security.pam.services."1password".fprintAuth = true;
}
