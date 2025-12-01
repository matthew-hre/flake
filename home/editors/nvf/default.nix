{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.nvf.homeManagerModules.default

    ./languages.nix
  ];

  options.home.editors.nvf = {
    enable = lib.mkEnableOption "nvf (neovim) configuration";
  };

  config = lib.mkIf config.home.editors.nvf.enable {
    programs.nvf = {
      enable = true;

      settings.vim = {
        viAlias = true;
        vimAlias = true;

        syntaxHighlighting = true;
        options = {
          tabstop = 2;
          shiftwidth = 2;
        };
        preventJunkFiles = true;

        clipboard.enable = true;

        keymaps = [
          {
            mode = "!";
            key = "<C-l>";
            action = "<c-g>u<Esc>[s1z=`]a<c-g>u";
          }
        ];

        binds.cheatsheet.enable = true;
        binds.whichKey.enable = true;

        lsp = {
          enable = true;
          formatOnSave = true;
        };

        theme = {
          enable = true;
          name = "dracula";
        };

        statusline.lualine = {
          enable = true;
          globalStatus = true;
          icons.enable = true;
        };

        telescope.enable = true;
        presence.neocord.enable = true;

        autocomplete = {
          enableSharedCmpSources = true;
          blink-cmp.enable = true;
        };

        ui.noice.enable = true;

        ui.borders.plugins.which-key.style = "solid";

        visuals.nvim-web-devicons.enable = true;
      };
    };
  };
}
