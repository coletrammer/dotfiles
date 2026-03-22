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
        [ -z "$TMUX" ] && [ -z "$NVIM" ] && [ -z "$ZELLIJ" ] && [ -z "$ABDUCO_SOCKET" ] && [ "$TERM_PROGRAM" != "vscode" ] && [ "$TERM_PROGRAM" != "ttx" ] && { ${pkgs.abduco}/bin/abduco -A ttx ttx; }
      '';
    in
    lib.mkIf config.shell.ttx.enable {
      programs.bash.initExtra = lib.mkIf config.shell.ttx.autostart (
        lib.mkOrder 10000 (autostart "bash")
      );

      programs.zsh.initContent = lib.mkIf config.shell.ttx.autostart (lib.mkOrder 5 (autostart "zsh"));
      programs.ttx = {
        enable = true;
        settings = {
          main = builtins.fromJSON <| builtins.readFile ./ttx-main.json;
          super = builtins.fromJSON <| builtins.readFile ./ttx-super.json;
        };
      };

      # Persist ttx data.
      home.persistence."/persist" = {
        directories = [
          {
            directory = ".local/state/ttx";
          }
          {
            directory = ".local/share/ttx";
          }
        ];
      };
    };
}
