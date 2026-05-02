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
    ../modules/hyprsunset
    ../modules/mako
    ../modules/hyprland
    ../modules/kitty
    ../modules/librewolf
    ../modules/gtk
    ../modules/fuzzel
    ../modules/xdg
    ../modules/cursor
    ../modules/catppuccin
    ../modules/gh
    ../modules/spotify
    # ../modules/obs
    { _module.args = { inherit inputs; }; }
  ];

  # Only for GTK Theme (not active)
  # dconf = {
  #  enable = true;
  #  settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  # };

  programs.codex = {
    package = inputs.codex-nix.packages.${pkgs.stdenv.hostPlatform.system}.default;
    enable = true;
  };

  programs.claude-code = {
    enable = true;
  };

  home.packages = with pkgs; [
    unzip

    btop-rocm

    vlc # Play video 'n shit
    yt-dlp # Download video 'n shit

    xdg-utils # apparently if you dont have these your system gets borked
    libnotify

    ripgrep

    grim # Printscr bindings
    slurp

    wl-clipboard # Copy/Paste in neovim

    # two week minecraft phase
    (prismlauncher.override {
      # Add binary required by some mod
      # additionalPrograms = [ ffmpeg ];

      # Change Java runtimes available to Prism Launcher
      jdks = [
        jdk
      ];
    })

    nodejs # JS Dev
    bun

    rust-analyzer
    clippy
    cargo
    rustc

    markdownlint-cli2 # Markdown LSP
    marksman

    r2modman

    legcord # Discord client

    qFlipper # my glorious flipper zero
    screen # Accessing the flipper zero CLI

    inputs.toucanvim.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.finamp-flake.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.musee.packages.${pkgs.stdenv.hostPlatform.system}.default

    # jellyfin-desktop

    # gotta remote into the homelab
    nomachine-client
  ];

  fonts.fontconfig.enable = true;

  home.stateVersion = "24.11";
}
