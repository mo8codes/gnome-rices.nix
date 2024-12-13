{ config, pkgs, inputs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  
  networking.networkmanager.enable = true; # Enable networking

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8"; # Set internationalisation properties

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };


  console.keyMap = "uk"; # Configure console keymap

  services.printing.enable = false; # Enable CUPS to print documents.

  hardware.pulseaudio.enable = false; # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    
    #jack.enable = true; # If you want to use JACK applications, uncomment this
  };

  # services.xserver.libinput.enable = true; # Enable touchpad support (enabled default in most desktopManager).
    
  services.xserver.enable = true; # Enable the X11 windowing system.

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true; 
  services.xserver.desktopManager.gnome.enable = true; 

  # X11 keymap
  services.xserver.xkb = {
    layout = "gb"; # Configure keymap in X11
    variant = "";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

}