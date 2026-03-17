{ config, lib, ... }:
{
  options = {
    desktop.hyprpaper.enable = lib.mkEnableOption "Hyprpaper" // {
      default = config.desktop.enable;
    };
  };

  config = lib.mkIf config.desktop.hyprpaper.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [ "~/Pictures/i1.png" ];
        wallpaper = [
          {
            monitor = "";
            path = "~/Pictures/i1.png";
          }
        ];
      };
    };
  };
}
