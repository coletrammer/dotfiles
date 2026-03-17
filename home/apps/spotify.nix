{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    apps.spotify.enable = lib.mkEnableOption "Spotify" // {
      default = config.apps.enable;
    };
  };

  config = lib.mkIf config.apps.spotify.enable {
    home.packages = with pkgs; [ spotify ];

    home.persistence."/persist" = {
      directories = [
        {
          directory = ".config/spotify";
        }
      ];
    };
  };
}
