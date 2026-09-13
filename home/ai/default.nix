{
  inputs,
  pkgs,
  lib,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
  agents = inputs.llm-agents.packages.${system};
  agentAlias = pkgs.writeShellScriptBin "agent" ''
    exec ${lib.getExe agents.cursor-agent} "$@"
  '';
  parallelCli = pkgs.writeShellScriptBin "parallel-cli" ''
    exec "$HOME/.local/share/parallel-cli/parallel-cli" "$@"
  '';
  opencode2 = inputs.llm-agents.packages.${system}.opencode2.overrideAttrs (old: {
    postInstall =
      (old.postInstall or "")
      + ''
        wrapProgram "$out/bin/opencode2" \
          --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [pkgs.wayland]}
      '';
  });
in {
  home.packages =
    (with agents; [
      cursor-agent
      agentAlias
      amp
      crush
      opencode2
    ])
    ++ [
      parallelCli
    ];
}
