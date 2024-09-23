{ 
  self,
  ... 
}:

let flakePath = self;

in let
    _wm-kde          = "${flakePath}/home-manager/user-elly/window-manager/_kde.nix";
    _pkgs-cli        = "${flakePath}/home-manager/user-elly/_pkgs-general-cli.nix";
    _pkgs-linux-gui  = "${flakePath}/home-manager/user-elly/_pkgs-linux-gui.nix";
    _pkgs-linux-cli  = "${flakePath}/home-manager/user-elly/_hm.elly.pkgs-linux-cli.nix";
    _pkgs-dev        = "${flakePath}/home-manager/user-elly/_pkgs-dev.nix";
    _dotfiles        = "${flakePath}/home-manager/user-elly/dotfiles/default.nix";
    _shells          = "${flakePath}/home-manager/user-elly/_shells.nix";
    _git             = "${flakePath}/home-manager/user-elly/_git.nix";
    _shell-defaults  = "${flakePath}/home-manager/user-elly/_shell-defaults.nix";

in {
    desciption =  "This defines the nire-durandal host-specific user config for elly";
    
    imports = [
      _wm-kde
      _pkgs-cli
      _pkgs-linux-gui
      _pkgs-linux-cli
      _pkgs-dev
      _dotfiles
      _shells
      _shell-defaults
      _git
    ];

  ## Defaults
    nixpkgs.config = {
        allowUnfree          =     true;            # Disable if you don't want unfree packages
        allowUnfreePredicate = (_: true);           # Workaround for https://github.com/nix-community/home-manager/issues/2942
    };
    home.username            = "elly";
    home.homeDirectory       = "/home/elly";

    home.stateVersion        = "22.11"; # Do not edit. To figure this out (in-case it changes) you can comment out the line and see what version it expected.
}

# REMINDER: home manager broke, so I had to use `nix-shell -p home-manager` to bootstrap