{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
    };

    flake-root = {
      url = "github:srid/flake-root";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    di = {
      url = "github:coletrammer/di/minor-fixes";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dius = {
      url = "github:coletrammer/dius";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.di.follows = "di";
    };

    ttx = {
      url = "github:coletrammer/ttx/reflow";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.dius.follows = "dius";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    live-split-druid = {
      url = "github:AlexKnauth/livesplit-one-druid/dev";
      flake = false;
    };

    obs-livesplit-one = {
      url = "github:AlexKnauth/obs-livesplit-one/Refragg-2";
      flake = false;
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stickybuf-nvim = {
      url = "github:stevearc/stickybuf.nvim";
      flake = false;
    };

    multicursor-nvim = {
      url = "github:jake-stewart/multicursor.nvim";
      flake = false;
    };

    ags = {
      url = "github:Aylur/ags/v1";
    };

    tmux = {
      url = "github:tmux/tmux/826ba515beef76dff7d8865599a19e06ae1c4f6a";
      flake = false;
    };

    catppuccin-alacritty = {
      url = "github:catppuccin/alacritty";
      flake = false;
    };

    catppuccin-bat = {
      url = "github:catppuccin/bat";
      flake = false;
    };

    catppuccin-bottom = {
      url = "github:catppuccin/bottom/ed09bd5a5dd78d83acdc8ff5fdec40a6340ed1c2";
      flake = false;
    };

    catppuccin-delta = {
      url = "github:catppuccin/delta";
      flake = false;
    };

    catppuccin-palette = {
      url = "github:catppuccin/palette";
      flake = false;
    };

    catppuccin-ghostty = {
      url = "github:catppuccin/ghostty";
      flake = false;
    };

    catppuccin-tmux = {
      url = "github:catppuccin/tmux/v0.3.0";
      flake = false;
    };

    catppuccin-zathura = {
      url = "github:catppuccin/zathura";
      flake = false;
    };

    catppuccin-zsh-fsh = {
      url = "github:catppuccin/zsh-fsh";
      flake = false;
    };

    lf = {
      url = "github:gokcehan/lf";
      flake = false;
    };

    yazi-flavors = {
      url = "github:yazi-rs/flavors";
      flake = false;
    };

    yazi-plugins = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };
  };

  outputs =
    {
      flake-parts,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      imports = [
        inputs.treefmt-nix.flakeModule
        inputs.flake-root.flakeModule
        hosts/flake-module.nix
        home/configurations/flake-module.nix
      ];

      perSystem =
        { config, pkgs, ... }:
        {
          treefmt.config = {
            inherit (config.flake-root) projectRootFile;

            programs.stylua.enable = true;
            programs.nixfmt.enable = true;
            programs.prettier.enable = true;
            programs.shfmt.enable = true;

            settings.excludes = [
              ".editorconfig"
              "**/*.zsh"
              "LICENSE"
              "flake.lock"
              ".gitignore"
            ];
          };

          devShells.default = pkgs.mkShell {
            packages = [
              config.treefmt.build.wrapper
              pkgs.nodePackages_latest.npm
              pkgs.nodejs
            ]
            ++ builtins.attrValues config.treefmt.build.programs;
          };
        };
    };
}
