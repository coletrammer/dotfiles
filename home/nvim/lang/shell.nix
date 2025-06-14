{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      settings.formatters_by_ft = {
        sh = [ "shfmt" ];
      };
    };
    plugins.lsp.servers.bashls = {
      enable = true;
    };
  };

  nvim.otter.allLangs = [ "sh" ];

  home.packages = with pkgs; [
    shellcheck
    shfmt
  ];
}
