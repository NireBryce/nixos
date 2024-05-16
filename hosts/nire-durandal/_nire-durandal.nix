{ ... }: {
  imports = [
    # Users
    # ../_usr.elly.nix # modularize this later

    # nix generated
    ./hardware-configuration.nix
    ./stateVersion.nix

    # _def defaults
    # ../../system/__def.common.nix

    # fixes
    ../../system/_bugfixes/_suspend/_b550m-gpp0-etc.nix
  ];
  # hostname
  networking.hostName = "nire-durandal";
  # boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_6_6.override {argsOverride = {version = "6.6.27";};});
  # boot.kernelPackages = lib.mkForce pkgs.linuxKernel.kernels.linux_6_6;
  # boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_6_6.override {
  #   argsOverride = rec {
  #     src = pkgs.fetchurl {
  #       url = "mirror://kernel/linux/kernel/v6.x/linux-${version}.tar.xz";
  #       sha256 = "Y55QBg48jyPtAXyxDP6sxrqI/1WDgSu3aFm0zGoSgpE=";
  #     };
  #     version = "6.6.27";
  #     modDirVersion = "6.6.27";
  #   };
  # });

  # TODO: turn into its own module
  musnix = {
    enable = true;
    kernel.realtime = true;
    das_watchdog.enable =
      true; # starts the das watchdog which ensures realtime processes don't hang the machine
  };

  # TODO: stylix theme config also in it's own module
  # https://danth.github.io/stylix/configuration.html

  users.users.elly.extraGroups = [ "audio" ];

  _gui.enable = true;
  _amdgpu.enable = true;
  _steam.enable = true;

  _bluetooth.enable = true;
  _pipewire.enable = true;
  _pipewire-bt.enable = true;
  _wifi.enable = true;
  _firewall.enable = true;
  _zsa.enable = true;
  _logitech.enable = true;

  _impermanence.enable = true;
  _delete-root.enable = true;
  _system-partitions.enable = true;
}
