{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    desktop.gpg.enable = lib.mkEnableOption "GPG" // {
      default = config.desktop.enable;
    };
  };

  config = lib.mkIf config.desktop.gpg.enable {
    programs.gpg.enable = true;
    services.gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry-qt;
    };

    home.persistence."/persist/home" = {
      allowOther = true;
      directories = [ ".gnupg" ];
    };
  };
}
