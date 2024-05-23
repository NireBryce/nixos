{ pkgs, ...}:
# This is where the home-manager package list lives.  Do not consider this complete,
# as some packages are installed in their modules.
{



  
    home.packages = with pkgs; [    # TODO: figure out which should be modularized for, say, headless machines
      
      # Font config
        (nerdfonts.override { fonts = [ "FiraCode" ]; })
      
      # browsers                # browsers                                  # browsers
        kdePackages.konqueror       # one of the best `info` file pagers        https://invent.kde.org/network/konqueror
        firefox                     # TODO: also installed as a system package. https://www.mozilla.org/en-US/firefox/
      # comms                   # comms                                     # comms
        cinny-desktop               # matrix client                             https://github.com/cinnyapp/cinny-desktop
        discord                     # discord chat                              https://discord.com/
        keybase-gui                 # encrypted chat almost no one uses         https://keybase.io/
          keybase                   # see above                                 https://keybase.io/
        obs-studio                  # screen recording / streaming              https://obsproject.com/
        signal-desktop              # encrypted chat everone uses               https://signal.org/
        teamspeak_client            # teamspeak game comms                      https://www.teamspeak.com/
        wire-desktop                # old encrypted chat client, my ex used it  https://wire.com/
        zoom-us                     # less features than facetime somehow       https://zoom.us/
      # keyboard/mouse/text     # keyboard/mouse/text                       # keyboard/mouse/text
        qmk                         # qmk keyboard manager                      https://github.com/qmk/qmk_firmware
        piper                       # logitech/razer mouse manager              https://github.com/soxoj/piper
      # multi-machine           # multi-machine                             # multi-machine
        mosh                        # ssh but better                            https://mosh.org/
        input-leap                  # soft-KVM, synergy/barrier fork            https://github.com/input-leap/input-leap
      # media and sound         # media and sound                           # media and sound
        vlc                         # video player                              https://www.videolan.org/vlc/
        qpwgraph                    # sound mixer                               https://github.com/rncbc/qpwgraph
      # image editing           # image editing                             # image editing
        gimp                        # GNU Image Manipulation Program.           https://www.gimp.org
      # gpu diagnostics         # gpu diagnostics                           # gpu diagnostics
        vulkan-tools                # vulkan-tools                              https://github.com/KhronosGroup/Vulkan-Tools
        glxinfo                     # glxinfo                                   https://www.khronos.org/opengl/
        clinfo                      # clinfo                                    https://github.com/Oblomov/clinfo
        amdgpu_top                  # amdgpu_top gpu monitor                    https://github.com/Umio-Yasuno/amdgpu_top
      # desktop dev             # desktop dev                               # desktop dev
        vscode-fhs                  # vscode                                    https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/applications/editors/vscode/
        github-desktop              # github-desktop                            https://desktop.github.com/
      # dev cli tools           # dev cli tools                             # dev cli tools
        asdf-vm                     # asdf (use dev shells instead)             https://github.com/asdf-vm/asdf-vm
        diffutils                   # `diff` utils                              https://github.com/ogham/diffutils
        direnv                      # per-directory environments                https://github.com/direnv/direnv
        gnumake                     # gnumake                                   https://github.com/ogham/gnumake
        lazydocker                  # TUI docker interface                      https://github.com/jesseduffield/lazydocker
        riffdiff                    # provides `riff`, where-in-line diff       https://github.com/walles/riff
        # git                   # git                                       # git  
          gh                        # github cli                                https://github.com/cli/cli
          git                       # git scm                                   https://git-scm.com
          delta                     # `delta` - git diff                        https://github.com/dandavison/delta
          lazygit                   # TUI git interface                         https://github.com/jesseduffield/lazygit
        # bash                  # bash                                      # bash
          shellcheck                # bash linter                               https://www.shellcheck.net/
          shfmt                     # bash formatter                            https://github.com/mvdan/sh
        # linux debugging       # linux debugging                           # linux debugging
          lsof                      # list open files                           https://linux.die.net/man/1/lsof
          ltrace                    # library call tracer                       https://linux.die.net/man/1/ltrace
          strace                    # system call tracer                        https://linux.die.net/man/1/strace
          # dtrace                  # TODO FIND PACKAGE NAME                    https://wiki.freebsd.org/DTrace
      # tui editors             # tui editors                               # tui editors
        nano                        # text editor                               https://www.nano-editor.org/
        nanorc                      # nano syntax highlighting                  https://github.com/scopatz/nanorc
        neovim                      # text editor                               https://neovim.io/
      # 'productivity'          # 'productivity'                            # 'productivity'
        obsidian                    # pkm                                       https://obsidian.md/
        libreoffice-qt              # office                                    https://www.libreoffice.org/
      # terminals               # terminals                                 # terminals
        kitty                       # gpu accelerated terminal                  https://sw.kovidgoyal.net/kitty
        kitty-img                   # kitty image rendering engine, like sixel  https://git.sr.ht/~zethra/kitty-img
      # file transfer           # file transfer                             # file transfer
        magic-wormhole-rs           # easy transfer arbitrary files encrypted   https://github.com/magic-wormhole/magic-wormhole.rs
        rsync                       # up hill both ways                         https://linux.die.net/man/1/rsync
        aria2                       # cli download manager                      https://aria2.github.io/
        curl                        # `curl`                                    https://curl.se/download.html
        wget                        # its like curl but different               https://www.gnu.org/software/wget/
      # networking              # networking                                # networking
        dnsutils                    # `dig` + `nslookup`                        https://www.isc.org/bind/
        iftop                       # network monitor                           https://pdw.ex-parrot.com/iftop/
        ipcalc                      # IP address calculator                     https://gitlab.com/ipcalc/ipcalc
        iperf3                      # network tools                             https://software.es.net/iperf/
        ldns                        # provides `drill` a `dig` replacement      https://www.nlnetlabs.nl/projects/ldns/about/
        mtr                         # traceroute + ping                         https://www.bitwizard.nl/mtr/
        mtr-gui                     # GUI for mtr                               https://www.bitwizard.nl/mtr/
        nmap                        # network scanner                           http://www.nmap.org/
        socat                       # openbsd-netcat replacement                http://www.dest-unreach.org/socat/
        whois                       # whois lookup                              https://packages.qa.debian.org/w/whois.html
      # archive                 # archive                                   # archive
        zip                         # zip                                       http://www.info-zip.org/
        unzip                       # unzip                                     http://www.info-zip.org/
        p7zip                       # p7zip                                     https://github.com/p7zip-project/p7zip
      # shell                   # shell                                     # shell
        atuin                       # shell history                             https://github.com/ellie/atuin
        bash-completion             # bash complete                             https://github.com/scop/bash-completion
        bat                         # `cat` alternative                         https://github.com/sharkdp/bat
        bat-extras.batdiff          # bat diff                                  https://github.com/eth-p/bat-extras
        bat-extras.batgrep          # bat grep                                  https://github.com/eth-p/bat-extras
        bat-extras.batman           # TODO: broken                              https://github.com/eth-p/bat-extras
        bat-extras.batpipe          # bat pipe                                  https://github.com/eth-p/bat-extras
        bat-extras.batwatch         # bat watch                                 https://github.com/eth-p/bat-extras
        bat-extras.prettybat        # prettybat                                 https://github.com/eth-p/bat-extras
        broot                       # `br` - tree alternative                   https://github.com/Canop/broot
        btop                        # `htop` alternative                        https://github.com/aristocratos/btop
        du-dust                     # `du` alternative                          https://github.com/bootandy/dust
        duf                         # `df` alternative                          https://github.com/muesli/duf
        eza                         # `ls` alternative                          https://github.com/ogham/eza
        fd                          # `find` alternative                        https://github.com/sharkdp/fd
        file                        # `file` show filetype                      https://darwinsys.com/file
        fzf                         # fuzzy finder and fast TUI via piping      https://github.com/junegunn/fzf
        glow                        # terminal markdown viewer                  https://github.com/charmbracelet/glow
        hyfetch                     # neofetch replacement                      https://github.com/hykilpikonna/HyFetch
        jc                          # jc converts output into JSON or YAML      https://github.com/kellyjonbrazil/jc
        jq                          # json query                                https://github.com/stedolan/jq
        mc                          # midnight commander TUI file manager       https://www.midnight-commander.org/
        moar                        # better pager                              https://github.com/walles/moar
        nnn                         # TUI file manager                          https://github.com/jarun/nnn
        ripgrep                     # `rg` grep replacement                     https://github.com/BurntSushi/ripgrep
        tree                        # necessary for some zi things              https://oldmanprogrammer.net/source.php?dir=projects/tree
        vivid                       # LS_COLORS generator                       https://github.com/sharkdp/vivid
        which                       # `which`                                   https://www.gnu.org/software/which/
        yq-go                       # yaml query                                https://github.com/mikefarah/yq
        zellij                      # terminal multiplexer/tiler                https://zellij.dev/
        zoxide                      # smarter cd                                https://github.com/ajeetdsouza/zoxide
      # help systems            # help systems                              # Help Systems
        cheat                       # cli cheatsheets                           https://github.com/cheat/cheat
        tldr                        # better man pages                          https://tldr.sh/
      # cli tools               # cli tools                                 # CLI tools
        entr                        # run commands when files change            https://github.com/eradman/entr
        ethtool                     # ethtool                                   https://www.kernel.org/pub/software/network/ethtool/
        iotop                       # io monitoring                             http://guichaz.free.fr/iotop
        mlocate                     # locate from db built with `updatedb`      https://pagure.io/mlocate
        pciutils                    # lspci                                     https://mj.ucw.cz/sw/pciutils/
        sysstat                     # system stats                              http://sebastien.godard.pagesperso-orange.fr/
        topgrade                    # upgrade all the things (nix sorta broken) https://github.com/topgrade-rs/topgrade
        usbutils                    # lsusb                                     http://www.linux-usb.org/
      # system tools            # system tools                              # System Tools
        auto-cpufreq                # auto-cpufreq                              https://github.com/AdnanHodzic/auto-cpufreq
        lm_sensors                  # lm_sensors                                https://hwmon.wiki.kernel.org/lm_sensors
        libinput                    # TODO: I forget what I need this for.      https://www.freedesktop.org/wiki/Software/libinput/
      # nix                     # nix                                       # Nix - Move some of these into dev shells
        comma                       # `,` run things without installing them    https://github.com/nix-community/comma
        deadnix                     # scan for dead nix code                    https://github.com/astro/deadnix
        manix                       # nix man pages                             https://github.com/nix-community/manix
        nix-diff                    # diff nix code                             https://hackage.haskell.org/package/nix-diff
        nix-du                      # nix-store analysis                        https://github.com/symphorien/nix-du
        nix-health                  # check nix issues                          https://github.com/juspay/nix-health
        nix-init                    # nix packages from URLs                    https://github.com/nix-community/nix-init
        nix-output-monitor          # `nom`                                     https://github.com/maralorn/nix-output-monitor
        nix-tree                    # view dependency graph                     https://hackage.haskell.org/package/nix-tree
        nix-zsh-completions         # nix shell completions                     https://github.com/nix-community/nix-zsh-completions
        nixfmt                      # format nix code                           https://github.com/serokell/nixfmt
        nurl                        # nix fetcher calls from repository URLs    https://github.com/nix-community/nurl
        nvd                         # nix package version diff                  https://gitlab.com/khumba/nvd
        statix                      # antipattern linter                        https://github.com/nerdypepper/statix
      # Games                   # Games                                     # Games
        lutris                      # lutris game launcher                      https://lutris.net/
        # steam                     # in nix config                             https://github.com/NixOS/nixpkgs/blob/stable/pkgs/applications/games/steam/steam.nix
        protonup-qt                 # proton installer/updater                  https://davidotek.github.io/protonup-qt/
        protontricks                # protontricks                              https://github.com/Matoking/protontricks
        wineWowPackages.waylandFull # Wine for wayland                          https://www.winehq.org/
        steamtinkerlaunch           # steamtinkerlaunch                         https://github.com/sonic2kk/steamtinkerlaunch
        glfw                        # TODO: redundant, in system config         https://www.glfw.org/
        dxvk                        # TODO: redundant, in system config         https://github.com/doitsujin/dxvk
      # Wayland                 # Wayland                                   # Wayland
        wl-clipboard                # clipboard in wayland                      https://github.com/bugaevc/wl-clipboard
        wl-clipboard-x11            # clipboard in xwayland                     https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=wl-clipboard
        wayland-utils               # `wayland-info`                            https://gitlab.freedesktop.org/wayland/wayland-utils
        egl-wayland                 # who knows what this is for                https://github.com/NVIDIA/egl-wayland/
        

  ];
  # programs are packages you set extra pre-defined options in.
  #   google 'home-manager option search' to see how to find them.
  programs.micro = {          # editor for phone-ssh
    enable = true;
    settings = {
      autoclose = false;
      backup = false;
      autosu = true;
      cursorline  = true;
      colorscheme = "dukeubuntu-tc";
      difgutter = true;
      eofnewline = true;
      fastdirty = true;
      ignorecase = false;
      keyenu = true;
      mkparents = true;
      savehistory = false;
      tabsize = 2;
      tsbstospaces = true;
      colorcolumn = 81;
      indentchar = "·";
      multiopen = "hsplit";
      parsecursor = true;
      linter = true;
      comment = true;
      tabstospaces = true;
    };
  };
}
    
    



  # Things to look into:
      # MyNixOS
      # nixpkgs-wayland
      # nix-direnv
      # haumea                # nix configuration tool that allows you to just use the filesystem instead of imports 
      # flakelight            # less flake boilerplate
      # flake-utils
      # flake-utils-plus
      # flake-parts           # module system for flakes
      # devshell              # like virtualenv
      # devbox                # isolated development shells, maybe like the above
      # devenv                # same
      # nixos-shell           # easy VMs
      # nix-index             # quickly locate packages providing a certain file
      # nix-prefetch          # determine hash of fixed-output derivations such as package source