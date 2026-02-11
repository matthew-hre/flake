{
  inputs,
  pkgs,
  ...
}: let
  extensionDependencies = with pkgs; [
    openssl
    zlib
  ];

  zedPackage = pkgs.buildFHSEnv {
    name = "zed";
    targetPkgs = pkgs:
      [
        inputs.zed.packages.x86_64-linux.default
      ]
      ++ extensionDependencies;
    runScript = "zed";
    extraInstallCommands = ''
      mkdir -p $out/share/applications
      cp ${inputs.zed.packages.x86_64-linux.default}/share/applications/*.desktop $out/share/applications/
    '';
  };

  eslintFormatter = [{code_action = "source.fixAll.eslint";}];
in {
  config = {
    home.packages = [] ++ extensionDependencies;

    programs.zed-editor = {
      enable = true;
      package = zedPackage;
      userSettings = {
        theme = "Dracula";
        load_direnv = "shell_hook";

        project_panel.dock = "right";
        agent.dock = "left";

        private_files = [
          "**/.env.*"
          "!**/.env.example"
          "**/.dev.vars"
        ];

        toolbar = {
          breadcrumbs = false;
          quick_actions = false;
          selections_menu = false;
          agent_review = false;
          code_actions = false;
        };

        gutter.line_numbers = true;

        cursor_blink = true;

        format_on_save = "on";

        languages = {
          "Nix".formatter.external = {
            command = "alejandra";
            arguments = ["--quiet" "--"];
          };
          JavaScript.formatter = eslintFormatter;
          TypeScript.formatter = eslintFormatter;
          TSX.formatter = eslintFormatter;
          JSX.formatter = eslintFormatter;
        };

        tab_size = 2;

        lsp.nil.initialization_options.nix.flake = {
          autoArchive = true;
          autoEvalInputs = false;
          nixpkgsInputName = "nixpkgs";
        };

        diagnostics.inline.enabled = true;

        which_key = {
          enabled = true;
          delay_ms = 50;
        };

        ui_font_size = 16;
        buffer_font_size = 14;

        terminal = {
          env.TERM = "ghostty";
          working_directory = "current_project_directory";
        };
      };

      userKeymaps = [
        {
          context = "Workspace";
          bindings = {
            ctrl-b = "workspace::ToggleRightDock";
            ctrl-alt-b = "workspace::ToggleLeftDock";
          };
        }
      ];

      extensions = [
        "discord-presence"
        "ghostty"
        "html"
        "nix"
        "sql"
      ];
    };
  };
}
