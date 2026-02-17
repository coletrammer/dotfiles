{ inputs, ... }:
{
  programs.nixvim = {
    imports = [ inputs.seamless-navigation-nvim.nixvimModules.default ];

    plugins.seamless-navigation = {
      enable = true;
    };
  };
}
