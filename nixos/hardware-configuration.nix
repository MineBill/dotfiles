# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/NixEFI";
      fsType = "vfat";
    };

  fileSystems."/" =
    { device = "/dev/disk/by-label/NixOS";
      fsType = "ext4";
    };

  swapDevices = [
    {
      device = "/.swapfile";
    }
  ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
