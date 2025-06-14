{ helpers, ... }:
{
  programs.nixvim = {
    plugins.trouble = {
      enable = true;
      lazyLoad.settings = {
        cmd = "Trouble";
        keys = helpers.lazyKeyMaps [
          {
            mode = "n";
            key = "<leader>xx";
            action = "<cmd>Trouble diagnostics toggle<cr>";
            options = {
              desc = "Diagnostics (Trouble)";
            };
          }
          {
            mode = "n";
            key = "<leader>xX";
            action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
            options = {
              desc = "Buffer Diagnostics (Trouble)";
            };
          }
          {
            mode = "n";
            key = "<leader>cs";
            action = "<cmd>Trouble symbols toggle focus=false<cr>";
            options = {
              desc = "Symbols (Trouble)";
            };
          }
          {
            mode = "n";
            key = "<leader>cS";
            action = "<cmd>Trouble lsp toggle focus=false win.position=right<cr>";
            options = {
              desc = "LSP References (Trouble)";
            };
          }
          {
            mode = "n";
            key = "<leader>xL";
            action = "<cmd>Trouble loclist toggle<cr>";
            options = {
              desc = "Location List (Trouble)";
            };
          }
          {
            mode = "n";
            key = "<leader>xQ";
            action = "<cmd>Trouble qflist toggle<cr>";
            options = {
              desc = "Quickfix List (Trouble)";
            };
          }
          {
            mode = "n";
            key = "]q";
            action = helpers.luaRawExpr ''
              return function()
                if require("trouble").is_open() then
                  require("trouble").next({ skip_groups = true, jump = true })
                else
                  local ok, err = pcall(vim.cmd.cnext)
                  if not ok then
                    vim.notify(err, vim.log.levels.ERROR)
                  end
                end
              end
            '';
            options = {
              desc = "Next Quickfix";
            };
          }
          {
            mode = "n";
            key = "[q";
            action = helpers.luaRawExpr ''
              return function()
                if require("trouble").is_open() then
                  require("trouble").prev({ skip_groups = true, jump = true })
                else
                  local ok, err = pcall(vim.cmd.cprev)
                  if not ok then
                    vim.notify(err, vim.log.levels.ERROR)
                  end
                end
              end
            '';
            options = {
              desc = "Prev Quickfix";
            };
          }
        ];
      };
    };
    plugins.fzf-lua = {
      settings.defaults.actions = {
        "ctrl-t" = helpers.luaRaw ''require("trouble.sources.fzf").actions.open'';
      };
    };
    autoCmd = [
      {
        event = "QuickFixCmdPost";
        callback = helpers.luaRawExpr ''
          return function()
            vim.cmd([[Trouble qflist open]])
          end'';
      }
    ];
  };

  nvim.plugins = {
    fzf-lua.dependencies = [ "trouble" ];
  };
}
