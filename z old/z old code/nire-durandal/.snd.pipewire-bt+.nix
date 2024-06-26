# Bluetooth sound module
{ 
  pkgs,
  lib,
  config, 
  ...
}:
{
  options = {
    _pipewire-bt.enable = lib.mkEnableOption "Enables Pipewire bluetooth settings";
  };
  config = lib.mkIf config._pipewire-bt.enable {
    hardware.bluetooth.package = pkgs.bluez5-experimental;
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
  };
}
