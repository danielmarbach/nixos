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
      availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
      kernelModules = [ "dm-snapshot" ];
    };

    kernelModules = [ "kvm-intel" ];

    kernelParams =
      [ "intel_pstate=passive" "i915.enable_fbc=1" "i915.enable_psr=2" ];

    loader = {
      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        efiSupport = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {

    hostName = "x1carbon";
  };
}
