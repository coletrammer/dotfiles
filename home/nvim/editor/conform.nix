{ helpers, ... }:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      settings = {
        notify_on_error = true;
        format_on_save = {
          timeout_ms = 1500;
          lsp_format = "fallback";
        };
        formatters_by_ft."_" = [ "trim_whitespace" ];
        formatters.injected.options.ignore_errors = true;
      };
    };
    keymaps = [
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>cF";
        action = helpers.luaRawExpr ''
          return function()
            require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
          end
        '';
        options.desc = "Format Injected Languages";
      }
    ];
    extraConfigLua = ''
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    '';
  };
}
