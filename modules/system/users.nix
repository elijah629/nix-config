{ pkgs, ... }:
{

  users.users = {
    user = {
      isNormalUser = true;
      extraGroups = [
        "dialout"
        "networkmanager"
        "wheel"
      ];
      shell = pkgs.nushell;
    };
  };
}
