{ 
  self,
  ... 
}:

let flakePath = self;

in let
    hm-state            = "${flakePath}/home-manager/user-elly/_defaults-hm";
    hm-nix-defaults     = "${flakePath}/home-manager/user-elly/_defaults-nix.nix";

    wm-kde          = "${flakePath}/home-manager/user-elly/window-manager/_kde.nix";
    pkgs-cli        = "${flakePath}/home-manager/user-elly/_pkgs-general-cli.nix";
    pkgs-linux-gui  = "${flakePath}/home-manager/user-elly/_pkgs-linux-gui.nix";
    pkgs-linux-cli  = "${flakePath}/home-manager/user-elly/_hm.elly.pkgs-linux-cli.nix";
    pkgs-dev        = "${flakePath}/home-manager/user-elly/dev/default.nix";
    dotfiles        = "${flakePath}/home-manager/user-elly/dotfiles/default.nix";
    shells-bash     = "${flakePath}/home-manager/user-elly/_shells.bash.nix";
    shells-zsh      = "${flakePath}/home-manager/user-elly/_shells.zsh.nix";
    git             = "${flakePath}/home-manager/user-elly/_git.nix";
    shell-paths     = "${flakePath}/home-manager/user-elly/_shell-paths.nix";
    shell-aliases   = "${flakePath}/home-manager/user-elly/shell-aliases.nix";

in {
    desciption =  "This defines the nire-durandal host-specific user config for elly";
    
    imports = [
      hm-state
      hm-nix-defaults
      wm-kde
      pkgs-cli
      pkgs-linux-gui
      pkgs-linux-cli
      pkgs-dev
      dotfiles
      shells-bash
      shells-zsh
      shell-paths
      shell-aliases
      git
    ];
}

# REMINDER: home manager broke, so I had to use `nix-shell -p home-manager` to bootstrap
