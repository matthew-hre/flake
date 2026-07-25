{
  inputs,
  pkgs,
  ...
}: let
  user = {
    name = "Matthew Hrehirchuk";
    email = "me@matthew-hre.com";
  };
in {
  home.packages = [
    inputs.hunk.packages.${pkgs.stdenv.hostPlatform.system}.hunk
  ];

  programs.git = {
    enable = true;

    signing.format = "openpgp";

    settings = {
      inherit user;

      include = {
        path = "/home/matthew_hre/.config/git/themes.gitconfig";
      };

      core = {pager = "bat";};
      blame = {pager = "bat";};
      delta = {
        features = "line-numbers decorations";
        hyperlinks = true;
        syntax-theme = "Dracula";
        plus-style = ''syntax "#003800"'';
        minus-style = ''syntax "#3f0001"'';
      };
      url."git@github.com" = {
        insteadOf = "gh";
      };
      url."git@github.com:matthew-hre/" = {
        insteadOf = "mh:";
      };
    };
  };
}
