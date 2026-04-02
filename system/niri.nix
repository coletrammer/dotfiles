{
  self,
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    niri.enable = lib.mkEnableOption "niri";
  };

  config = lib.mkIf config.niri.enable {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri;
    };
  };
}
