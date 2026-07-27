{pkgs, ...}: {
  home.packages = with pkgs; [
    # nix
    nil
    nixd
    alejandra

    # web (html/css/js/ts/react/next)
    typescript-language-server
    vscode-langservers-extracted
    tailwindcss-language-server
    # oxlint/oxfmt: Helix uses `pnpx` so project node_modules win; not on PATH
    superhtml

    # python
    ruff
    ty

    # go
    # zls - TODO: wait for master to get merged into nixpkgs-unstable
    gopls

    # shell / markdown / config
    bash-language-server
    marksman
    markdown-oxide
    harper
    taplo
    tombi
    yaml-language-server
    terraform-ls
  ];
}
