{inputs, pkgs, lib, ...}: let
  system = pkgs.stdenv.hostPlatform.system;
  agents = inputs.llm-agents.packages.${system};
  agentAlias = pkgs.writeShellScriptBin "agent" ''
    exec ${lib.getExe agents.cursor-agent} "$@"
  '';
in {
  home.packages = with agents; [
    cursor-agent
    agentAlias
    amp
    claude-code
    codex
    crush
  ];
}
