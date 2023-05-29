{ lib, home-manager, pkgs, ... }:
{
    services = {
        xserver = {
            enable = true;
            displayManager = {
            gdm = {
                enable = true;
            };
            };
            desktopManager = {
            gnome = {
                enable = true;
            };
            };
        };
    };

    programs.dconf.enable = true;

    dconf.settings = {
        "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
        };
    };

  environment = {
    systemPackages = with pkgs; [
        gnome.gnome-tweaks
    ];
  };
}
