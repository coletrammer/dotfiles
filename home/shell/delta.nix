{
  config,
  lib,
  ...
}:
{
  options = {
    shell.delta = {
      enable = lib.mkEnableOption "delta" // {
        default = config.shell.enable;
      };

      hyperlinks = lib.mkEnableOption "delta hyperlinks" // {
        default = true;
      };
    };
  };

  config = lib.mkIf config.shell.delta.enable {
    programs.delta = {
      enable = true;
      options = {
        navigate = true;
        line-numbers = true;
        hyperlinks = config.shell.delta.hyperlinks;
      };
    };
    programs.git.settings = {
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";
    };
  };
}
