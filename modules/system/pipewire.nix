{ pkgs, ... }:
{
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    wireplumber.enable = true;
    wireplumber.extraConfig."99-force-profile"."alsa_monitor.rules" = [
      {
        matches = [ { "device.name" = "matches:alsa_card.usb-*"; } ];
        apply_properties."device.profile" = "output:iec958-stereo+input:mono-fallback";
      }
    ];
  };

  services.pipewire.wireplumber.extraConfig.bluetoothEnhancements = {
    "monitor.bluez.properties" = {
      "bluez5.enable-sbc-xq" = true;
      "bluez5.enable-msbc" = true;
      "bluez5.enable-hw-volume" = true;
      "bluez5.roles" = [
        "hsp_hs"
        "hsp_ag"
        "hfp_hf"
        "hfp_ag"
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    playerctl
  ];
}
