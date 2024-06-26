{
  description = "https://drakerossman.com/blog/rust-development-on-nixos-bootstrapping-rust-nightly-via-flake";

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url  = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
      in
      with pkgs;
      {
        devShells.default = mkShell {
          buildInputs = [
            openssl
            pkg-config
            eza
            fd
            (
              rust-bin.selectLatestNightlyWith (toolchain: toolchain.default.override {
                extensions = [ "rust-src" ];
                # targets = [ "arm-unknown-linux-gnueabihf" ];
              })
            )
          ];

          shellHook = ''
            alias ls=eza
            alias find=fd
          '';
        };
      }
    );
}
