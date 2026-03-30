{ inputs, pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "pixel";
        src = inputs.pixel-nvim;
      })
    ];
  };
}
