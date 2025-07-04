{
  programs.nixvim = {
    plugins.conform-nvim = {
      settings.formatters_by_ft = {
        yaml = {
          __unkeyed-0 = "prettierd";
          __unkeyed-1 = "prettier";
          stop_after_first = true;
        };
      };
    };
    plugins.lsp.servers.yamlls = {
      enable = true;
      extraOptions.settings = {
        redhat.telemetry.enabled = false;
        yaml = {
          validate.enable = true;
          keyOrdering = false;
          schemaStore = {
            enable = false;
            url = "";
          };
          schemas.__raw = ''require('schemastore').yaml.schemas()'';
        };
      };
    };
  };

  nvim.otter.allLangs = [ "yaml" ];
}
