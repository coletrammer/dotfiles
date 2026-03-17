{ config, lib, ... }:
{
  options = {
    desktop.impermanence.enable = lib.mkEnableOption "impermanence" // {
      default = config.desktop.enable;
    };
  };

  config = lib.mkIf config.desktop.impermanence.enable {
    home.persistence."/persist" = {
      directories = [
        ".cache"
        {
          directory = ".ccache";
        }
        {
          directory = "Downloads";
        }
        {
          directory = "Music";
        }
        {
          directory = "Pictures";
        }
        {
          directory = "Documents";
        }
        {
          directory = "Videos";
        }
        {
          directory = "Workspace";
        }
      ];
    };
  };
}
