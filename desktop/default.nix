{ pkgs, ... }: {
  imports = [
    ./pipewire
    ./vscode
    ./firefox
    ./gnome
  ];

  home-manager.users.root.home.stateVersion = "22.11";

  home-manager.users.danielmarbach = {
    home.stateVersion = "22.11";

    home.sessionVariables = {
      XDG_SESSION_TYPE = "wayland";
      XDG_DATA_DIRS = with pkgs; "${pkgs.gnome.adwaita-icon-theme}/share:$XDG_DATA_DIRS";
    };
  };

  programs = {
    light.enable = true;
  };

  services.fwupd = { enable = true; };
  
  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_US.UTF-8";

  services = {
  xserver = {
    layout = "us,de";
    xkbVariant = "intl,";
    xkbOptions = "grp:win_space_toggle";
  };
 };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      extraPackages = with pkgs; [
        vaapiIntel
        intel-media-driver
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };

  networking.networkmanager.enable = true;

  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fontconfig = {
      enable = true;
      defaultFonts = { monospace = [ "Inconsolata" ]; };
    };
    fonts = with pkgs; [
      corefonts
      inconsolata
      ubuntu_font_family
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      proggyfonts
      awesome
      dejavu_fonts
      nerdfonts
      hack-font
      cantarell-fonts
    ];
  };

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    pathsToLink = [ "/libexec" ];
    systemPackages = with pkgs; [
      libva-utils
      lm_sensors
      linux-pam
      appimage-run
      keepassxc
      solaar
      zoom-us
      linuxPackages.perf
    ];
  };
}
