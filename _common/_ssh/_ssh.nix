# SSH
{ ... }:
{
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    allowSFTP = false; # Don't set this if you need sftp
    # challengeResponseAuthentication = false; # folded into settings.KbdInteractiveAuthentication
    
    extraConfig = ''
      AllowTcpForwarding yes
      X11Forwarding no
      AllowAgentForwarding no
      AllowStreamLocalForwarding no
      AuthenticationMethods publickey
    '';
  };
}
