{ config, helpers, ... }:
let
  header = text: {
    type = "text";
    opts = {
      hl = "AlphaHeader";
      position = "center";
    };
    val = text;
  };
  padding = val: {
    inherit val;

    type = "padding";
  };
  group = values: {
    type = "group";
    val = values;
    opts.spacing = 1;
  };
  button = label: shortcut: action: {
    type = "button";
    opts = {
      inherit shortcut;

      position = "center";
      width = 50;
      cursor = 3;
      align_shortcut = "right";
      hl = "AlphaButtons";
      hl_shortcut = "AlphaShortcut";
      keymap = [
        "n"
        shortcut
        action
        {
          noremap = true;
          silent = true;
          nowait = true;
        }
      ];
    };
    val = label;
  };
  footer =
    helpers.luaRawExpr ''
      return {
        type = "text",
        opts = {
          hl = "AlphaFooter",
          position = "center",
        },
        val = require("alpha.fortune")(),
      }
    ''
    // {
      type = "text";
    };
in
{
  programs.nixvim = {
    plugins.alpha = {
      enable = true;
      settings = {
        theme = null;
        opts.margin = 5;
        layout = [
          (padding 4)
          (header [
            "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗"
            "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║"
            "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║"
            "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║"
            "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║"
            "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝"
          ])
          (padding 4)
          (group [
            (button "󰈞 Find file" "f" "<cmd> FzfLua files <cr>")
            (button " New file" "n" "<cmd> ene <BAR> startinsert <cr>")
            (button " Recent" "r" "<cmd> FzfLua oldfiles <cr>")
            (button "󰈬 Search files" "s" "<cmd> FzfLua live_grep <cr>")
            (button " Git" "g" "<cmd> Neogit <cr>")
            (button " File Explorer" "-" "<cmd> Oil <cr>")
            (button " Config" "c" ":e ${config.preferences.dotfilesPath} <CR>")
            (button " Restore Session" "w" "<cmd> SessionRestore <cr>")
            (button " Quit" "q" "<cmd> qa <cr>")
          ])
          (padding 2)
          footer
        ];
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>;";
        action = "<cmd>Alpha<cr>";
        options = {
          desc = "Open Dashboard";
        };
      }
    ];
  };
}
