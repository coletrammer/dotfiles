{ helpers, pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "autoformatting";
        src = ./.;
        dependencies = [ pkgs.vimPlugins.plenary-nvim ];
      })
    ];
    extraConfigLua = ''
      require("autoformatting").setup()
    '';
    keymaps = [
      {
        key = "<leader>uff";
        mode = "n";
        action = helpers.luaRawExpr ''
          return function()
            require("autoformatting").toggle_file()
          end
        '';
        options.desc = "Formatting Toggle (File)";
      }
      {
        key = "<leader>uft";
        mode = "n";
        action = helpers.luaRawExpr ''
          return function()
            require("autoformatting").toggle_filetype()
          end
        '';
        options.desc = "Formatting Toggle (File Type)";
      }
      {
        key = "<leader>ufg";
        mode = "n";
        action = helpers.luaRawExpr ''
          return function()
            require("autoformatting").toggle_globally()
          end
        '';
        options.desc = "Formatting Toggle (Global)";
      }
      {
        key = "<leader>ufr";
        mode = "n";
        action = helpers.luaRawExpr ''
          return function()
            require("autoformatting").reset()
          end
        '';
        options.desc = "Formatting Toggle (Reset)";
      }
      {
        key = "<leader>ufs";
        mode = "n";
        action = helpers.luaRawExpr ''
          return function()
            require("autoformatting").display_status()
          end
        '';
        options.desc = "Formatting Status";
      }
      {
        key = "<leader>ufo";
        mode = "n";
        action = helpers.luaRawExpr ''
          return function()
            require("autoformatting").formatter_override()
          end
        '';
        options.desc = "Formatter Override";
      }
    ];
    plugins.which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>uf";
        group = "+autoformatting";
      }
    ];
  };
}
