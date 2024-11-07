{ pkgs, ... }:
{
  nix = {
    package = pkgs.nixVersions.latest;
    settings = {
      auto-optimise-store = true;
    };
    allowedUsers = [ "@wheel" ];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
