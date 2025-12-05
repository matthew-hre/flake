{
  programs.helix = {
    enable = true;
    settings = {
      theme = "dracula";
      editor = {
        color-modes = true;
        cursorline = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        undercurl = true;
        true-color = true;
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        auto-pairs = true;
        clipboard-provider = "wayland";
      };
    };
  };
}
