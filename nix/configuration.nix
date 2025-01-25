{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./stuff.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  programs.fish.enable = true;
  programs.bash = {
  interactiveShellInit = ''
    if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
    then
      shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
      exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
    fi
  '';
  };
                                                                                                              

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mo = {
    isNormalUser = true;
    description = "mo";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
    home = "/home/mo";
    };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      mo = import ./home.nix;
    };
  };

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Packages to install:
  environment.systemPackages = with pkgs; [

  # 
  librewolf # Web browser
  calibre # Kindle book manager
  keepassxc # Password manager
  authenticator # 2FA code generator
  anki # Flashcards
  libreoffice-qt6-fresh # Office alternative
  qbittorrent # Torrent client
  waydroid # Android Emulator

  # Temp
  zim # Local wiki
  joplin-desktop # Markdown
  qownnotes # Markdown

  # Programming
  ntfs3g # For accessing NTFS drives (Windows formatted)
  gcc
  git  
  wget
  curl
  racket
  python3Full
  vscodium
  helix

  # Communication
  slack
  discord
  
  # CAD / 3D Printing / Art
  blender
  bambu-studio
  krita  

  # Terminal
  fish
  oh-my-posh

  # Fonts
  corefonts
  nerd-fonts.ubuntu-sans

  # GNOME Extensions:
  gnomeExtensions.dash-to-dock
  gnomeExtensions.vitals
  gnomeExtensions.tiling-assistant
  gnomeExtensions.weeks-start-on-monday-again
  gnomeExtensions.appindicator
  ];

  # GNOME packages to NOT install.
  environment.gnome.excludePackages = with pkgs; [
    epiphany # gnome web
    gnome-backgrounds
    gnome-tour
    baobab # Disk Usage Analyzer
    gnome-text-editor
    gnome-calculator
    gnome-calendar
    geary # mail client
    gnome-characters
    gnome-contacts
    gnome-maps # pretty cool actually
    gnome-weather
    simple-scan # document scanner
    snapshot # camera app
  ];

  # List services that you want to enable:
  nixpkgs.config.allowUnfree = true;
  services.tailscale.enable = true;
  virtualisation.waydroid.enable = true;
  # services.openssh.enable = true;
  services.tailscale.useRoutingFeatures = "client";
  # Allows dconf settings in home.nix (GNOME Extensions)
  programs.dconf.enable = true;
  
  # Keep at version of first installation
  system.stateVersion = "unstable"; #25.05 / unstable
}
