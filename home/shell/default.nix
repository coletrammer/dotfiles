{lib, ...}: {
  imports = [
    ./bat.nix
    ./bash.nix
    ./bottom.nix
    ./delta.nix
    ./direnv.nix
    ./duf.nix
    ./eza.nix
    ./fastfetch.nix
    ./fd.nix
    ./fzf.nix
    ./git.nix
    ./hyperfine.nix
    ./jq.nix
    ./just.nix
    ./lf.nix
    ./nh.nix
    ./nix.nix
    ./pistol.nix
    ./ripgrep.nix
    ./starship.nix
    ./tldr.nix
    ./tmux.nix
    ./valgrind.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  options = {
    shell.enable =
      lib.mkEnableOption "Shell programs"
      // {
        default = true;
      };
  };
}
