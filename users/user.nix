{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../modules/git
    ../modules/nushell
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
    { _module.args = { inherit inputs; }; }
  ];

  # Only for GTK Theme (not active)
  # dconf = {
  #  enable = true;
  #  settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  # };

  # ViBeCoDinG
  # services.ollama = {
  #  enable = true;
  # };

  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio.override {
      cudaSupport = true;
    };
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };

  home.packages = with pkgs; [
    vlc # Play video 'n shit
    yt-dlp # Download video 'n shit

    xdg-utils # apparently if you dont have these your system gets borked
    libnotify

    grim # Printscr bindings
    slurp

    wl-clipboard # Copy/Paste in neovim

    prismlauncher # two week minecraft phase

    nodejs # JS Dev
    bun

    cargo
    rustc

    markdownlint-cli2 # Markdown LSP
    marksman

    legcord # Discord client

    qFlipper # my glorious flipper zero
    screen # Accessing the flipper zero CLI

    inputs.Akari.packages.${system}.default
  ];

  fonts.fontconfig.enable = true;

  home.stateVersion = "24.11";
}
