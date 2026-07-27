{
  programs.helix = {
    languages = {
      language-server = {
        oxlint = {
          command = "pnpx";
          args = ["oxlint" "--lsp"];
        };
        oxfmt = {
          command = "pnpx";
          args = ["oxfmt" "--lsp"];
        };
        harper-ls = {
          command = "harper-ls";
          args = ["--stdio"];
        };
      };

      language = [
        {
          name = "git-commit";
          language-servers = ["harper-ls"];
        }
        {
          name = "jjdescription";
          language-servers = ["harper-ls"];
        }
        {
          name = "nix";
          language-servers = ["nil" "nixd" "harper-ls"];
          formatter.command = "alejandra";
          auto-format = true;
        }
        {
          name = "typescript";
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = ["format"];
            }
            "oxlint"
            {
              name = "oxfmt";
              only-features = ["format"];
            }
            "harper-ls"
          ];
          auto-format = true;
        }
        {
          name = "tsx";
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = ["format"];
            }
            "oxlint"
            {
              name = "oxfmt";
              only-features = ["format"];
            }
            "harper-ls"
          ];
          auto-format = true;
        }
        {
          name = "javascript";
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = ["format"];
            }
            "oxlint"
            {
              name = "oxfmt";
              only-features = ["format"];
            }
            "harper-ls"
          ];
          auto-format = true;
        }
        {
          name = "jsx";
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = ["format"];
            }
            "oxlint"
            {
              name = "oxfmt";
              only-features = ["format"];
            }
            "harper-ls"
          ];
          auto-format = true;
        }
        {
          name = "html";
          language-servers = [
            "vscode-html-language-server"
            "superhtml"
            "harper-ls"
          ];
        }
        {
          name = "markdown";
          language-servers = ["marksman" "markdown-oxide" "harper-ls"];
          soft-wrap.enable = true;
        }
        {
          name = "python";
          language-servers = ["ty" "ruff" "harper-ls"];
        }
        {
          name = "bash";
          language-servers = ["bash-language-server" "harper-ls"];
        }
        {
          name = "toml";
          language-servers = ["taplo" "tombi" "harper-ls"];
        }
      ];
    };
  };
}
