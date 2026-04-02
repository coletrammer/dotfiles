{ config, lib, ... }:
{
  options = {
    desktop.wireplumber.enable = lib.mkEnableOption "Wire Plumber" // {
      default = config.desktop.enable;
    };
  };

  config = lib.mkIf config.desktop.wireplumber.enable {
    home.persistence."/persist" = {
      directories = [ ".local/state/wireplumber" ];
    };
  };
}
