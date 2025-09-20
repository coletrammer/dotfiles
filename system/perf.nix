{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    perf.enable = lib.mkEnableOption "perf" // {
      default = true;
    };
  };

  config = lib.mkIf config.perf.enable {
    environment.systemPackages = [ pkgs.perf ];
  };
}
