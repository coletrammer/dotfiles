{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    apps.foot.enable = lib.mkEnableOption "foot";
  };

  config = lib.mkIf config.apps.foot.enable {
    home.packages = with pkgs; [
      foot
    ];
  };
}
