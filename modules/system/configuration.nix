{ config, pkgs, ... }:

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

  nixpkgs.config.allowUnfree = true;

  security.rtkit.enable = true;

  home-manager.backupFileExtension = "backup";

  programs.steam.enable = true;
  programs.dconf.enable = true;
  programs.zsh.enable = true;

  security = {
    lockKernelModules = true;
    protectKernelImage = true;
    allowSimultaneousMultithreading = false;
    forcePageTableIsolation = true;
    unprivilegedUsernsClone = config.virtualisation.containers.enable;
    virtualisation.flushL1DataCache = "always";

    apparmor.enable = true;
    apparmor.killUnconfinedConfinables = true;
  };

  environment.systemPackages = with pkgs; [
    zsh
    git
    efibootmgr
    gcc
    (
      let
        base = pkgs.appimageTools.defaultFhsEnvArgs;
      in
      pkgs.buildFHSUserEnv (
        base
        // {
          name = "fhs";
          targetPkgs =
            pkgs:
            (
              # pkgs.buildFHSUserEnv provides only a minimal FHS environment,
              # lacking many basic packages needed by most software.
              # Therefore, we need to add them manually.
              #
              # pkgs.appimageTools provides basic packages required by most software.
              (base.targetPkgs pkgs)
              ++ (with pkgs; [
                pkg-config
                ncurses
                # Feel free to add more packages here if needed.
              ])
            );
          profile = "export FHS=1";
          runScript = "zsh";
          extraOutputsToInstall = [ "dev" ];
        }
      )
    )
  ];

  system.stateVersion = "24.05";
}
