{ lib, ... }:
{
  imports = [
    ../..
  ];

  options = {
    home.persistence = lib.mkOption { type = lib.types.anything; };
  };

  config = {
    home = {
      username = "deck";
      homeDirectory = "/home/deck";
      stateVersion = "23.11";
    };

    apps = {
      enable = true;
      firefox.enable = false;
      steam.enable = true;
      obs.enable = true;
    };
    shell.ttx.autostart = true;

    nixpkgs.config.allowUnfree = true;
  };
}
