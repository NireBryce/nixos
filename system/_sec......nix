{ 
  sops-nix, 
  config,
  ...
}:

let
  isEd25519 = k: k.type == "ed25519";
  getKeyPath = k: k.path;
  keys = builtins.filter isEd25519 config.services.openssh.hostKeys;
in

# secrets metapackage
{
  imports = [
    sops-nix.nixosModules.sops
  ];

  sops = {
    age.sshKeyPaths = map getKeyPath keys;
    defaultSopsFile = ./.sec.secrets.yaml;

  };
}
