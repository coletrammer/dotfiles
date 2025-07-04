{
  programs.nixvim = {
    plugins.lualine = {
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";
      settings = {
        options = {
          globalstatus = true;
          disabled_filetypes.statusline = [ "alpha" ];
          component_separators = {
            left = "|";
            right = "|";
          };
          section_separators = {
            left = "";
            right = "";
          };
        };
        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [
            {
              __unkeyed-1 = "branch";
              icon = "";
            }
          ];
          lualine_c = [
            {
              __unkeyed-1 = "filetype";
              icon_only = true;
              padding.left = 1;
              padding.right = 0;
              separator = "";
            }
            {
              __unkeyed-1 = "filename";
              padding.left = 0;
              padding.right = 1;
            }
          ];
          lualine_x = [ ];
          lualine_y = [
            "encoding"
            "fileformat"
          ];
          lualine_z = [
            {
              __unkeyed-1 = "progress";
              padding.left = 1;
              padding.right = 0;
              separator = " ";
            }
            {
              __unkeyed-1 = "location";
              padding.left = 0;
              padding.right = 1;
            }
          ];
        };
      };
    };
  };
}
