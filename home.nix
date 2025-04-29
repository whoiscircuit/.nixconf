{config,pkgs,...}: {
  home.packages = with pkgs; [
    sway
    hyprland
    foot
    git
  ];

  programs.home-manager.enable = true;
  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "24.11";
}
