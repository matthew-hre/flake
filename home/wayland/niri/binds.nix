{
  config,
  lib,
  ...
}: {
  programs.niri.settings.binds = with config.lib.niri.actions; let
    workspaceBindings = lib.listToAttrs (builtins.concatMap (i: [
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
      "Mod+Shift+Ctrl+F".action = toggle-windowed-fullscreen;
      "Mod+G".action = toggle-window-floating;
      "Mod+C".action = center-column;

      "Mod+V".action.spawn = ["vicinae" "vicinae://extensions/vicinae/clipboard/history"];
      "Mod+Period".action.spawn = ["vicinae" "vicinae://extensions/vicinae/core/search-emojis"];

      "Mod+L".action.spawn = ["dms" "ipc" "call" "lock" "lock"];
      "Mod+N".action.spawn = ["dms" "ipc" "call" "notifications" "toggle"];
      "Mod+M".action.spawn = ["dms" "ipc" "call" "processlist" "focusOrToggle"];
      "Mod+Comma".action.spawn = ["dms" "ipc" "call" "settings" "focusOrToggle"];

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

      "Mod+Alt+Left".action = focus-monitor-left;
      "Mod+Alt+Right".action = focus-monitor-right;

      "Mod+Shift+Alt+Left".action = move-window-to-monitor-left;
      "Mod+Shift+Alt+Right".action = move-window-to-monitor-right;

      "Mod+Shift+Ctrl+Left".action = consume-or-expel-window-left;
      "Mod+Shift+Ctrl+Right".action = consume-or-expel-window-right;

      "Mod+Shift+S".action.screenshot = [];
      "Print".action.spawn = ["dms" "ipc" "call" "quickCapture" "screenshot" "region" "edit"];
      "Mod+Ctrl+Shift+S".action.spawn = ["dms" "ipc" "call" "screenCaptureToolbar" "toggle"];

      "Mod+Shift+Slash".action = show-hotkey-overlay;

      "Ctrl+Alt+Delete".action.spawn = ["dms" "ipc" "call" "powermenu" "toggle"];

      "XF86AudioRaiseVolume".action.spawn = ["dms" "ipc" "call" "audio" "increment" "10"];
      "XF86AudioRaiseVolume".allow-when-locked = true;
      "XF86AudioLowerVolume".action.spawn = ["dms" "ipc" "call" "audio" "decrement" "10"];
      "XF86AudioLowerVolume".allow-when-locked = true;
      "XF86AudioMute".action.spawn = ["dms" "ipc" "call" "audio" "mute"];
      "XF86AudioMute".allow-when-locked = true;
      "XF86AudioMicMute".action.spawn = ["dms" "ipc" "call" "mic" "mute"];
      "XF86AudioMicMute".allow-when-locked = true;
      "XF86AudioPlay".action.spawn = ["dms" "ipc" "call" "mpris" "playPause"];
      "XF86AudioPlay".allow-when-locked = true;
      "XF86AudioNext".action.spawn = ["dms" "ipc" "call" "mpris" "next"];
      "XF86AudioNext".allow-when-locked = true;
      "XF86AudioPrev".action.spawn = ["dms" "ipc" "call" "mpris" "previous"];
      "XF86AudioPrev".allow-when-locked = true;
      "XF86AudioStop".action.spawn = ["dms" "ipc" "call" "mpris" "stop"];
      "XF86AudioStop".allow-when-locked = true;
      "XF86MonBrightnessDown".action.spawn = ["dms" "ipc" "call" "brightness" "decrement" "5" ""];
      "XF86MonBrightnessDown".allow-when-locked = true;
      "XF86MonBrightnessUp".action.spawn = ["dms" "ipc" "call" "brightness" "increment" "5" ""];
      "XF86MonBrightnessUp".allow-when-locked = true;

      "Mod+Z".action = toggle-overview;
    }
    // workspaceBindings;
}
