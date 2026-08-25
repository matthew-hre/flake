{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    hunspell
    hunspellDicts.en_CA
    hunspellDicts.en_US

    libreoffice-qt
  ];
}
