{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    apps.discord.enable = lib.mkEnableOption "Discord" // {
      default = config.apps.enable;
    };
  };

  config = lib.mkIf config.apps.discord.enable {
    home.packages = with pkgs; [
      discord
      vesktop
    ];

    home.persistence."/persist" = {
      directories = [
        {
          directory = ".config/discord";
        }
        {
          directory = ".config/vesktop";
        }
      ];
    };
  };
}
