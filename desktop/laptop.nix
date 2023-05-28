{ config, lib, pkgs, ... }: {

  boot = {
    kernelParams = [ "mem_sleep_default=deep" "pcie_aspm=force" ];
    extraModprobeConfig = ''
      options iwlwifi power_save=1
      options iwlmvm power_scheme=3
    '';
  };

  environment.systemPackages = with pkgs; [ powertop ];

  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = "schedutil";
  };

  security = {
    pam = {
      services = {
        login.fprintAuth = true;
        swaylock-effects.fprintAuth = true;
        sudo.fprintAuth = true;
        system-local-login.fprintAuth = true;
        su.fprintAuth = true;
      };
    };
  };

  services = {
    fprintd = { enable = true; };
    thermald = { enable = true; };
  };

  networking = {
    wireless.iwd.enable = true;
    networkmanager = {
      wifi.backend = "iwd";
      wifi.powersave = true;
    };
  };
}
