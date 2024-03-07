{
  configs,
  pkgs,
  ...
}:
{ 
  imports = [
    # need to make this not bound to a particular partition scheme
    ./_secrets
    ./_services
    ./_bluetooth.nix
    ./_impermanence.nix
    ./_users.nix
    ./_firewall.nix
    ./_sound.nix
    ./_ssh.nix
    ./_users.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.efi.efiSysMountPoint = "/boot";  
  # wifi manager options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Needs to be 'true' for KDE networking
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  
  environment.etc.machine-id.source = /persist/etc/machine-id;
  
  # Set time zone.
  time.timeZone = "America/New_York";
  
  # i18n
  i18n.defaultLocale = "en_US.UTF-8";

  programs.kdeconnect.enable = true;


services.fwupd.enable = true;
  
# system packages
  # List packages installed in system profile. To search, run:
  # $ nix search <package name>
  environment.systemPackages = with pkgs; [
    coreutils
    micro # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    git
    bash
    zsh
    stdenv
    gcc
  ];

# Needed for VSCode remote connection
  programs.nix-ld.enable = true;

# shells
  environment.shells = [ 
                          pkgs.zsh
                          pkgs.bash
                       ];
  

  


  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };




}
