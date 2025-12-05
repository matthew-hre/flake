{pkgs, ...}: {
  services.dunst = {
    enable = true;
    settings.global = {
      monitor = 0;
      follow = "mouse";

      # geometry
      width = 350;
      origin = "top-right";
      scale = 0;
      offset = "9x9";
      notification_limit = 3;

      # progress bar
      progress_bar = true;
      progress_bar_height = 10;
      progress_bar_frame_width = 1;
      progress_bar_min_width = 150;
      progress_bar_max_width = 300;

      indicate_hidden = "yes";
      transparency = 0;
      separator_height = 1;
      padding = 8;
      horizontal_padding = 10;
      text_icon_padding = 0;
      frame_width = 1;
      frame_color = "#44475A";
      separator_color = "frame";
      sort = "no";
      idle_threshold = 120;

      # Text

      font = "Work Sans 10";
      line_height = 0;
      markup = "full";
      format = "<small><b>%a :</b>%s</small>\n%b";
      alignment = "left";
      vertical_alignment = "center";
      show_age_threshold = 60;
      ellipsize = "middle";
      ignore_newline = "no";
      stack_duplicates = true;
      hide_duplicate_count = false;
      show_indicators = "yes";

      icon_position = "left";
      min_icon_size = 24;
      max_icon_size = 32;
      icon_path = "${pkgs.papirus-icon-theme}";

      sticky_history = "yes";
      history_length = 20;

      corner_radius = 11;
    };

    settings.urgency_low = {
      background = "#282a36";
      foreground = "#ffffff";
      timeout = 10;
    };

    settings.urgency_normal = {
      background = "#282a36";
      foreground = "#ffffff";
      timeout = 10;
    };

    settings.urgency_critical = {
      background = "#ff5555";
      foreground = "#f8f8f2";
      frame_color = "#ff5555";
      timeout = 0;
    };
  };
}
