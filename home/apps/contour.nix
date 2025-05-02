{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    apps.contour.enable = lib.mkEnableOption "Contour";
  };

  config = lib.mkIf config.apps.contour.enable {
    home.packages = with pkgs; [
      contour
    ];
  };
}
