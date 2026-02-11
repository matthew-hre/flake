{pkgs, ...}: {
  home.packages = with pkgs; [
    # nix
    nil
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
    # zls - TODO: wait for master to get merged into nixpkgs-unstable
    gopls
    rust-analyzer

    # markdown + config languages
    marksman
    harper
    taplo
    yaml-language-server
  ];
}
