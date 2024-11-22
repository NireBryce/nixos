{
  self,
  pkgs,
  lib,
  ...
}:
let flakePath = self;
in {
    # Notes:
    # If you get `zsh side` errors, delete ~/.zcompdump and ~/.config/zsh/.zcompdump and run `zi update`
    # installing multiple highlighters causes "zsh_zle-highlight-buffer-p:4: permission denied error
    # in this case it was trapd00r/zsh-syntax-highlighting-filetypes which highlights more than filetypes turns out

    # TODO: evaluate oh-my-zsh, prezto

    # TODO: replace p10k with `starship` now that p10k is in life support mode
    programs = { # zsh specific, it dedups them if they're already enabled
        dircolors.enable = true; 
        dircolors.enableZshIntegration = true;

        direnv      .enableZshIntegration = true;
        eza         .enableZshIntegration = true;
        zellij      .enableZshIntegration = true;
        broot       .enableZshIntegration = true;
        nix-index   .enableZshIntegration = true;
        
        zoxide = {
          enable = true;
          enableZshIntegration = true;
          options = [
            "--cmd x" # change zoxide binding to not interfere with zi
          ];
        };

        atuin = {       
          enable = true;
          enableZshIntegration = true;
          settings = {
            inline_height = 40;     # search window height
            style = "compact";
            show_preview = true;
            show_help = true;
            secrets_filter = true;
          };
        };            

        fzf = {
            enable = true;
            enableZshIntegration = true;
            defaultOptions = [
                "--height 40%"
                "--layout=reverse"
                "--border"
                "--inline-info"
                "--color 'fg:#\${vars.colors.base05}'"              # Text
                "--color 'bg:#\${vars.colors.base00}'"              # Background
                "--color 'preview-fg:#\${vars.colors.base05}'"      # Preview window text
                "--color 'preview-bg:#\${vars.colors.base02}'"      # Preview window background
                "--color 'hl:#\${vars.colors.base0A}'"              # Highlighted substrings
                "--color 'fg+:#\${vars.colors.base0D}'"             # Text (current line)
                "--color 'bg+:#\${vars.colors.base02}'"             # Background (current line)
                "--color 'gutter:#\${vars.colors.base02}'"          # Gutter on the left (defaults to bg+)
                "--color 'hl+:#\${vars.colors.base0E}'"             # Highlighted substrings (current line)
                "--color 'info:#\${vars.colors.base0E}'"            # Info line (match counters)
                "--color 'border:#\${vars.colors.base0D}'"          # Border around the window (--border and --preview)
                "--color 'prompt:#\${vars.colors.base05}'"          # Prompt
                "--color 'pointer:#\${vars.colors.base0E}'"         # Pointer to the current line
                "--color 'marker:#\${vars.colors.base0E}'"          # Multi-select marker
                "--color 'spinner:#\${vars.colors.base0E}'"         # Streaming input indicator
                "--color 'header:#\${vars.colors.base05}'"          # Header
            ];
        };
        kitty = {
          extraConfig = ''
            clipboard_control write-clipboard write-primary read-clipboard-ask read-primary-ask
          
            kitty_mod ctrl+shift

            map kitty_mod+c copy_to_clipboard
            map cmd+c       copy_or_interrupt

            map kitty_mod+v paste_from_clipboard
            map cmd+v       paste_from_clipboard


          '';
        };
    };
  
    home.packages = with pkgs; [  # Things needed for my .zshrc
        diff-so-fancy
        inshellisense
        starship
        zoxide
        atuin
        tree
        # zi                              # zsh plugin manager, doesn't work fsr
        ruby                            # zi depends on `gem`
        nix-zsh-completions

        zsh-f-sy-h
        zsh-fzf-tab
        zsh-nix-shell
        zsh-completions
        zsh-autocomplete
        zsh-autosuggestions
        # zsh-powerlevel10k # in zi
        zsh-system-clipboard
        zsh-you-should-use
        

    ];
  
    programs.zsh = let               
        p10k_cfg          = lib.fileContents "${flakePath}/home-manager/user-elly/dotfiles/zsh/010-p10k.zsh";
        bindings_cfg      = lib.fileContents "${flakePath}/home-manager/user-elly/dotfiles/zsh/initial-bindings.zsh";
        setopts_cfg       = lib.fileContents "${flakePath}/home-manager/user-elly/dotfiles/zsh/initial-setopts.zsh";
        zstyle_cfg        = lib.fileContents "${flakePath}/home-manager/user-elly/dotfiles/zsh/initial-zstyle.zsh";
        zi_cfg            = lib.fileContents "${flakePath}/home-manager/user-elly/dotfiles/zsh/020-zi.zsh";
        zi_plugins_cfg    = lib.fileContents "${flakePath}/home-manager/user-elly/dotfiles/zsh/zi-plugins.zsh";
        atuin_cfg         = lib.fileContents "${flakePath}/home-manager/user-elly/dotfiles/zsh/021-atuin.zsh";
        zellij_keys_cfg   = lib.fileContents "${flakePath}/home-manager/user-elly/dotfiles/zsh/040-free-zellij-keys.zsh";
    in {
        
        
        enable = true;
        autocd = false;
        enableVteIntegration = true;
        autosuggestion.enable = true;
        enableCompletion = false;       # enabled through config, removing one compinit call.        
        zsh-abbr.enable = true;
        # enableBashCompletion = true; # TODO: why doesn't this work? https://search.nixos.org/options?channel=unstable&show=programs.zsh.enableBashCompletion&from=0&size=50&sort=relevance&type=packages&query=zsh
        
        localVariables = {
          # local variables
          # _ZO_CMD_PREFIX="x";
        };
        plugins = [ 
          { 
            name = "zsh-mask";  # formerly "passwordless-history"
            src = pkgs.fetchFromGitHub { 
              owner = "jgogstad";
              repo = "zsh-mask";
              rev = "master";
              sha256 = "sha256-u4ZDWKSnk27rBz6ZYLLgWy4yHTgxfK2apPCZEOcMwt4="; # TODO: replace after run, magic 
            };
          }
          {
            name = "zsh-colored-man-pages";
            src = pkgs.fetchFromGitHub {
              owner = "ael-code";
              repo = "zsh-colored-man-pages";
              rev = "master";
              sha256 = "sha256-087bNmB5gDUKoSriHIjXOVZiUG5+Dy9qv3D69E8GBhs="; # TODO: replace after run, magic
            };
          }
          {
            name = "zsh-256color";
            src = pkgs.fetchFromGitHub {
              owner = "chrissicool";
              repo = "zsh-256color";
              rev = "master";
              sha256 = "sha256-OoK+LMUaFYxLrGG6awb5fU97jXNT0SFACO3AbLheZNU="; # TODO: replace after run, magic
            };
          }
          {
            name = "colorize";
            src = pkgs.fetchFromGitHub { # TODO: can you live without?
              owner = "zpm-zsh";
              repo = "colorize";
              rev = "master";
              sha256 = "sha256-OoK+LMUaFYxLrGG6awb5fU97jXNT0SFACO3AbLheZNU="; # TODO: replace after run, magic
            };
          }
          {
            name = "zsh-completion-generator"; # TODO: just switch to fish? would need to learn how to config it.
            src = pkgs.fetchFromGitHub {
              owner = "RobSis";
              repo = "zsh-completion-generator";
              rev = "master";
              sha256 = "sha256-OoK+LMUaFYxLrGG6awb5fU97jXNT0SFACO3AbLheZNU="; # TODO: replace after run, magic
            };
          }
          {
            name = "zsh-bash-completions-fallback";
            src = pkgs.fetchFromGitHub {
              owner = "3v1n0";
              repo = "zsh-bash-completions-fallback";
              rev = "master";
              sha256 = "sha256-X219zFA0HEeZgOtP7G0lyRwKDSUAQrjaFMUJYAd6084="; # TODO: replace after run, magic
            };
          }
        ];

      # .zshrc
        shellAliases = {
          
        };
        
        initExtraFirst = ''
          zmodload zsh/zprof                                # zsh profiler

          #################PASSWORD ENTRY/CONFIRM DIALOGS GO ABOVE##############################

          # Powerlevel10k instant prompt.  input above, else below
            ${p10k_cfg}                                       

          # keybindings from various configs
            ${bindings_cfg}
          # end keybindings

          # setopts
            ${setopts_cfg}
          # end setopts

          # zstyle
            ${zstyle_cfg}                                     
          # end zstyle

          typeset -U path cdpath fpath manpath              # TODO: magic, no idea what it does anymore.
          autoload -U add-zsh-hook                          # TODO: Magic, no idea what it does anymore.

          zmodload zsh/terminfo                             # load terminfo

          WORDCHARS='*?[]~=&;!#$%^(){}<>';                  # Dont consider certain characters part of the word
          
          
        '';
        
        initExtraBeforeCompInit = ''
          # zi
            # zi bootstrap
            # ${zi_cfg}
            # end zi bootstrap

            # Zi plugins
            # ${zi_plugins_cfg}
            # end zi plugins
          # end zi

          [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh      # TODO: marked for deletion, p10k deprecated

          zicompinit                                        # zi cleanup
          autoload -Uz compinit
          compinit -C
        '';
        initExtra = ''
          # TODO: pull these into nix
          # Aliases
            alias "ll"="ls -l";
            alias "cp"="cp -i";                                     # Confirm before overwriting something
            alias "cd"="x";                                        # Empty oneletter for zoxide to not interfere with zi
            alias "exa"="eza --icons=always";                       # back compat for one of the tools
            alias "ls"="eza --icons=always --header --group-directories-first --hyperlink";
            alias "rustdevshell"="nix develop ~/nixos/dev-shells/rust#";
          # Atuin bindings and shell integration
          # ${atuin_cfg} # TODO: remove
          # Free up bindings for zellij
          ${zellij_keys_cfg}  


          # Necessary to run flakes, otherwise `#` gets expanded
            disable -p '#'  

          # Inshellisense
            # eval "$(is init zsh)"

          # homebrew
          export PATH="/opt/homebrew/bin:$PATH" # TODO: pull this out into nix path definitions
      
        '';
    };
}

        # # f-sy-h is better, but has been flakey lately and i trust z-shell (unaffiliated with ZSH) about as far as I can throw them.
        # # consider switching back
        # syntaxHighlighting = {
        #   enable = true;
        #   # package = "";
        #   highlighters = [
        #     "brackets"
        #     "pattern"
        #     "regexp"
        #     # "cursor"
        #     "root"
        #     "line"
        #   ];
        # };   

## Bash
  #? Shell integrations go here but main bash config is in the system one.
    # programs.bash.sessionVariables = {
    # };
    # programs.bash.shellAliases = {
    # };
  #? user bash aliases
    # programs.bash.shellAliases = {
    # };

  #? Extra commands that should be run when initializing an interactive shell.
    # programs.bash.initExtra = ''
    #     ${pkgs.inshellisense}/bin/inshellisense;
    # '';

  #? Extra commands that should be placed in {file}~/.bashrc.
  #?   Note that these commands will be run even in non-interactive shells.
    # programs.bash.bashrcExtra = ''
    # '';
  #? Extra commands that should be run when initializing a login shell.
  # programs.bash.profileExtra = ''
  # '';
  #? Extra commands that should be run when logging out of an interactive shell.
  # programs.bash.logoutExtra = ''
  # '';

  # programs.zellij.enableBashIntegration = true;
  # programs.zoxide.enableBashIntegration = true;
  # programs.starship.enableBashIntegration = true;
  # programs.nix-index.enableBashIntegration = true;
  # programs.kitty.shellIntegration.enableBashIntegration = true;
  # programs.fzf.enableBashIntegration = true;
  # programs.exa.enableBashIntegration = true;
  # programs.atuin.enableBashIntegration = true;


  # # For LS_COLORS customization options run this in shell:
  # for theme in $(vivid themes); do
  #     echo "Theme: $theme"
  #     LS_COLORS=$(vivid generate $theme)
  #     ls
  #     echo
  # done

# old code

  # dotDir=".config/zsh";
  # plugins = [
  # {
  #   name = "powerlevel10k";
  #   src = pkgs.zsh-powerlevel10k;
  #   file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  # }
  # {
  #   name = "powerlevel10k-config";
  #   src = config/zsh-powerlevel10k; file = ".p10k.zsh";
  #   }
  # ];






# history = {
#   path = "${config.xdg.configHome}/zsh/history";
#   save = 5000;
# };

# from fleek / getfleek.dev (RIP)
  # "apply-nire-durandal" = "nix run --impure home-manager/master -- -b bak switch --flake .#elly@nire-durandal";
  # "apply-nire-galatea" = "nix run --impure home-manager/master -- -b bak switch --flake .#elly@nire-galatea";
  # "apply-nire-lysithea" = "nix run --impure home-manager/master -- -b bak switch --flake .#elly@nire-lysithea";

# Whats this do? something from ancient compinit start time debugging
      # for dump in ~/.zcompdump(N.mh+24); do
      #   compinit
      # done
