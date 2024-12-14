{
  inputs = {
  # 23.11
  # TODO: bump
    nixpkgs-stable.url                          = "github:NixOS/nixpkgs/nixos-23.11";
  # Unstable
    # nixpkgs.url                                 = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url                                 = "github:NixOS/nixpkgs/nixpkgs-unstable"; # TODO: this is a YOLO fix for https://github.com/nix-community/home-manager/issues/5991,  I have already spent too much time on this
                                                                                           #* notice that it's nixpkgs.unstable not nixos.unstable 

  # Darwin
    darwin.url                                  = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows               = "nixpkgs";

  # secret management
    sops-nix.url                                = "github:mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows             = "nixpkgs";
    sops-nix.inputs.nixpkgs-stable.follows      = "nixpkgs";

  # Home Manager
    home-manager.url                            = "github:nix-community/home-manager/master";
    home-manager-unstable.url                   = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.inputs.nixpkgs.follows         = "nixpkgs";

  # populate nix index
    nix-index-database.url                      = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows   = "nixpkgs";

    
    
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,                                         # https://nixos-and-flakes.thiscute.world/nixos-with-flakes/downgrade-or-upgrade-packages
    darwin,
    home-manager,
    nixos-hardware,
    nix-index-database,
    # nixos-hardware-b550-stopgap,                          # TODO: fix flake.nix on nixos-hardware repo
    ...
  } @ inputs: 
  {
    
       
    
    # Reusable nixos modules you might want to export
    # nixosModules    = import ./___modules;                  # there are better names for this, but this is de-facto standard
    # homeManagerModules = import ./modules/home-manager

    overlays        = import ./___overlays {inherit inputs;};

  
  
  # nire-lysithea (macbook)
  # TODO: FIXME `sudo nixos-rebuild switch --flake .#nire-durandal`
  # TODO: FIXME `nh os switch --hostname nire-durandal ~/nixos/`
    darwinConfigurations."nire-lysithea"     = darwin.lib.darwinSystem {
      specialArgs = { inherit inputs ; };
      system      = "aarch64-darwin";
      modules     = [
        ./system-config/nire-lysithea-configuration.nix
        # nix-index-database.darwinModules.nix-index
      
        # TODO: stylix
        # inputs.stylix.darwinModules.stylix
        
        home-manager.darwinModules.home-manager 
        {
          home-manager = { 
            users.elly = import ./home-manager/user-elly/home-nire-lysithea.nix;
          };
          users.users.elly.home = "/Users/elly";
        }

        # nix-index-database.hmModules.nix-index
        # { programs.nix-index-database.comma.enable = true; }
        # todo: fix this

      ];
    # Expose the package set, including overlays, for convenience.
    # TODO: fixme
      #  darwinPackages = self.darwinConfigurations."nire-lysithea".pkgs;
    };
  # elly@nire-lysithea
  #  homeConfigurations."elly@nire-lysithea.local" = home-manager.lib.homeManagerConfiguration {
  #     pkgs = import nixpkgs {
  #       system = "aarch64-darwin";
  #       config = { 
  #         allowUnfree = true; 
  #         useGlobalPkgs   = true;
  #         useUserPackages = true; 
  #       };
  #     };
  #     extraSpecialArgs = inputs;
  #     modules = [
  #       ./home-manager/user-elly/home-nire-lysithea.nix     # Elly home manager config
  #       nix-index-database.hmModules.nix-index
  #         { programs.nix-index-database.comma.enable = true; }
  #     ];
      
  #   };

  

# NOTE: for nix-index to work with flake installs, you must `nix profile install` something
#   see: https://github.com/nix-community/nix-index/issues/167
#   `nix profile install nixpkgs#hello


################################################################################
# NOTE FOR ZSH
# https://www.reddit.com/r/NixOS/comments/1539s44/using_flakes_for_configurationnix/
# https://stackoverflow.com/questions/12303805/oh-my-zsh-hash-pound-symbol-bad-pattern-or-match-not-found/57380936#57380936
# this fixes nix-flakes
#   disable -p '#'
# otherwise `nixos-rebuild --flake .#hostname` will not get evaluated correctly.
################################################################################
