{ config, pkgs, ... }:

let
  impermanence = builtins.fetchTarball "https://github.com/nix-community/impermanence/archive/master.tar.gz";
in
{ 
  imports = 
  [ 
    # Nix-generated
      ./hardware-configuration.nix
      ./stateVersion.nix

    # shared modules
      ../_common
      ../_specialized
      ../_specialized/_gui
      
      #TODO: ../specialized/_gpu/_intel.nix
      #TODO: ../specialized/_mouse/trackpoint.nix
      
  ];
# hostname
  networking.hostName = "nire-galatea"; 
}



