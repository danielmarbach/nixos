{ lib, home-manager, pkgs, ... }:
{
  home-manager.users.danielmarbach.programs.vscode = {
    enable = true;

    extensions = with pkgs.vscode-extensions; [
      yzhang.markdown-all-in-one
      esbenp.prettier-vscode
      ms-vsliveshare.vsliveshare
      bbenoist.nix
      brettm12345.nixfmt-vscode
    ];
  };
}
