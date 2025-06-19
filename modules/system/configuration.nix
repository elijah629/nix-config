{ pkgs, inputs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ../catppuccin

    ./fonts.nix
    ./xdg.nix
    ./boot.nix
    ./networking.nix
    ./nix.nix
    ./nvidia.nix
    ./i18n.nix
    ./pipewire.nix
    ./users.nix
  ];

  home-manager.backupFileExtension = "backup";

  programs = {
    dconf.enable = true;
    bat.enable = true;
  };

  nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];

  environment.systemPackages = with pkgs; [
    git
    efibootmgr
    gcc
    (
      let
        base = pkgs.appimageTools.defaultFhsEnvArgs;
      in
      pkgs.buildFHSEnv (
        base
        // {
          name = "fhs";
          targetPkgs =
            pkgs:
            # pkgs.appimageTools provides basic packages required by most software.
            base.targetPkgs pkgs;
          profile = "export FHS=1";
          runScript = "nu";
          extraOutputsToInstall = [ "dev" ];
        }
      )
    )
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  system.stateVersion = "24.11";
}
