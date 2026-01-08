{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  # boot.initrd.luks.devices."luks-34c76cce-5afd-4d30-9a99-ce905897ae6c".device = "/dev/disk/by-uuid/34c76cce-5afd-4d30-9a99-ce905897ae6c";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/EEE0-B730";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware = {
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    flipperzero.enable = true;

    bluetooth = {
      enable = true; # enables support for Bluetooth
      powerOnBoot = true;
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/2d14519c-fe4c-4586-acb8-7268f0755f0e";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."root".device = "/dev/disk/by-uuid/34c76cce-5afd-4d30-9a99-ce905897ae6c";
}
