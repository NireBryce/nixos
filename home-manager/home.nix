{ 
  self,
  ...
}:

let flakeRoot = self;
in {
  imports = [
  # home manager config fragments
    "${flakeRoot}/home-manager/dev"
    "${flakeRoot}/home-manager/dotfiles"
    "${flakeRoot}/home-manager/_hm.window-manager.nix"      # window-manager specific packages
    "${flakeRoot}/home-manager/_hm.shells.nix"              # shells
  ];
  wm-kde.enable = true; # move to user configs
  nixpkgs.config.allowUnfree = true;                   # Disable if you don't want unfree packages
  nixpkgs.config.allowUnfreePredicate = (_: true);     # Workaround for https://github.com/nix-community/home-manager/issues/2942

  programs.home-manager.enable = true;
}

# TODO: remove the declarations from individual modules such that you can not have to maintain those when you add/remove packages 

