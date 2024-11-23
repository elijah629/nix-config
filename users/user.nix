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
    (import ../modules/spotify inputs)
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
    inputs.nixvim.packages.x86_64-linux.default
  ];

  programs.bat.enable = true;

  programs.btop.enable = true;

  fonts.fontconfig.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "24.05";
}
