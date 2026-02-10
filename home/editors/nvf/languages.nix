{
  programs.nvf.settings.vim.languages = {
    enableTreesitter = true;
    enableFormat = true;
    enableExtraDiagnostics = true;

    html = {
      enable = true;
      treesitter.enable = true;
      treesitter.autotagHtml = true;
    };

    go = {
      enable = true;
      lsp.enable = true;
      treesitter.enable = true;
    };

    java = {
      enable = true;
      lsp.enable = true;
      treesitter.enable = true;
    };

    lua = {
      enable = true;
      lsp.enable = true;
      treesitter.enable = true;
    };

    markdown = {
      enable = true;
      lsp.enable = true;
      treesitter.enable = true;
    };

    nix = {
      enable = true;
      extraDiagnostics.enable = true;
      lsp.enable = true;
      treesitter.enable = true;
    };

    python = {
      enable = true;
      dap.enable = true;
      lsp = {
        enable = true;
        servers = ["pyright"];
      };
      treesitter.enable = true;
    };

    tailwind = {
      enable = true;
      lsp.enable = true;
    };

    ts = {
      enable = true;
      extensions.ts-error-translator.enable = true;
      extraDiagnostics.enable = true;
      format.type = ["prettierd"];
      lsp.enable = true;
      treesitter.enable = true;
    };

    # zig = {
    #   enable = true;
    #   lsp.enable = true;
    #   treesitter.enable = true;
    # };
  };
}
