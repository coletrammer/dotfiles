{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
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
          enable = false;
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
      extraPackages =
        with pkgs;
        [
          ripgrep
          fd
        ]
        ++ (if config.preferences.os == "linux" then [ wl-clipboard ] else [ ]);
    };

    # Aliases
    home.shellAliases = {
      vimdiff = "nvim -d";
      dvim = "echo | nvim";
    };

    # Persist nvim data.
    home.persistence."/persist" = {
      directories = [
        {
          directory = ".local/state/nvim";
        }
        {
          directory = ".local/share/nvim";
        }
      ];
    };
  };
}
