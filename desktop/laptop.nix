{ config, lib, pkgs, ... }: {
  services = {
    tlp = {
      enable = true;
      settings = {
        TLP_ENABLE = 1;
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 80;
        START_CHARGE_THRESH_BAT1 = 75;
        STOP_CHARGE_THRESH_BAT1 = 80;
        RESTORE_THRESHOLDS_ON_BAT = 1;
        CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
        DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth";
        DEVICES_TO_ENABLE_ON_STARTUP = "wifi";
        PCIE_ASPM_ON_BAT = "powersupersave";
      };
    };
  };

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
