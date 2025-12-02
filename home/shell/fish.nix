{pkgs, ...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      set --universal pure_enable_nixdevshell true
      set --universal pure_symbol_nixdevshell_prefix " "

      # https://github.com/NixOS/nixpkgs/issues/462025
      set -p fish_complete_path ${pkgs.fish}/share/fish/completions

      function _pure_prompt_nixdevshell \
          --description "Indicate if nix develop shell is activated (icon only)"

          if set --query pure_enable_nixdevshell;
              and test "$pure_enable_nixdevshell" = true;
              and test -n "$IN_NIX_SHELL"

              set --local prefix (_pure_set_color $pure_color_nixdevshell_prefix)$pure_symbol_nixdevshell_prefix
              set --local symbol (_pure_set_color $pure_color_nixdevshell_status)

              echo "$prefix$symbol"
          end
      end

      function copyfile
          cat $argv | wl-copy
      end

      zoxide init fish | source
      tv init fish | source
    '';
    shellAliases = {
      ls = "eza -la --octal-permissions --git";
      cat = "bat";
      grep = "grep -n --color";
      mkdir = "mkdir -pv";
      lg = "lazygit";
      ".." = "cd ..";
      ":q" = "exit";
      find = "fd";
    };
    plugins = [
      {
        name = "pure";
        src = pkgs.fishPlugins.pure.src;
      }
    ];
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
