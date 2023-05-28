{ config, lib, pkgs, modulesPath, inputs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1
    (modulesPath + "/installer/scan/not-detected.nix")
    ../core
    ../desktop/laptop.nix
    ../desktop
  ];

  virtualisation.libvirtd.enable = true;
  time.timeZone = "Europe/Zurich";

  environment.systemPackages = with pkgs; [ virt-manager ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    initrd = {
      availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "usbhid" "sr_mod" ];
      kernelModules = [ "dm-snapshot" ];
      secrets = {
        "/crypto_keyfile.bin" = null;
       };
    };

    loader = {
      systemd-boot = {
        enable = true;
      };
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
    };
  };

  networking = {
    hostName = "x1carbon";
  };
  
  fileSystems."/" =
  { device = "/dev/disk/by-uuid/be3e77ef-fa9a-46a3-a39a-f30aed6276d5";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-d3d1c3d7-b8aa-454e-b016-39206f7a6580".device = "/dev/disk/by-uuid/d3d1c3d7-b8aa-454e-b016-39206f7a6580";

  fileSystems."/boot/efi" =
  { device = "/dev/disk/by-uuid/8E25-2DA0";
    fsType = "vfat";
  };
    
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;
}
