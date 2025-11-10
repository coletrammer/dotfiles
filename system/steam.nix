{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  options = {
    steam.enable = lib.mkEnableOption "Steam";
  };

  config =
    let
      live-split-druid = pkgs.rustPlatform.buildRustPackage {
        pname = "live-split-druid";
        version = "git";

        src = inputs.live-split-druid;

        cargoHash = "sha256-+ChJx1GjZSGSJwUtFKM1Q6i/teHHefNE2dIEFET1fPI=";

        nativeBuildInputs = with pkgs; [
          pkg-config
          wrapGAppsHook
        ];
        buildInputs = with pkgs; [
          glib
          pango
          gtk3
        ];
      };
    in
    lib.mkIf config.steam.enable {
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        gamescopeSession.enable = true;
      };

      security.wrappers.livesplit-one = {
        source = "${live-split-druid}/bin/livesplit-one";
        capabilities = "cap_sys_ptrace+eip";
        owner = "colet";
        group = "users";
      };

      programs.gamemode.enable = true;
    };
}
