#
# Shell
#

{ lib, home-manager, pkgs, ... }:
{
  programs = {
    zsh = {
      enable = true;
    };
  };
  home-manager.users.danielmarbach.programs.zsh = {
    enable = true;
    enableCompletion = true;

    oh-my-zsh = {
        enable = true;
        plugins = [
            "git"
            "zsh-autosuggestions"
        ];
        theme = "robbyrussell";
      };
  };
}
