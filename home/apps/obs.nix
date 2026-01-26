{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  options = {
    apps.obs.enable = lib.mkEnableOption "OBS";
  };

  config =
    let
      latest-obs-livesplit-one = pkgs.obs-studio-plugins.obs-livesplit-one.overrideAttrs (oa: rec {
        name = "${oa.pname}-${version}";
        version = "git";
        src = inputs.obs-livesplit-one;
        cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
          inherit src;
          hash = "sha256-Z9iMXy3AhpEwEIFMcrJivpKwStJzhVwnFvYWW1OJbwI=";
        };
      });
    in
    lib.mkIf config.apps.obs.enable {
      programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          latest-obs-livesplit-one
          obs-pipewire-audio-capture
          input-overlay
        ];
      };

      home.persistence."/persist/home" = {
        allowOther = true;
        directories = [
          {
            directory = ".config/obs-studio";
            method = "symlink";
          }
          {
            directory = ".local/share/livesplitone";
            # method = "symlink";
          }
        ];
      };
    };
}
