{ lib, config, pkgs, inputs, ... }:

{
  imports = [
    ./zsh
  ];

  services = {
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  system = {
    stateVersion = "22.11";
  };

  home-manager.users.danielmarbach.programs = {
    direnv = {
      enable = true;
      nix-direnv = { enable = true; };
    };
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than-7d";
    };

    settings = {
      trusted-users = [ "root" "danielmarbach" ];
      extra-sandbox-paths = [ "/bin/sh=${pkgs.bash}/bin/sh" ];
    };

    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
      builders-use-substitutes = true
      keep-outputs = true
      keep-derivations = true
    '';
  };

  virtualisation.lxd.enable = true;

  users.users = {
    danielmarbach = {
      description = "The primary user account";
      isNormalUser = true;
      shell = pkgs.zsh;
      uid = 1000;

      extraGroups = [
        "lxd"
        "wheel"
        "video"
        "networkmanager"
        "libvirtd"
        "kvm"
        "input"
        "adbusers"
        "rtkit"
        "cdrom"
      ];
    };
  };
  
  environment = {
    pathsToLink = [ "/libexec" "/share/zsh" ];
    systemPackages = with pkgs; [
      home-manager
      man-db
      fzf
      zsh
      fd
      nix-update
    ];
  };
}
