{
  config,
  helpers,
  lib,
  pkgs,
  ...
}:
{
  options = {
    nvim.lang.rust = {
      lldb = lib.mkEnableOption "VS Code LLDB" // {
        default = config.preferences.os == "linux";
      };
    };
  };

  config = {
    programs.nixvim = {
      plugins.conform-nvim = {
        settings.formatters_by_ft = {
          rust = [ "rustfmt" ];
        };
      };
      dependencies.rust-analyzer.enable = false;
      plugins.rustaceanvim = {
        enable = true;
        settings = {
          server = {
            default_settings = {
              check = {
                command = "clippy";
              };
            };
            on_attach = helpers.luaExpr ''
              return function(_, bufnr)
                vim.keymap.set("n", "<leader>cR", function()
                  vim.cmd.RustLsp("codeAction")
                end, { desc = "Rust Action", buffer = bufnr })
                vim.keymap.set("n", "<leader>dr", function()
                  vim.cmd.RustLsp("debuggables")
                end, { desc = "Rust Debuggables", buffer = bufnr })
              end
            '';
          };
        };
      };
      plugins.crates = {
        enable = true;
        lazyLoad.settings.event = "BufRead Cargo.toml";
      };
      plugins.lsp.servers.taplo.onAttach.function = helpers.lua ''
        vim.keymap.set("n", "K", function()
          if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
            require("crates").show_popup()
          else
            vim.lsp.buf.hover()
          end
        end, { buffer = bufnr })
      '';
    };

    nvim.otter.allLangs = [ "rust" ];

    home.packages = with pkgs; [
      cargo
      clippy
      rust-analyzer
      rustc
      rustfmt
    ];
  };
}
