# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.

{ config, lib, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device  = "/dev/disk/by-uuid/a3bc8e9d-b58b-4161-b568-541af264c45c";
      fsType  = "btrfs";
      options = [ "subvol=root" "compress=zstd" "noatime" ];
    };

  boot.initrd.luks.devices."enc".device = "/dev/disk/by-uuid/23ae3533-e4ed-46d0-97a8-2fcd0c596526";

  fileSystems."/home" =
    { device  = "/dev/disk/by-uuid/a3bc8e9d-b58b-4161-b568-541af264c45c";
      fsType  = "btrfs";
      options = [ "subvol=home" "compress=zstd"];
    };

  fileSystems."/nix" =
    { device  = "/dev/disk/by-uuid/a3bc8e9d-b58b-4161-b568-541af264c45c";
      fsType  = "btrfs";
      options = [ "subvol=nix" "compress=zstd" "noatime" ];
    };

  fileSystems."/persist" =
    { device  = "/dev/disk/by-uuid/a3bc8e9d-b58b-4161-b568-541af264c45c";
      fsType  = "btrfs";
      options = [ "subvol=persist" "compress=zstd" "noatime" ];
      neededForBoot = true;
    };

  fileSystems."/var/log" =
    { device  = "/dev/disk/by-uuid/a3bc8e9d-b58b-4161-b568-541af264c45c";
      fsType  = "btrfs";
      options = [ "subvol=log" "compress=zstd" "noatime" ];
      neededForBoot = true;
    };

  fileSystems."/boot" =
    { device  = "/dev/disk/by-uuid/B35C-D0E8";
      fsType  = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/2aa9fe35-f090-45e4-9432-3cd17dc0ff9d"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp4s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}