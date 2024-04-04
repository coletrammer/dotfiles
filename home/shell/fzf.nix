{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    shell.fzf.enable =
      lib.mkEnableOption "fzf"
      // {
        default = config.shell.enable;
      };
  };

  config = lib.mkIf config.shell.fzf.enable {
    programs.fzf = {
      enable = true;
    };

    programs.bash.initExtra = ''
      source ${pkgs.vimPlugins.tokyonight-nvim}/extras/fzf/tokyonight_night.zsh
    '';

    programs.zsh.initExtra = ''
      source ${pkgs.vimPlugins.tokyonight-nvim}/extras/fzf/tokyonight_night.zsh
    '';
  };
}
