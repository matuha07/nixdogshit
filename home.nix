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
    gh
    pgadmin4
    go
    nixfmt-rfc-style
    steam-run
  ];


  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 1000;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "rust"
        "kitty"
      ];
      theme = "agnoster";
    };
  };
  

  programs.neovim = {
    enable = true;
    plugins =
      let
        nvim-treesitter-with-plugins = pkgs.vimPlugins.nvim-treesitter.withPlugins (
          treesitter-plugins: with treesitter-plugins; [
            bash
            lua
            nix
            python
            go
          ]
        );
      in
      with pkgs.vimPlugins;
      [
        nvim-lspconfig
        plenary-nvim
        nvim-treesitter-with-plugins
        nvim-autopairs
      ];
    extraLuaConfig = ''

      require("nvim-treesitter.configs").setup {
        highlight = { enable = true },
        indent = { enable = true },
      }

      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = true
      vim.opt.smartindent = true
      vim.opt.autoindent = true
      vim.opt.cindent = true
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
