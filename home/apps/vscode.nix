{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    apps.vscode.enable = lib.mkEnableOption "VS Code";
  };

  config = lib.mkIf config.apps.vscode.enable {
    home.packages = with pkgs; [ vscode-fhs ];

    home.persistence."/persist" = {
      directories = [
        {
          directory = ".vscode";
        }
        {
          directory = ".config/Code";
        }
      ];
    };
  };
}
