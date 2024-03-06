{ ... }:
{
# Enable the X11 windowing system.
  # TODO: x11/wayland switch
  services.xserver.enable = true;

# Enable the GNOME Desktop Environment.
  #TODO: variablize so it's a choice of DM and WM
  services.xserver.displayManager.sddm.wayland.enable = true;
  services.xserver.desktopManager.plasma6.enable = true;


  # services.xserver.displayManager.defaultSession = "plasmawayland"; # Plasma 5
  services.xserver.displayManager.defaultSession = "plasma"; # plasma 6
  
# make GTK apps obey theme settings
 programs.dconf.enable = true;


}