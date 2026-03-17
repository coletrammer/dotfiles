{
  programs.nixvim = {
    plugins.illuminate = {
      enable = true;
      settings = {
        delay = 200;
        large_file_cutoff = 10000;
        large_file_overrides = {
          providers = [ "lsp" ];
        };
      };
    };
  };
}
