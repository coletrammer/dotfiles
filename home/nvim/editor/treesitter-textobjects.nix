{
  programs.nixvim = {
    plugins.treesitter-textobjects = {
      enable = true;
      settings = {
        move = {
          enable = true;
          set_jumps = true;
          goto_next_start = {
            "]f" = "@function.outer";
            "]]" = "@class.outer";
          };
          goto_next_end = {
            "]F" = "@function.outer";
            "][" = "@class.outer";
          };
          goto_previous_start = {
            "[f" = "@function.outer";
            "[[" = "@class.outer";
          };
          goto_previous_end = {
            "[F" = "@function.outer";
            "[]" = "@class.outer";
          };
        };
        swap = {
          enable = true;
          swap_next = {
            "<leader>a" = "@parameter.inner";
          };
          swap_previous = {
            "<leader>A" = "@parameter.inner";
          };
        };
      };
    };
    plugins.treesitter = {
      settings = {
        incremental_selection = {
          enable = true;
          keymaps = {
            init_selection = "<enter>";
            node_incremental = "<enter>";
            node_decremental = "<bs>";
          };
        };
      };
    };
  };
}
