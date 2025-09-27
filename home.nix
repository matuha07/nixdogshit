{ config, pkgs, ... }:

{
  home.username = "motya";
  home.homeDirectory = "/home/motya";

  home.packages = with pkgs; [
    tree
    discord
    cloudflare-warp
    nodejs
    fastfetch
    rustup
    btop
    unzip
    krita
    qbittorrent
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 1000;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "rust" "kitty" ];
      theme = "agnoster";
    };
  };

  programs.neovim = {
    enable = true;
    extraConfig = ''
      set number relativenumber
    '';
  };

  programs.kitty = {
    enable = true;
    themeFile = "Dracula";
    settings = {
      confirm_os_window_close = 0;
    };
  };

  programs.zen-browser.enable = true;

  home.stateVersion = "25.05";
}
