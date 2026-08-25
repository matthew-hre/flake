{pkgs, ...}: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --asterisks --theme border=green;text=white;prompt=green;time=green;action=purple;button=green;container=black;input=white";
        user = "greeter";
      };
    };
  };
}
