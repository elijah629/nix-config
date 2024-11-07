inputs:
{ pkgs, ... }:

{
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
  ];

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  home.packages = with pkgs; [
    vesktop
    xdg-utils
    libnotify
    hyprcursor
    grim
    slurp
    wl-clipboard
    prismlauncher
    nodejs-slim
    bun
    # spotify
    inputs.nixvim.packages.x86_64-linux.default
  ];

  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in
    {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle
      ];
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";
    };

  programs.btop.enable = true;

  fonts.fontconfig.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "24.05";
}
