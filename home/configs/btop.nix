{
  config,
  pkgs,
  lib,
  ...
}: {
  options.btop = {
    amdGpuSupport = lib.mkEnableOption "enable AMD GPU support (rocm-smi) in btop";
  };

  config = {
    programs.btop = {
      enable = true;
      package =
        if config.btop.amdGpuSupport
        then
          pkgs.btop.overrideAttrs (old: rec {
            buildInputs = (old.buildInputs or []) ++ [pkgs.rocmPackages.rocm-smi];
            postFixup = lib.concatStringsSep "\n" [
              (old.postFixup or "")
              ''
                patchelf --add-rpath ${lib.getLib pkgs.rocmPackages.rocm-smi}/lib \
                  $out/bin/btop
              ''
            ];
          })
        else pkgs.btop;

      settings = {
        color_theme = "Dracula";
        theme_background = false;
        selected_gpus = "0";
      };
    };
  };
}
