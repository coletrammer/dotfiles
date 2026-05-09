{
  self,
  lib,
  inputs,
  ...
}@args:
let
  dirs = lib.attrsets.filterAttrs (_: type: type == "directory") (builtins.readDir ./.);
  hosts = builtins.attrNames dirs |> builtins.filter (name: name != "common");
  mkConfig = host: {
    name = host;
    value = inputs.nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit inputs;
        inherit self;
        helpers = (import ../helpers) args;
      };
      modules = [
        ./${host}/configuration.nix
      ];
    };
  };
  configs = map mkConfig hosts;
in
{
  flake = {
    darwinConfigurations = builtins.listToAttrs configs;
  };
}
