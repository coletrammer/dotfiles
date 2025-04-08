{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    desktop.pavucontrol.enable = lib.mkEnableOption "pavucontrol" // {
      default = config.desktop.enable;
    };
  };

  config = lib.mkIf config.desktop.pavucontrol.enable {
    home.packages = with pkgs; [
      pavucontrol
    ];
  };
}
