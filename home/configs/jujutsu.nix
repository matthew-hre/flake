{
  inputs,
  ...
}: let
  user = {
    name = "Matthew Hrehirchuk";
    email = "me@matthew-hre.com";
  };
in {
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
