{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [ inputs.ttx.homeModules.default ];

  options = {
    shell.ttx = {
      enable = lib.mkEnableOption "ttx" // {
        default = config.shell.enable;
      };
      autostart = lib.mkEnableOption "ttx autostart";
    };
  };

  config =
    let
      autostart = shell: ''
        [ -z "$TMUX" ] && [ -z "$ZELLIJ" ] && [ -z "$ABDUCO_SOCKET" ] && [ "$TERM_PROGRAM" != "vscode" ] && [ "$TERM_PROGRAM" != "ttx" ] && { ${pkgs.abduco}/bin/abduco -A ttx ttx new --prefix A --layout-save main --layout-restore main ${config.preferences.shell}; }
      '';
    in
    lib.mkIf config.shell.ttx.enable {
      programs.bash.initExtra = lib.mkIf config.shell.ttx.autostart (
        lib.mkOrder 10000 (autostart "bash")
      );

      programs.zsh.initContent = lib.mkIf config.shell.ttx.autostart (lib.mkOrder 5 (autostart "zsh"));
      programs.ttx = {
        enable = true;
      };

      # Persist ttx data.
      home.persistence."/persist/home" = {
        allowOther = true;
        directories = [
          {
            directory = ".local/state/ttx";
            method = "symlink";
          }
          {
            directory = ".local/share/ttx";
            method = "symlink";
          }
        ];
      };
    };
}
