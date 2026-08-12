{
  imports = [./languages.nix];

  programs.helix = {
    enable = true;
    settings = {
      theme = "base16_transparent";
      editor = {
        color-modes = true;
        completion-replace = true;
        cursorline = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        undercurl = true;
        true-color = true;
        auto-pairs = true;
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        inline-diagnostics = {
          cursor-line = "hint";
        };
        indent-guides = {
          render = true;
          character = "│";
          skip-levels = 1;
        };
        statusline = {
          left = [
            "mode"
            "spinner"
            "version-control"
            "spacer"
            "separator"
            "file-name"
            "read-only-indicator"
            "file-modification-indicator"
          ];
          center = [];
          right = [
            "diagnostics"
            "workspace-diagnostics"
            "position"
            "total-line-numbers"
            "position-percentage"
            "file-encoding"
            "file-type"
            "register"
            "selections"
          ];
          separator = "│";
        };
      };
    };

    themes = {
      base16_transparent = {
        "inherits" = "base16_default";
        "ui.background" = {};
      };
    };
  };
}
