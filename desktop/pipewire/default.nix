{ pkgs, ... }:

{
  security.rtkit.enable = true;
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = false;
  sound.enable = true;

  environment.systemPackages = with pkgs; [
    blueman
    playerctl
    easyeffects
  ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
}
