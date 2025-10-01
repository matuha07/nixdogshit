{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];


  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.kernelParams = [ "split_lock_detect=warn" ];
  
  boot.loader.efi.canTouchEfiVariables = true;
  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;


  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        ControllerMode = "bredr";

        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
    allowedUDPPorts = [ ];    
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "mydatabase" "testdb" ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
    '';
  };




  time.timeZone = "Asia/Almaty";

   services.pipewire = {
     enable = true;
     pulse.enable = true;
   };


  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  services = {
     desktopManager.plasma6.enable = true;
     displayManager.ly.enable = true;
   };


   users.users.motya = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     shell = pkgs.zsh;
   };

  programs.firefox.enable = true;
  programs.zsh.enable = true;
  programs.steam.enable = true;


  
  nix.settings.experimental-features = ["nix-command" "flakes"];
  home-manager.backupFileExtension = "backup";

  
  environment.systemPackages = with pkgs; [
     vim
     wget
     git
     vlc
     wayland-utils
     wl-clipboard
     kitty
     vscode
     gcc
     tmux
   ];

   virtualisation.docker = {
    enable = true;
   };



  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = null;
      UseDns = true;
      PermitRootLogin = "prohibit-password";
    };
  };

  
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}

