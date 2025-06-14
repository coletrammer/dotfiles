{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  options = {
    nvim.enable = lib.mkEnableOption "Neovim" // {
      default = true;
    };
  };

  config = lib.mkIf config.nvim.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      # Trying out the experimental lua loader.
      luaLoader.enable = true;

      performance = {
        # Performance - enable lua byte code compilation
        byteCompileLua = {
          enable = true;
          configs = true;
          initLua = true;
          luaLib = true;
          nvimRuntime = true;
          plugins = true;
        };
      };

      # Use nixpkgs in sync with home manager.
      nixpkgs.useGlobalPackages = true;

      # wl-clipboard is required for copy/paste to work on wayland desktops.
      # ripgrep and fd is used for search
      extraPackages = with pkgs; [
        wl-clipboard
        ripgrep
        fd
      ];
    };

    # Aliases
    home.shellAliases = {
      vimdiff = "nvim -d";
      dvim = "echo | nvim";
    };

    # Persist nvim data.
    home.persistence."/persist/home" = {
      allowOther = true;
      directories = [
        {
          directory = ".local/state/nvim";
          method = "symlink";
        }
        {
          directory = ".local/share/nvim";
          method = "symlink";
        }
      ];
    };
  };
}
