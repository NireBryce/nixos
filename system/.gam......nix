{ 
  ...
}:

# games metapackage
{
  programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      gamescopeSession.enable = true; # third party gamescope compositor
    }; 
}
