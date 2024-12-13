{ config, pkgs, ... }:

{
  home.username = "mo";
  home.homeDirectory = "/home/mo";

  home.stateVersion = "25.05";

  home.packages = [
    #pkgs.neovim #Works
     (pkgs.writeShellScriptBin "tsup" ''
       sudo tailscale up --exit-node=m2mini --exit-node-allow-lan-access
     '') # works (the shortcut runs the command atleast but running it = no internet) add one for sudo tailscale down (std for short?)
  ];
  programs.oh-my-posh.enable = true;
  programs.oh-my-posh.enableFishIntegration = true;

  # The primary way to manage plain files is through 'home.file'.
  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "code";
  };

  # GNOME Extensions testing:
  
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "dash-to-dock@micxgx.gmail.com"
        "tiling-assistant@leleat-on-github"
        "status-icons@gnome-shell-extensions.gcampax.github.com"
        "weeks-start-on-monday@extensions.gnome-shell.fifi.org"
        "transparent-top-bar@ftpix.com"
      ];
    };
    #"org/gnome/shell/extensions/dash-to-dock" = {

    #}
  };

programs.git = {
    enable = true;
    userName = "MOAB";
    userEmail = "mo@a.b";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
