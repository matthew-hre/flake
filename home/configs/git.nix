{inputs, ...}: let
  user = {
    name = "Matthew Hrehirchuk";
    email = "me@matthew-hre.com";
  };
in {
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

  programs.jujutsu = {
    enable = true;
    package = inputs.jj.packages.x86_64-linux.jujutsu;

    settings = {
      inherit user;

      aliases = {
        init = ["git" "init" "--colocate"];
        tug = ["bookmark" "advance"];
      };

      templates.git_push_bookmark = "\"matthew-hre/jj-\" ++ change_id.short()";
      revsets.bookmark-advance-to = "@-";

      ui = {
        editor = "hx";
      };
    };
  };
}
