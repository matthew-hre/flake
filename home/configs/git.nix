{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Matthew Hrehirchuk";
        email = "matthew_hre@outlook.com";
      };

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
    settings = {
      user = {
        name = "Matthew Hrehirchuk";
        email = "matthew_hre@outlook.com";
      };
    };
  };
}
