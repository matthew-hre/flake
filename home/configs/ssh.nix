{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks."*" = {
      forwardAgent = false;
      addKeysToAgent = "no";
      compression = false;
      serverAliveInterval = 0;
      serverAliveCountMax = 3;
      hashKnownHosts = false;
      userKnownHostsFile = "~/.ssh/known_hosts";
      controlMaster = "no";
      controlPath = "~/.ssh/master-%r@%n:%p";
      controlPersist = "no";
    };

    matchBlocks."knot.matthew-hre.com" = {
      hostname = "knot.matthew-hre.com";
      port = 2222;
      user = "git";
      addressFamily = "inet";
    };

    extraConfig = "
Host *
  IdentityAgent ~/.1password/agent.sock
    ";
  };
}
