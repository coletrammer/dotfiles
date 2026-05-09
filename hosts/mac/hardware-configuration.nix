{
  lib,
  inputs,
  ...
}:
{
  boot.initrd.availableKernelModules = [ "usb_storage" ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
