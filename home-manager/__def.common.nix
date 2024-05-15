{
  imports = [
    ./_dev
    ./_dotfiles
    ./_cfg......nix # config
    ./_pkg......nix # packages
    ./_snd......nix # sound
    ./_sys......nix # system
    ./_usr......nix # user
    ./_wm......nix  # window manager
    ./_zsh......nix # zsh
  ];
}

# TODO: remove the declarations from individual modules such that you can not have to maintain those when you add/remove packages

