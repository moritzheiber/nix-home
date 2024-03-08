{ config, pkgs, ... }:

{
  home.username = "mheiber";
  home.homeDirectory = "/home/mheiber";
  home.stateVersion = "23.11";

  home.packages = [
  ];

  home.file = {
  };

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;
  programs.bash = {
    enable = true;
  };
}
