{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      settings.formatters_by_ft = {
        zig = [
          "zigfmt"
        ];
      };
    };
    plugins.lsp = {
      servers.zls = {
        enable = true;
        package = null;
      };
    };
  };

  home.packages = with pkgs; [
    zig
    zls
  ];
}
