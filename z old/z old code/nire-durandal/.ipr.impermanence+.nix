{ 
  impermanence,
  ...
}: 

{
  # options = {
  #   _impermanence.enable = lib.mkEnableOption "Enables impermanence";
  # };

  imports = [
    impermanence.nixosModule
  ];

  # TODO: Make impermanence togglable again
   
  # config.ipr._impermanence = lib.mkIf config._impermanence.enable {
    environment.etc.machine-id.source = /persist/etc/machine-id;
    environment.persistence."/persist" = {
      directories = [
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
          # "/etc/nixos" # no longer needed with the flake.
          # { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
        
      ];
      files = [
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key.pub"
        "/etc/ssh/ssh_host_rsa_key"
        "/etc/ssh/ssh_host_rsa_key.pub"
          # { file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
          # "/etc/machine-id"
      ];
    };
    security.sudo.extraConfig = ''
      # impermanence-style wiping root results in sudo lectures after each reboot
      Defaults lecture = never
    '';
  # };
}
