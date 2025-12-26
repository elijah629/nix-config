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

  boot.initrd.kernelModules = [ "amdgpu" ];
}
