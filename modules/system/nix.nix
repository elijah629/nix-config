{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixVersions.latest;
    settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
      auto-optimise-store = true;
      allowed-users = ["@wheel"];
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
