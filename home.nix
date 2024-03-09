{ config, pkgs, ... }:

{
  home.username = "mheiber";
  home.homeDirectory = "/home/mheiber";
  home.stateVersion = "23.11";
  news.display = "silent";

  home.packages = [
    pkgs.nixpkgs-fmt
  ];

  home.file = { };

  home.sessionVariables = {
    DOCKER_BUILDKIT = 1;
    GTK_IM_MODULE = "xim";
    EDITOR = "vim";
    BROWSER = "firefox";
  };

  programs = {
    home-manager = {
      enable = true;
    };
    bash = {
      enable = true;
    };
    starship = {
      enable = true;
      enableBashIntegration = true;
    };
    mcfly = {
      enable = true;
      enableBashIntegration = true;
      fzf.enable = true;
    };
    fzf = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
