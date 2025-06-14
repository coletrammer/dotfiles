{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    shell.nh.enable = lib.mkEnableOption "nh" // {
      default = config.shell.enable;
    };
  };

  config = lib.mkIf config.shell.nh.enable {
    home.packages = with pkgs; [
      nh
      nvd
      nix-output-monitor
    ];

    home.sessionVariables = {
      NH_FLAKE = config.preferences.dotfilesPath;
    };
  };
}
