_: {
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;

      wallpaper = {
        monitor = "";
        path = toString ./nixos.png;
      };
    };
  };
}
