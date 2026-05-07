{
  helpers,
  inputs,
  pkgs,
  self,
  ...
}:
{
  imports = [
    inputs.apple-silicon.nixosModules.default
    ./disk.nix
    ./hardware-configuration.nix
    # ../../system
  ];

  hardware.asahi.peripheralFirmwareDirectory = ./firmware;

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = false;

  users.users."colet" = {
    isNormalUser = true;
    # hashedPasswordFile = "/persist/secrets/passwords/colet";
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "docker"
    ];
  };

  programs.zsh.enable = true;
  # steam.enable = true;
  # docker.enable = true;
  # docs.enable = true;

  # home-manager = {
  #   extraSpecialArgs = {
  #     inherit helpers;
  #     inherit inputs;
  #     inherit self;
  #   };
  #   users = {
  #     "colet" = import (../../home/configurations/x86_64-linux + "/colet@mac.nix");
  #   };
  # };

  networking.hostName = "mac";
  networking.networkmanager.wifi.backend = "iwd";

  services.xserver.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  hardware.apple.touchBar = {
    enable = true;
    package = pkgs.tiny-dfr;
  };

  system.stateVersion = "25.11";

  nixpkgs.config.allowUnfree = true;
}
