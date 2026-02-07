{pkgs, ...}: {
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
      tv init fish | source
    '';
    shellInit = ''
      # Clear any leftover universal Tide variables so globals take precedence cleanly
      for var in (set -Un | string match -r '^_?tide')
          set -Ue $var
      end

      # Tide prompt configuration (lean, two-line)
      set -g tide_left_prompt_items pwd git jj cmd_duration newline character
      set -g tide_right_prompt_items

      set -g tide_left_prompt_frame_enabled false
      set -g tide_right_prompt_frame_enabled false
      set -g tide_prompt_add_newline_before false
      set -g tide_prompt_pad_items false
      set -g tide_prompt_transient_enabled false
      set -g tide_prompt_color_frame_and_connection brblack
      set -g tide_prompt_color_separator_same_color brblack
      set -g tide_prompt_min_cols 34

      set -g tide_left_prompt_prefix ""
      set -g tide_left_prompt_suffix " "
      set -g tide_left_prompt_separator_diff_color " "
      set -g tide_left_prompt_separator_same_color " "
      set -g tide_right_prompt_prefix " "
      set -g tide_right_prompt_suffix ""
      set -g tide_right_prompt_separator_diff_color " "
      set -g tide_right_prompt_separator_same_color " "

      # PWD (purple, hardcoded — no ANSI purple in standard palette)
      set -g tide_pwd_bg_color normal
      set -g tide_pwd_color_anchors AF87FF
      set -g tide_pwd_color_dirs 875FD7
      set -g tide_pwd_color_truncated_dirs 6C5B9E
      set -g tide_pwd_markers .bzr .citc .git .hg .jj .node-version .python-version .ruby-version .shorten_folder_marker .svn .terraform bun.lock Cargo.toml composer.json CVS go.mod package.json build.zig flake.nix

      # Git colors
      set -g tide_git_bg_color normal
      set -g tide_git_bg_color_unstable normal
      set -g tide_git_bg_color_urgent normal
      set -g tide_git_color brblack
      set -g tide_git_color_branch brblack
      set -g tide_git_color_conflicted red
      set -g tide_git_color_dirty yellow
      set -g tide_git_color_operation red
      set -g tide_git_color_staged yellow
      set -g tide_git_color_stash brblack
      set -g tide_git_color_untracked cyan
      set -g tide_git_color_upstream brblack

      # JJ colors
      set -g tide_jj_bg_color normal
      set -g tide_jj_color brblack
      set -g tide_jj_icon ""

      # Prompt character
      set -g tide_character_color magenta
      set -g tide_character_color_failure red
      set -g tide_character_icon ❯
      set -g tide_character_vi_icon_default ❯
      set -g tide_character_vi_icon_replace ❯
      set -g tide_character_vi_icon_visual ❯

      # Command duration (yellow)
      set -g tide_cmd_duration_bg_color normal
      set -g tide_cmd_duration_color yellow
      set -g tide_cmd_duration_decimals 0
      set -g tide_cmd_duration_threshold 3000
      set -g tide_cmd_duration_icon ""

      # Nix shell (icon only)
      set -g tide_nix_shell_bg_color normal
      set -g tide_nix_shell_color cyan
      set -g tide_nix_shell_icon \uf313
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
        name = "tide";
        src = pkgs.fishPlugins.tide.src;
      }
    ];
    functions = {
      _tide_item_git = ''
                # Skip git info when in a JJ repo
                if command -sq jj; and jj root --quiet &>/dev/null
                    return 1
                end

                if git branch --show-current 2>/dev/null | string shorten -"$tide_git_truncation_strategy"m$tide_git_truncation_length | read -l location
                    git rev-parse --git-dir --is-inside-git-dir | read -fL gdir in_gdir
                    set location $_tide_location_color$location
                else if test $pipestatus[1] != 0
                    return
                else if git tag --points-at HEAD | string shorten -"$tide_git_truncation_strategy"m$tide_git_truncation_length | read location
                    git rev-parse --git-dir --is-inside-git-dir | read -fL gdir in_gdir
                    set location '#'$_tide_location_color$location
                else
                    git rev-parse --git-dir --is-inside-git-dir --short HEAD | read -fL gdir in_gdir location
                    set location @$_tide_location_color$location
                end

                if test -d $gdir/rebase-merge
                    if not path is -v $gdir/rebase-merge/{msgnum,end}
                        read -f step <$gdir/rebase-merge/msgnum
                        read -f total_steps <$gdir/rebase-merge/end
                    end
                    test -f $gdir/rebase-merge/interactive && set -f operation rebase-i || set -f operation rebase-m
                else if test -d $gdir/rebase-apply
                    if not path is -v $gdir/rebase-apply/{next,last}
                        read -f step <$gdir/rebase-apply/next
                        read -f total_steps <$gdir/rebase-apply/last
                    end
                    if test -f $gdir/rebase-apply/rebasing
                        set -f operation rebase
                    else if test -f $gdir/rebase-apply/applying
                        set -f operation am
                    else
                        set -f operation am/rebase
                    end
                else if test -f $gdir/MERGE_HEAD
                    set -f operation merge
                else if test -f $gdir/CHERRY_PICK_HEAD
                    set -f operation cherry-pick
                else if test -f $gdir/REVERT_HEAD
                    set -f operation revert
                else if test -f $gdir/BISECT_LOG
                    set -f operation bisect
                end

                test $in_gdir = true && set -l _set_dir_opt -C $gdir/..
                set -l stat (git $_set_dir_opt --no-optional-locks status --porcelain 2>/dev/null)
                string match -qr '(0|(?<stash>.*))\n(0|(?<conflicted>.*))\n(0|(?<staged>.*))
        (0|(?<dirty>.*))\n(0|(?<untracked>.*))(\n(0|(?<behind>.*))\t(0|(?<ahead>.*)))?' \
                    "$(git $_set_dir_opt stash list 2>/dev/null | count
                    string match -r ^UU $stat | count
                    string match -r ^[ADMR] $stat | count
                    string match -r ^.[ADMR] $stat | count
                    string match -r '^\?\?' $stat | count
                    git rev-list --count --left-right @{upstream}...HEAD 2>/dev/null)"

                if test -n "$operation$conflicted"
                    set -g tide_git_bg_color $tide_git_bg_color_urgent
                else if test -n "$staged$dirty$untracked"
                    set -g tide_git_bg_color $tide_git_bg_color_unstable
                end

                _tide_print_item git $_tide_location_color$tide_git_icon' ' (set_color white; echo -ns $location
                    set_color $tide_git_color_operation; echo -ns ' '$operation ' '$step/$total_steps
                    set_color $tide_git_color_upstream; echo -ns ' ⇣'$behind ' ⇡'$ahead
                    set_color $tide_git_color_stash; echo -ns ' *'$stash
                    set_color $tide_git_color_conflicted; echo -ns ' ~'$conflicted
                    set_color $tide_git_color_staged; echo -ns ' +'$staged
                    set_color $tide_git_color_dirty; echo -ns ' !'$dirty
                    set_color $tide_git_color_untracked; echo -ns ' ?'$untracked)
      '';
      _tide_item_jj = ''
        if not command -sq jj
            return 1
        end

        if not jj root --quiet &>/dev/null
            return 1
        end

        set -l change_id (jj log --ignore-working-copy --no-graph --color never -r @ -T 'change_id.short(8)' 2>/dev/null)
        or return 1

        _tide_print_item jj "@$change_id"
      '';
      _tide_item_cmd_duration = ''
        test $CMD_DURATION -gt $tide_cmd_duration_threshold; or return
        set -l t \
            (math -s0 "$CMD_DURATION/3600000") \
            (math -s0 "$CMD_DURATION/60000"%60) \
            (math -s$tide_cmd_duration_decimals "$CMD_DURATION/1000"%60)
        if test $t[1] != 0
            _tide_print_item cmd_duration "$t[1]h $t[2]m $t[3]s"
        else if test $t[2] != 0
            _tide_print_item cmd_duration "$t[2]m $t[3]s"
        else
            _tide_print_item cmd_duration "$t[3]s"
        end
      '';
      _tide_item_character = ''
        test $_tide_status = 0 && set_color $tide_character_color || set_color $tide_character_color_failure

        set -q add_prefix || echo -ns ' '

        if set -q IN_NIX_SHELL
            set_color $tide_nix_shell_color
            echo -ns $tide_nix_shell_icon '  '
            test $_tide_status = 0 && set_color $tide_character_color || set_color $tide_character_color_failure
        end

        test "$fish_key_bindings" = fish_default_key_bindings && echo -ns $tide_character_icon ||
            switch $fish_bind_mode
                case insert
                    echo -ns $tide_character_icon
                case default
                    echo -ns $tide_character_vi_icon_default
                case replace replace_one
                    echo -ns $tide_character_vi_icon_replace
                case visual
                    echo -ns $tide_character_vi_icon_visual
            end
      '';
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
