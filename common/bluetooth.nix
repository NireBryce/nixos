# https://github.com/jpas/etc-nixos/blob/365e5301e559af29eafec7f7c391f1c84b6c6477/profiles/hardware/bluetooth.nix

{ lib, config, ... }:

with lib;

let
  cfg = config.hardware.bluetooth;
in
{
  hardware.bluetooth.enable = mkDefault true;
  hardware.bluetooth.settings = {
    General = {
      FastConnectable = mkDefault true;
      DiscoverableTimeout = mkDefault 60; # seconds
      PairableTimeout = mkDefault 60; # seconds
    };
  };
}