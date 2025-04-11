{...}: {
  networking = {
    hostName = "nixos";
    enableIPv6 = true;
    networkmanager = {
      enable = true;
    };
  };
}
