{pkgs, ...}: {
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

  programs.dconf.enable = true;
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    # zsh
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
            targetPkgs = pkgs:
            # pkgs.appimageTools provides basic packages required by most software.
              base.targetPkgs pkgs;
            profile = "export FHS=1";
            runScript = "zsh";
            extraOutputsToInstall = ["dev"];
          }
        )
    )
  ];

  system.stateVersion = "24.11";
}
