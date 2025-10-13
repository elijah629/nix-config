_: {
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  services.blueman.enable = true;
}
