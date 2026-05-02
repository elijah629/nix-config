{ lib, ... }:
let
  runEthernetServer = false;
in
{
  networking = {
    hostName = "nixos";

    useDHCP = false;

    wireless = {
      enable = true;
      secretsFile = "/etc/nixos/.wifi";

      networks."Piranha".pskRaw = "ext:psk";
    };

    firewall = {
      enable = true;
      interfaces = lib.optionalAttrs runEthernetServer {
        enp14s0 = {
          allowedUDPPorts = [
            67
            69
            4011
          ];
          allowedTCPPorts = [ 64172 ];
        };
      };
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
          # DHCP = "ipv4";
          DHCP = "no";
          Address = "10.0.0.1/24";
          # IPv6AcceptRA = true;
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

  services.dnsmasq = {
    enable = runEthernetServer;

    # use the attribute-map "settings" (preferred)
    settings = {
      # listen only on the interface we want
      interface = "enp14s0";
      bind-interfaces = true;

      # hand out a small range for PXE clients
      dhcp-range = "10.0.0.100,10.0.0.150,12h";

      dhcp-option = [ "3,10.0.0.1" ];

      # don't touch other resolv config on the host in this lab setup
      no-resolv = true;
      no-hosts = true;
    };
  };
}
