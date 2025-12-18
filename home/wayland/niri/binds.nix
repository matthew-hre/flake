{
  config,
  pkgs,
  ...
}: {
  programs.niri.settings.binds = with config.lib.niri.actions; let
    sh = spawn "sh" "-c";
    powerMenu = pkgs.writeShellScript "power-menu" ''
      choice=$(echo -e " Lock\n Reboot\n⏻ Shutdown" | fuzzel --dmenu -l 7 -p "󰚥 ")
      case "$choice" in
        *"Lock")
          hyprlock
          ;;
        *"Reboot")
          systemctl reboot
          ;;
        *"Shutdown")
          systemctl poweroff
          ;;
      esac
    '';
    workspaceBindings = lib.listToAttrs (concatMap (i: [
      {
        name = "Mod+${toString i}";
        value.action = focus-workspace i;
      }
      {
        name = "Mod+Shift+${toString i}";
        value.action.move-window-to-workspace = i;
      }
    ]) (lib.range 1 9));
  in
    {
      "Mod+Space".action.spawn = ["vicinae" "vicinae://toggle"];
      "Mod+Return".action.spawn = ["ghostty" "+new-window"];
      "Mod+Q".action = close-window;
      "Mod+F".action = maximize-column;
      "Mod+Shift+F".action = fullscreen-window;
      "Mod+G".action = toggle-window-floating;
      "Mod+C".action = center-column;

      "Mod+V".action.spawn = ["vicinae" "vicinae://extensions/vicinae/clipboard/history"];
      "Mod+Period".action.spawn = ["vicinae" "vicinae://extensions/vicinae/vicinae/search-emojis"];

      "Mod+L".action.spawn = ["hyprlock"];

      "Mod+Minus".action = set-column-width "-10%";
      "Mod+Equal".action = set-column-width "+10%";

      "Mod+Shift+Minus".action = set-window-height "-10%";
      "Mod+Shift+Equal".action = set-window-height "+10%";

      "Mod+Left".action = focus-column-left;
      "Mod+Down".action = focus-workspace-down;
      "Mod+Up".action = focus-workspace-up;
      "Mod+Right".action = focus-column-right;

      "Mod+Shift+Left".action = move-column-left;
      "Mod+Shift+Down".action = move-window-down;
      "Mod+Shift+Up".action = move-window-up;
      "Mod+Shift+Right".action = move-column-right;

      "Mod+Shift+Ctrl+Left".action = consume-or-expel-window-left;
      "Mod+Shift+Ctrl+Right".action = consume-or-expel-window-right;

      "Mod+Shift+S".action.screenshot = [];
      "Print".action.screenshot = [];

      "Mod+Shift+Slash".action = show-hotkey-overlay;

      "Ctrl+Alt+Delete".action.spawn = ["${powerMenu}"];

      "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+" "--limit" "1.0"];
      "XF86AudioRaiseVolume".allow-when-locked = true;
      "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"];
      "XF86AudioLowerVolume".allow-when-locked = true;
      "XF86AudioMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
      "XF86AudioMute".allow-when-locked = true;
      "XF86AudioMicMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"];
      "XF86AudioMicMute".allow-when-locked = true;
      "XF86MonBrightnessDown".action.spawn = ["brightnessctl" "set" "5%-"];
      "XF86MonBrightnessUp".action.spawn = ["brightnessctl" "set" "5%+"];

      "Mod+Z".action = toggle-overview;
    }
    // workspaceBindings;
}
