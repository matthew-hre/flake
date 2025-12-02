{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      global = {
        disable_stdin = true;
        hide_env_diff = true;
        warn_timeout = "0ms";
      };
    };
  };

  programs.git.ignores = [".direnv/"];
}
