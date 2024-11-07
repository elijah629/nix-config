{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      update = "sudo nix flake update --flake /etc/nixos; sudo nixos-rebuild switch --show-trace --print-build-logs --verbose --flake /etc/nixos#nixos";
      windows = "sudo efibootmgr -n 0000; reboot";
      config = "cd /etc/nixos; sudo nvim .";
    };
  };

  programs.starship = {
    enable = true;

    settings = pkgs.lib.importTOML ./starship.toml;
  };
}