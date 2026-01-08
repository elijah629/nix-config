{pkgs, ...}: {
  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      #extraPortals = with pkgs; [
      # xdg-desktop-portal-hyprland # Handled by NixOS module
      # xdg-desktop-portal-gtk
      #];
      config = {
        common = {
          default = ["gtk"];
        };
      };
    };
  };
}
