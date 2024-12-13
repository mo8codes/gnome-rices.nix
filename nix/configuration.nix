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
  pipes
  git
  librewolf
  keepassxc
  helix
  #jetbrains.pycharm-community-bin
  jetbrains.rust-rover
  jetbrains.clion
  #jetbrains.webstorm
  wget
  vscode
  authenticator
  calibre
  krita
  anki
  gcc
  #virtualbox
  blender
  slack
  discord
  bambu-studio
  #lmstudio
  qbittorrent
  waydroid
  rustup #$rustup install stable
  fish
  pkgs.oh-my-posh
  nerdfetch
  fastfetch
  nerd-fonts.ubuntu-sans
  # GNOME Extensions:
  pkgs.gnomeExtensions.dash-to-dock
  #pkgs.gnomeExtensions.vitals
  pkgs.gnomeExtensions.tiling-assistant
  pkgs.gnomeExtensions.weeks-start-on-monday-again
  #pkgs.gnomeExtensions.appindicator
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
  
  # Allows dconf settings in home.nix (GNOME Extensions)
  programs.dconf.enable = true;
  
  # Keep at version of first installation
  system.stateVersion = "unstable"; #25.05 / unstable
}
