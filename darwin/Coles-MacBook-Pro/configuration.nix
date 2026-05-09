{
  self,
  config,
  inputs,
  helpers,
  ...
}:
{
  imports = [
    inputs.home-manager.darwinModules.default
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  config = {
    home-manager = {
      extraSpecialArgs = {
        inherit self;
        inherit inputs;
        inherit helpers;
      };
      users.colet = import (
        ../../home/configurations/aarch64-darwin + "/colet@Coles-MacBook-Pro.local.nix"
      );
    };

    nix.settings.experimental-features = "nix-command flakes pipe-operators";

    system.stateVersion = 6;
    system.primaryUser = "colet";
    nixpkgs.hostPlatform = "aarch64-darwin";

    security.pam.services.sudo_local.touchIdAuth = true;

    nix-homebrew = {
      enable = true;
      user = "colet";
      autoMigrate = true;
      mutableTaps = false;
      taps = {
        "homebrew/homebrew-core" = inputs.homebrew-core;
        "homebrew/homebrew-cask" = inputs.homebrew-cask;
      };
    };
    homebrew = {
      enable = true;
      taps = builtins.attrNames config.nix-homebrew.taps;
      casks = [
        "ghostty"
        "firefox"
      ];
    };

    users.users.colet = {
      name = "colet";
      home = "/Users/colet";
    };
  };
}
