{ pkgs, ... }: {
  home.username = "hugo";
  home.homeDirectory = "/Users/hugo";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}
