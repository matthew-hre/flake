{config, ...}: {
  programs.direnv = {
    enable = true;
    enableFishIntegration = false;
    nix-direnv.enable = true;
    config = {
      global = {
        disable_stdin = true;
        hide_env_diff = true;
        log_filter = "loading .*\\.envrc$";
        warn_timeout = "0ms";
      };
    };
  };

  programs.fish.interactiveShellInit = ''
    # A nested Fish would otherwise make direnv restore the outer environment at
    # its first prompt, discarding paths added by nix-shell.
    if set -q IN_NIX_SHELL
      functions -e __direnv_export_eval __direnv_export_eval_2 __direnv_cd_hook
    else if not functions -q __direnv_export_eval
      ${config.programs.direnv.package}/bin/direnv hook fish | source
    end
  '';

  programs.git.ignores = [".direnv/"];
}
