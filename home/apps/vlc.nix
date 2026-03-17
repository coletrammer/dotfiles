{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    apps.vlc.enable = lib.mkEnableOption "VLC" // {
      default = config.apps.enable;
    };
  };

  config = lib.mkIf config.apps.vlc.enable {
    home.packages = with pkgs; [ vlc ];

    home.persistence."/persist" = {
      directories = [ ".config/vlc" ];
    };
  };
}
