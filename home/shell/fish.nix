{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting

      set -g __prompt_needs_spacer 0

      function __prompt_set_spacer --on-event fish_preexec
          set -g __prompt_needs_spacer 1
      end

      function __prompt_print_spacer --on-event fish_prompt
          if test "$__prompt_needs_spacer" -eq 1
              echo
          end
          set -g __prompt_needs_spacer 0
      end

      # https://github.com/NixOS/nixpkgs/issues/462025
      set -p fish_complete_path ${pkgs.fish}/share/fish/completions

      function copyfile
          cat $argv | wl-copy
      end

      zoxide init fish | source
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
      nvim = "hx";
      code = "zed";
    };
    functions = {
      fish_prompt = ''
        # Two-line cockpit:
        # ~/Repos/glue @ main
        # ❯
        set -l last_status $status
        set -l symbol '❯ '
        set -l color $fish_color_cwd
        if fish_is_root_user
            set symbol '# '
            set -q fish_color_cwd_root
            and set color $fish_color_cwd_root
        end

        set_color $color
        echo -n (prompt_pwd)
        set_color --reset

        # Bookmark on @ if any, otherwise short change id. Skip outside jj repos.
        set -l jj_info (
            jj log -r @ --ignore-working-copy --no-graph \
                -T 'coalesce(local_bookmarks.map(|b| b.name()).join(" "), change_id.shortest(8))' \
                2>/dev/null
        )
        if test -n "$jj_info"
            set_color brblack
            echo -n ' @ '
            set_color $fish_color_command
            echo -n $jj_info
            set_color --reset
        end

        echo
        if set -q IN_NIX_SHELL
            set_color cyan
            echo -n \uf313' '
            set_color --reset
        end
        if test $last_status -eq 0
            set_color normal
        else
            set_color red
        end
        echo -n $symbol
        set_color normal
      '';
    };
  };

  # On non-NixOS, keep a POSIX login shell and only enter fish interactively.
  # Avoids /etc/passwd pointing at a nix-profile path that can disappear.
  programs.bash = lib.mkIf config.targets.genericLinux.enable {
    enable = true;
    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
