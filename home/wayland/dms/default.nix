{
  hostname,
  inputs,
  lib,
  pkgs,
  ...
}: let
  lockTimeout =
    if hostname == "donkeykong"
    then 1800
    else 300;
  suspendTimeout =
    if hostname == "donkeykong"
    then 14400
    else 0;
in {
  imports = [inputs.dms.homeModules.dank-material-shell];

  programs.dank-material-shell = {
    enable = true;

    systemd.enable = true;

    clipboardSettings.disabled = true;

    plugins.quickCapture = {
      enable = true;
      src = inputs.dms-plugin-registry.packages.${pkgs.stdenv.hostPlatform.system}.quickCapture;
    };
    plugins.screenCaptureToolbar = {
      enable = true;
      src = inputs.dms-plugin-registry.packages.${pkgs.stdenv.hostPlatform.system}.screenCaptureToolbar;
    };

    settings = {
      blurWallpaperOnOverview = true;

      currentThemeName = "dynamic";
      currentThemeCategory = "dynamic";
      matugenScheme = "scheme-tonal-spot";

      # Vicinae remains the launcher and clipboard-history owner.
      showLauncherButton = false;
      showClipboard = false;
      dockLauncherEnabled = false;
      niriOverviewOverlayEnabled = false;
      builtInPluginSettings.dms_clipboard_search.enabled = false;

      barConfigs = [
        {
          id = "default";
          name = "Main Bar";
          enabled = true;
          position = 0;
          screenPreferences = ["all"];
          showOnLastDisplay = true;

          leftWidgets = [
            {
              id = "clock";
              enabled = true;
            }
            {
              id = "weather";
              enabled = true;
            }
          ];
          centerWidgets = [
            {
              id = "music";
              enabled = true;
              mediaSize = 3;
            }
          ];
          rightWidgets = [
            {
              id = "systemTray";
              enabled = true;
            }
            {
              id = "cpuUsage";
              enabled = true;
            }
            {
              id = "memUsage";
              enabled = true;
            }
            {
              id = "notificationButton";
              enabled = true;
            }
            {
              id = "controlCenterButton";
              enabled = true;
            }
          ];

          spacing = 0;
          innerPadding = 4;
          barInsetPadding = 8;
          bottomGap = -4;
          transparency = 0.0;
          widgetTransparency = 1.0;
          squareCorners = true;
          noBackground = false;
          gothCornersEnabled = false;
          borderEnabled = false;
          fontScale = 1.0;
          autoHide = false;
          autoHideDelay = 250;
          openOnOverview = false;
          visible = true;
          popupGapsAuto = true;
          popupGapsManual = 4;
          widgetOutlineEnabled = false;
          maximizeWidgetIcons = false;
          maximizeWidgetText = false;
          removeWidgetPadding = false;
        }
      ];

      waveProgressEnabled = false;
      updaterIntervalSeconds = 86400;

      # DMS owns locking, idle fade, and monitor power management.
      acLockTimeout = lockTimeout;
      batteryLockTimeout = lockTimeout;
      acSuspendTimeout = suspendTimeout;
      batterySuspendTimeout = suspendTimeout;
      acSuspendBehavior = 0;
      batterySuspendBehavior = 0;
      acPostLockMonitorTimeout = 10;
      batteryPostLockMonitorTimeout = 10;
      lockBeforeSuspend = true;
    };

    session = {
      wallpaperPath = "/home/matthew_hre/Pictures/Wallpapers/outer-wilds-dark.png";

      nightModeEnabled = true;
      nightModeAutoEnabled = true;
      nightModeAutoMode = "location";
      nightModeUseIPLocation = true;
    };
  };

  # Replace the mutable first-run state and clean plugin-store checkout with
  # their declarative equivalents.
  xdg.stateFile."DankMaterialShell/session.json".force = true;
  xdg.configFile."DankMaterialShell/plugins/quickCapture".force = true;

  home.activation.migrateQuickCapture = lib.hm.dag.entryBefore ["linkGeneration"] ''
    target="$HOME/.config/DankMaterialShell/plugins/quickCapture"
    backup="$target.pre-nix"

    if [[ -d "$target" && ! -L "$target" ]]; then
      if [[ -e "$backup" ]]; then
        echo "Cannot migrate Quick Capture: $backup already exists" >&2
        exit 1
      fi

      if [[ -v DRY_RUN ]]; then
        echo "Would move $target to $backup"
      else
        mv "$target" "$backup"
      fi
    fi
  '';
}
