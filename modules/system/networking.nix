_: {
  networking = {
    hostName = "nixos";

    useDHCP = false;

    wireless = {
      enable = true;
      secretsFile = "/etc/nixos/.wifi";

      networks."Piranha".pskRaw = "ext:psk";
    };
  };

  systemd.network = {
    enable = true;

    networks = {
      "10-enp14s0" = {
        matchConfig = {
          Name = "enp14s0";
        };

        networkConfig = {
          DHCP = "ipv4";
          IPv6AcceptRA = true;
        };

        linkConfig = {
          RequiredForOnline = "no";
        };
      };

      "20-wlp15s0" = {
        matchConfig = {
          Name = "wlp15s0";
        };

        networkConfig = {
          DHCP = "ipv4";
          IPv6AcceptRA = true;
        };
      };
    };
  };

  services.blueman.enable = true;
}
