{
  config,
  lib,
  pkgs,
  ...
}: let
  caches = import ../../lib/caches.nix;

  beginMarker = "# BEGIN flake caches (home-manager)";
  endMarker = "# END flake caches (home-manager)";

  cacheBlock = ''
    ${beginMarker}
    extra-substituters = ${lib.concatStringsSep " " caches.substituters}
    extra-trusted-public-keys = ${lib.concatStringsSep " " caches.trustedPublicKeys}
    ${endMarker}
  '';

  installScript = pkgs.writeShellScript "install-nix-caches" ''
    set -euo pipefail

    sudo=/usr/bin/sudo
    systemctl=/usr/bin/systemctl
    target=/etc/nix/nix.custom.conf
    tmpFile=$(${pkgs.coreutils}/bin/mktemp)

    echo "installNixCaches: updating $target (sudo required)" >&2

    if $sudo ${pkgs.coreutils}/bin/test -f "$target"; then
      $sudo ${pkgs.coreutils}/bin/cp "$target" "$tmpFile"
      ${pkgs.gnused}/bin/sed -i "/^${beginMarker}$/,/^${endMarker}$/d" "$tmpFile"
    else
      : > "$tmpFile"
    fi

    {
      ${pkgs.coreutils}/bin/cat "$tmpFile"
      cat <<'EOF'
${cacheBlock}EOF
    } | $sudo ${pkgs.coreutils}/bin/tee "$target" > /dev/null

    ${pkgs.coreutils}/bin/rm "$tmpFile"
    $sudo $systemctl restart nix-daemon.service
    echo "installNixCaches: updated $target and restarted nix-daemon" >&2
  '';
in lib.mkIf config.targets.genericLinux.enable {
  # Determinate Nix on Debian only uses substituters configured at the daemon level.
  home.activation.installNixCaches = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD ${installScript}
  '';
}
