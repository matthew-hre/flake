{pkgs, ...}: {
  programs.helix = {
    extraPackages = with pkgs; [
      # nix
      nixd
      alejandra

      # web (html/css/js/ts/react/next)
      nodePackages.typescript-language-server
      vscode-langservers-extracted
      tailwindcss-language-server
      prettierd

      # java / python
      jdt-language-server
      pyright

      # zig / go / rust
      zls
      gopls
      rust-analyzer

      # markdown + config languages
      marksman
      taplo
      yaml-language-server
    ];

    languages = {
      language = [
        {
          name = "nix";
          language-servers = ["nixd"];
          formatter.command = "alejandra";
          auto-format = true;
        }
        {
          name = "typescript";
          formatter = {command = "prettierd"; args = ["--parser" "typescript"];};
          auto-format = true;
        }
        {
          name = "tsx";
          formatter = {command = "prettierd"; args = ["--parser" "typescript"];};
          auto-format = true;
        }
        {
          name = "javascript";
          formatter = {command = "prettierd"; args = ["--parser" "babel"];};
          auto-format = true;
        }
        {
          name = "jsx";
          formatter = {command = "prettierd"; args = ["--parser" "babel"];};
          auto-format = true;
        }
        {
          name = "html";
          formatter = {command = "prettierd"; args = ["--parser" "html"];};
          auto-format = true;
        }
        {
          name = "css";
          formatter = {command = "prettierd"; args = ["--parser" "css"];};
          auto-format = true;
        }
        {
          name = "json";
          formatter = {command = "prettierd"; args = ["--parser" "json"];};
          auto-format = true;
        }
        {
          name = "markdown";
          formatter = {command = "prettierd"; args = ["--parser" "markdown"];};
          auto-format = true;
        }
      ];
    };
  };
}
