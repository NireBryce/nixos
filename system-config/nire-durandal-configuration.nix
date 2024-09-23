{ 
  nixos-hardware,
  self,
  nixpkgs,
  pkgs,
  lib,
  ... 
}: 

let flakePath = self;
in let 
    _hardware-configuration     = "${flakePath}/system-config/hardware-configurations/durandal-hardware-configuration.nix";
    _networking-tailscale       = "${flakePath}/system-config/services/__tailscale.nix";
    _remote-sunshine            = "${flakePath}/___modules/sunshine.nix";
    _user-elly                  = "${flakePath}/system-config/users/_elly.nix";
    _wm-kde                     = "${flakePath}/system-config/window-manager/_kde.nix";
    linux-crisis-utils          = "${flakePath}/___modules/linux-crisis-utilities.nix";
    _sops-secrets               = "${flakePath}/system-config/_sys.sec.sops.nix";
  
  ## hardware bugfixes
    fixes-b550-suspend          = "${flakePath}/system-config/system-fixes/suspend/_b550m-gpp0-etc.nix";
  #! ! WARNING TO THE UNWARY ! this will erase the / mount point
    replace-root-at-boot-etc    = "${flakePath}/system-config/impermanence/_WARN.impermanence.nix";

in {
  # TODO: bring most of these back into the durandal configuration to better follow community conventions
  # TODO: start with linux-defaults next time
    imports = [
        nixos-hardware.nixosModules.common-cpu-amd
        nixos-hardware.nixosModules.common-gpu-amd
        _sops-secrets
        _hardware-configuration
        _networking-tailscale
        _remote-sunshine
        _user-elly
        _wm-kde

        linux-crisis-utils                                  # these are utilities that you want installed when something happens
        fixes-b550-suspend
      # impermanence
      # ____________________________________________________ 
      # |- /!!\ WARN: this will delete /root on boot /!!\ -|
      # ----------------------------------------------------
        replace-root-at-boot-etc
    ];
    
  ## nix settings
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

  # TODO: probably deprecated by the nix-index flake import
    nix.nixPath = [                                           # make nix-index not use channels https://github.com/nix-community/nix-index/issues/167
        "nixpkgs=${nixpkgs}"
        "/nix/var/nix/profiles/per-user/root/channels"
    ];
  
  #? This determines what to add to /run/current-system/sw, generally defined elsewhere
    environment.pathsToLink = [
      #? Make sure system completions work even with home-manager managed shells 
        "/share/zsh"
        "/share/bash-completion"
        "/share/fish"
    ];

  ## Boot
    #? Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = lib.mkDefault true;
    boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;
  
  ## console / VTs
    console = {
        keyMap = "us";
        font = "Lat2-Terminus16";
    };
  ## fonts
    fonts.packages = with pkgs; [
        (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Iosevka" "JetBrainsMono" ];})  # be not afraid
    ];
  
  ## hostname
    networking.hostName = "nire-durandal";

  ## Locale
    i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
    time.timeZone = lib.mkDefault "America/New_York"; 

  ## Input
    hardware.keyboard.zsa.enable = true;      # zsa keyboard package
    services.ratbagd.enable      = true;      # for piper logitech mouse ctl

  ## SSH
    services.openssh = {
        enable = true;
        settings.PasswordAuthentication = false;
        settings.KbdInteractiveAuthentication = false;
        allowSFTP = false; # Don't set this if you need sftp

        extraConfig = ''
            AllowTcpForwarding yes
            X11Forwarding no
            AllowAgentForwarding no
            AllowStreamLocalForwarding no
            AuthenticationMethods publickey
        '';
    };

  ## Networking
    #* WiFi
    networking.networkmanager.enable = true;  # Needs to be 'true' for KDE networking

    #* Bluetooth
    hardware.bluetooth.powerOnBoot = true;
    hardware.bluetooth.enable =  true;
    hardware.bluetooth.settings = {
        General = {
            FastConnectable = true;
            DiscoverableTimeout =  60;  # seconds
            PairableTimeout = 60;       # seconds
        };
    };
  ## Sound
    security.rtkit.enable = true;       # rtkit is optional but recommended
    hardware.bluetooth.package = pkgs.bluez5-experimental;
    services.pipewire = {
        enable = true;
        wireplumber.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      #? If you want to use JACK applications, uncomment this
        # jack.enable = true;
    };
    services.pipewire.wireplumber.configPackages = [
        (pkgs.writeTextDir "wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
            bluez_monitor.properties = { 
                ["bluez6.enable-sbc-xq"] = true,
                ["bluez6.enable-msbc"] = true,
                ["bluez6.enable-hw-volume"] = true,
                ["bluez6.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
            }''
        )
    ];
  #? from https://github.com/jpas/etc-nixos/blob/365e5301e559af29eafec7f7c391f1c84b6c6477/profiles/hardware/sound.nix#L18
    systemd.user.services.pipewire-pulse = {
        bindsTo = [ "pipewire.service" ];
        after = [ "pipewire.service" ];
    };
    #? pipewire also set in graphics.extraPackages below, presumably for hdmi/displayport audio

  ## Firewall
    networking.firewall = { 
        enable = true;
      ## TCP
        allowedTCPPorts = [
            22                            # ssh
        ];
        allowedTCPPortRanges = [  
            { from = 1714; to = 1764; }    # kde-connect TCP
        ];
      ## UDP
        allowedUDPPorts = [                            
        ];
        allowedUDPPortRanges = [
            { from = 1714; to = 1764; }   # kde-connect UDP   
        ];
    };

  ## Games
    programs.steam = {
        enable = true;
        remotePlay.openFirewall      = true;  # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true;  # Open ports in the firewall for Source Dedicated Server
        gamescopeSession.enable      = true;  # third party gamescope compositor
    }; 

  # TODO: do nix automatic garbage collection https://www.youtube.com/watch?v=uS8Bx8nQots
  
  ## Shells
        environment.shells = with pkgs; [
        bash
        zsh
    ];
  #? zsh is handled through home-manager
    programs.zsh.enable = true;
    programs.zsh.enableCompletion = lib.mkForce false;  # unless disabled, home-manager causes an extra compaudit
   

  ## System packages
    environment.systemPackages = with pkgs; [ # TODO: describe these
      #* System utilities
        bash                        # bash.  ok i guess.
          #? Bash Plugins
            inshellisense       # menu-complete and auto-suggest
            starship            # theming
            blesh               # if bash were zsh
        coreutils                   # coreutils
        curl                        # curl
        gcc                         # gcc
        git                         # git
        micro                       # micro
        stdenv                      # stdenv
        wget                        # wget
        zoxide                      # zoxide
        ripgrep                     # ripgrep
        nix-output-monitor          # `nom` nix-output-monitor                  https://github.com/maralorn/nix-output-monitor
        nh                          # nix helper                                https://github.com/viperML/nh
        linuxHeaders                # linux headers
        sops                        # secret management
      #* GPU-related packages
        amf-headers
        mesa
        glfw
        dxvk
        vulkan-tools                # vulkan-tools                              https://github.com/KhronosGroup/Vulkan-Tools
        glxinfo                     # glxinfo                                   https://www.khronos.org/opengl/
        clinfo                      # clinfo                                    https://github.com/Oblomov/clinfo
        amdgpu_top                  # amdgpu_top gpu monitor                    https://github.com/Umio-Yasuno/amdgpu_top
    ];
  
  ## GPU
    hardware.amdgpu.amdvlk.enable = false;    # disable amdvlk to use radv
    hardware.graphics.extraPackages = with pkgs; [
        pipewire
        libva-utils
    ];

  ## System services and utilities  
    services.fwupd.enable = true;         # fwupd
    programs.nix-ld.enable = true;        # Needed for VSCode remote connection
    programs.kdeconnect.enable = true;    # kde connect
    programs.xwayland.enable = true;      # xwayland
    programs.nh = {                                   # `nh` nix-helper           https://github.com/viperML/nh
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep-since 7d --keep 5";
        flake = "/home/elly/nixos";
    };

  
  # TODO: turn into its own module.  helps microphone issues, reduces latency
    musnix = {
      enable          = true;
      kernel.realtime = false;  # you shouldn't enable this unless debugging something
      ## ensure realtime processes don't hang the machine
        # das_watchdog.enable = true;
    };

  # TODO: stylix theme config
  # https://danth.github.io/stylix/configuration.htmloverride {argsOverride = {version = "6.6.27";};
  

  ## nixos stateVersion for this system
  #   don't change this
  #   For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "23.11"; # Did you read the comment?

}

## I think this is deprecated by it being in the flake
  # programs.command-not-found.enable = lib.mkForce false; # conflicts with nix-index-database

## ways of overriding kernel
  # boot.kernelPackages = pkgs.linuxPackages_6_9;
  # boot.kernelPackages = pkgs.linux_6_6.override { argsOverride = { version = "6.6.23"; }; };
  # boot.kernelPackages = lib.mkForce pkgs.linuxPackagesFor (pkgs.linux_6_6.override {argsOverride = {version = "6.6.27";};});
  # boot.kernelPackages = lib.mkForce pkgs.linuxKernel.kernels.linux_6_6;
  # boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_6_6.override {
  #   argsOverride = rec {
  #     src = pkgs.fetchurl {
  #       url = "mirror://kernel/linux/kernel/v6.x/linux-${version}.tar.xz";
  #       sha256 = "IA/RGcue8GvO3NtSvgC6RDFj6rFUKVxYMf7ZoSIRqLk=";
  #     };
  #     version = "6.6.23";
  #     modDirVersion = "6.6.23";
  #   };
  # });

## musnix:
  # musnix.kernel.packages =  pkgs.linuxPackagesFor (pkgs.linux_6_6.override {
  #   argsOverride = rec {
  #     src = pkgs.fetchurl {
  #       url = "mirror://kernel/linux/kernel/v6.x/linux-${version}.tar.xz";
  #       sha256 = "IA/RGcue8GvO3NtSvgC6RDFj6rFUKVxYMf7ZoSIRqLk=";
  #     };
  #     version = "6.6.23";
  #     modDirVersion = "6.6.23";
  #   };
  # });