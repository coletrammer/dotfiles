{
  helpers,
  inputs,
  pkgs,
  self,
  ...
}:
{
  imports = [
    ./disk.nix
    ./hardware-configuration.nix
    ./apple-silicon-support
    ../../system
  ];

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
  steam.enable = true;
  docker.enable = true;
  docs.enable = true;

  home-manager = {
    extraSpecialArgs = {
      inherit helpers;
      inherit inputs;
      inherit self;
    };
    users = {
      "colet" = import (../../home/configurations/x86_64-linux + "/colet@mac.nix");
    };
  };

  networking.hostName = "mac";

  system.stateVersion = "23.11";

  nixpkgs.config.allowUnfree = true;
}
