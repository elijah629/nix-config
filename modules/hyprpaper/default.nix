{...}: let
  wp = toString ./nixos.png;
  wc = "," + wp;
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;

      preload = [wp];
      wallpaper = [wc];
    };
  };
}
