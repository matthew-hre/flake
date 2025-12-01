{
  config,
  lib,
  ...
}: {
  options.modules.services.pipewire.enable = lib.mkEnableOption "pipewire support";

  config = lib.mkIf config.modules.services.pipewire.enable {
    services.pulseaudio.enable = false;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    services.pipewire.wireplumber.extraConfig.bluetoothEnhancements = {
      "monitor.bluez.properties" = {
        "bluez5.enable-sbc-xq" = true;
        "bluez5.enable-msbc" = false;
        "bluez5.enable-hw-volume" = true; ### <<< Enables touch slider on headphones for fader gain, pause, and unpause functionality
        "bluez5.auto-connect" = ["a2dp_sink"]; ### <<< Autoconnect to HD 48khz mode on connect
        "bluez5.roles" = ["a2dp_sink" "a2dp_source"]; ### <<< This  sets the BT driver role to a2dp sink and source, which are the HD 44.1khz and 48khz module modesets but doesnt load the modules for hsp, which is the handset driver that enables the mic.
      };
    };
  };
}
