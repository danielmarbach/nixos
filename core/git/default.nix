{ lib, home-manager, pkgs, ... }: {
  home-manager.users = {
    danielmarbach.programs.git = {
      enable = true;
      userName = "Daniel Marbach";
      userEmail = "daniel.marbach@openplace.net";
      extraConfig = {
        pull.rebase = true;
        init.defaultBranch = "main";
        github.user = "danielmarbach";
      };
      ignores = [ ".envrc" ".direnv" ];
    };
    root.programs.git = {
      enable = true;
      userName = "Daniel Marbach";
      userEmail = "daniel.marbach@openplace.net";
      extraConfig = {
        pull.rebase = true;
        init.defaultBranch = "main";
        github.user = "danielmarbach";
        safe.directory = "/etc/nixos";
      };
    };
  };
}
