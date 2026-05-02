{ pkgs, ... }:
{
  services.xserver.videoDrivers = [
    "amdgpu"
  ];

  hardware = {
    graphics = {
      enable = true;
    };
  };

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];
}
