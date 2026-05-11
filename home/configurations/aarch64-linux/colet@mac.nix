{ config, ... }:
{
  imports = [
    ../..
  ];

  home = {
    username = "colet";
    homeDirectory = "/home/colet";
    stateVersion = "25.11";
  };

  apps = {
    enable = true;
    alacritty.enable = true;
    kitty.enable = true;
    contour.enable = true;
    foot.enable = true;
    wezterm.enable = true;
    obs.enable = true;
    spotify.enable = false;
    discord.enable = false;
    # steam.enable = true;
    # vscode.enable = true;
  };

  desktop.enable = true;
  desktop.hyprland.defaultScale = 1.6;
  shell.git.gpgKey = "3B030DECC870F389";
  shell.ttx.enable = true;
  shell.ttx.autostart = true;
  shell.vttest.enable = true;

  programs.zsh.initContent = ''
    source /persist/secrets/env.sh
  '';

  nvim.lang.cpp.queryDriver = [
    "/nix/store/*/bin/clang*"
    "/nix/store/*/bin/gcc*"
    "/nix/store/*/bin/g++*"
    "${config.home.homeDirectory}/Workspace/os/iros/cross/bin/*"
    "${config.home.homeDirectory}/Workspace/os/serenity/Toolchain/Local/*/bin/*"
  ];

  nixpkgs.config.allowUnfree = true;
}
