{
  pkgs,
  inputs,
  ...
}: {
  programs.zed-editor = {
    enable = true;
    package = inputs.zed.packages.x86_64-linux.default;
    userSettings = {
      theme = "Dracula";
      ui_font_size = 12;
      buffer_font_size = 12;
    };
  };
}
