{
  security.sudo.enable = true;
  security.rtkit.enable = true;
  security.pam.services = {
    greetd.enableGnomeKeyring = true;
    login.enableGnomeKeyring = true;
  };
}
