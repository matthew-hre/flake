let
  icons = rec {
    calendar = "󰃭 ";
    clock = " ";
    battery.charging = "󱐋";
    battery.horizontal = [" " " " " " " " " "];
    battery.vertical = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
    battery.levels = battery.vertical;
    network.disconnected = "󰤮 ";
    network.ethernet = "󰈀 ";
    network.strength = ["󰤟 " "󰤢 " "󰤥 " "󰤨 "];
    bluetooth.on = "󰂯";
    bluetooth.off = "󰂲";
    bluetooth.battery = "󰥉";
    volume.source = "󱄠";
    volume.muted = "󰝟";
    volume.levels = ["󰕿" "󰖀" "󰕾"];
    idle.on = "󰈈 ";
    idle.off = "󰈉 ";
    vpn = "󰌆 ";

    notification.red_badge = "<span foreground='red'><sup></sup></span>";
    notification.bell = "󰂚";
    notification.bell-badge = "󱅫";
    notification.bell-outline = "󰂜";
    notification.bell-outline-badge = "󰅸";
  };
in {
  programs.waybar = {
    enable = true;
    settings.mainBar = {
      layer = "top";
      modules-left = ["custom/clock"];
      modules-center = ["niri/window"];
      modules-right = ["wireplumber" "network" "bluetooth" "battery"];

      battery = {
        interval = 5;
        format = "{icon}  {capacity}%";
        format-charging = "${icons.battery.charging}  {capacity}%";
        format-icons = icons.battery.levels;
        states.warning = 20;
        states.critical = 10;
      };

      "custom/clock" = {
        exec = "date +\"%-I:%M:%S %p\"";
        interval = 1;
        tooltip = false;
      };

      network = {
        tooltip-format = "{ifname}";
        format-disconnected = icons.network.disconnected;
        format-ethernet = icons.network.ethernet;
        format-wifi = "{icon} {essid}";
        format-icons = icons.network.strength;
        on-click = "nmgui";
      };

      bluetooth = {
        format = "{icon}";
        format-disabled = "";
        format-icons = {
          inherit (icons.bluetooth) on off;
          connected = icons.bluetooth.on;
        };
        format-connected = "{icon} {device_alias}";
      };

      wireplumber = {
        format = "{icon} {volume}%";
        format-muted = "${icons.volume.muted} {volume}%";
        format-icons = icons.volume.levels;
        reverse-scrolling = 1;
        tooltip = false;
      };
    };
    style = let
      modules = s: "${s ".modules-left"}, ${s ".modules-center"}, ${s ".modules-right"}";
      module = s: modules (m: "${m} > ${s} > *");
    in ''
      * {
        border: none;
        font-family: "Work Sans";
        font-size: 14px;
      }

      window#waybar {
        background: transparent; /* #282A36; */
      }

      #workspaces button {
        padding: 0;
        margin: 0;
      }

      ${module ":first-child"} {
        padding-left: 10px;
      }

      ${module ":last-child"} {
        padding-right: 10px;
      }

      ${module "*"} {
          margin: 3px 1px;
          padding: 2px 6px;
      }

      #tooltip {
        background-color: #282A36;
      }
    '';
  };
}
