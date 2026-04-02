{ inputs, ... }:
{
  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    {
      packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
        settings = {
          spawn-at-startup = [
            (lib.getExe self'.packages.noctalia)
          ];

          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

          prefer-no-csd = _: { };
          hotkey-overlay.skip-at-startup = _: { };

          input = {
            focus-follows-mouse = _: { };
            keyboard = {
              xkb = {
                layout = "us,ua";
                options = "caps:escape";
              };
              numlock = _: { };
            };
          };

          outputs = {
            "DP-1" = {
              position = _: {
                props = {
                  x = 3840;
                  y = 0;
                };
              };
            };
            "DP-2" = {
              position = _: {
                props = {
                  x = 0;
                  y = 0;
                };
              };
            };
          };

          window-rules = [
            {
              geometry-corner-radius = 20;
              clip-to-geometry = true;
            }
          ];

          layer-rules = [
            {
              matches = [
                {
                  namespace = "^noctalia-overview*";
                }
              ];
              place-within-backdrop = true;
            }
          ];

          layout.gaps = 5;

          debug = {
            honor-xdg-activation-with-invalid-serial = _: { };
          };

          binds = {
            "Mod+Return".spawn-sh = lib.getExe pkgs.ghostty;
            "Mod+Q".close-window = _: { };
            "Mod+S".spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call launcher toggle";
          };
        };
      };
    };
}
