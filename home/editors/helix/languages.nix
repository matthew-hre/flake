{
  programs.helix = {
    languages = {
      language-server.harper-ls = {
        command = "harper-ls";
        args = ["--stdio"];
      };

      language = [
        {
          name = "nix";
          language-servers = ["nixd"];
          formatter.command = "alejandra";
          auto-format = true;
        }
        {
          name = "typescript";
          formatter = {
            command = "prettierd";
            args = ["--parser" "typescript"];
          };
          auto-format = true;
        }
        {
          name = "tsx";
          formatter = {
            command = "prettierd";
            args = ["--parser" "typescript"];
          };
          auto-format = true;
        }
        {
          name = "javascript";
          formatter = {
            command = "prettierd";
            args = ["--parser" "babel"];
          };
          auto-format = true;
        }
        {
          name = "jsx";
          formatter = {
            command = "prettierd";
            args = ["--parser" "babel"];
          };
          auto-format = true;
        }
        {
          name = "html";
          formatter = {
            command = "prettierd";
            args = ["--parser" "html"];
          };
          auto-format = true;
        }
        {
          name = "css";
          formatter = {
            command = "prettierd";
            args = ["--parser" "css"];
          };
          auto-format = true;
        }
        {
          name = "json";
          formatter = {
            command = "prettierd";
            args = ["--parser" "json"];
          };
          auto-format = true;
        }
        {
          name = "markdown";
          language-servers = ["marksman" "harper-ls"];
          formatter = {
            command = "prettierd";
            args = ["--parser" "markdown"];
          };
          auto-format = true;
        }
      ];
    };
  };
}
