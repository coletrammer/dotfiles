{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    shell.abduco.enable = lib.mkEnableOption "abduco" // {
      default = config.shell.enable;
    };
  };

  config = lib.mkIf config.shell.abduco.enable { home.packages = with pkgs; [ abduco ]; };
}
