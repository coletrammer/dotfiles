{
  config,
  lib,
  ...
}:
{
  options = {
    apps.foot.enable = lib.mkEnableOption "foot";
  };

  config = lib.mkIf config.apps.foot.enable {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          font = "${config.preferences.font.name}:size=${builtins.toString config.preferences.font.size_int}";
          dpi-aware = "yes";
        };

        mouse = {
          hide-when-typing = "yes";
        };

        text-bindings = {
          "\\x17" = "Control+BackSpace";
          "\\x1e" = "Control+Return";
          "\\x1d" = "Shift+Return";
          "\\x1c" = "Control+backslash";
        };
      };
    };
  };
}
