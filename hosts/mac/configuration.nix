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
    ../../system
  ];

  hardware.asahi.peripheralFirmwareDirectory = ./firmware;

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = false;

  users.users."colet" = {
    isNormalUser = true;
    hashedPasswordFile = "/persist/secrets/passwords/colet";
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "docker"
    ];
  };

  programs.zsh.enable = true;
  # steam.enable = true;
  docker.enable = true;
  docs.enable = true;

  home-manager = {
    extraSpecialArgs = {
      inherit helpers;
      inherit inputs;
      inherit self;
    };
    users = {
      "colet" = import (../../home/configurations/aarch64-linux + "/colet@mac.nix");
    };
  };

  networking.hostName = "mac";

  hardware.apple.touchBar = {
    enable = true;
    package = pkgs.tiny-dfr;
  };

  system.stateVersion = "25.11";

  nix.settings = {
    extra-substituters = [
      "https://nixos-apple-silicon.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
    ];
  };

  nixpkgs.config.allowUnfree = true;
}
