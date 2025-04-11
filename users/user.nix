{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../modules/git
    ../modules/zsh
    ../modules/hyprpaper
    ../modules/mako
    ../modules/hyprland
    ../modules/kitty
    ../modules/librewolf
    ../modules/gtk
    ../modules/rofi
    ../modules/xdg
    ../modules/cursor
    ../modules/catppuccin
    ../modules/gh
    ../modules/spotify
    {_module.args = {inherit inputs;};}
  ];

  #dconf = {
  #  enable = true;
  #  settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  #};

  #services.ollama = {
  #  enable = true;
  #};

  home.packages = with pkgs; [
    yt-dlp
    vlc
    xdg-utils
    libnotify
    grim
    slurp
    wl-clipboard
    prismlauncher
    unzip
    screen
    # Moved to devshells
    #    nodejs
    cargo
    rustc
    #bun
    #fzf
    marksman
    markdownlint-cli2
    legcord
    qFlipper
    inputs.nixvim.packages.x86_64-linux.default
  ];

  fonts.fontconfig.enable = true;

  home.stateVersion = "24.11";
}
