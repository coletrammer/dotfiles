{...}: {
  programs.starship = {
    enable = true;
    settings = {
      # Global config
      command_timeout = 1000;
      format = "$character";
      right_format = "$all";

      # NerdFont preset
      aws.symbol = "  ";
      buf.symbol = " ";
      c.symbol = " ";
      conda.symbol = " ";
      crystal.symbol = " ";
      dart.symbol = " ";
      directory.read_only = " 󰌾";
      docker_context.symbol = " ";
      elixir.symbol = " ";
      elm.symbol = " ";
      fennel.symbol = " ";
      fossil_branch.symbol = " ";
      git_branch.symbol = " ";
      golang.symbol = " ";
      guix_shell.symbol = " ";
      haskell.symbol = " ";
      haxe.symbol = " ";
      hg_branch.symbol = " ";
      hostname.ssh_symbol = " ";
      java.symbol = " ";
      julia.symbol = " ";
      kotlin.symbol = " ";
      lua.symbol = " ";
      memory_usage.symbol = "󰍛 ";
      meson.symbol = "󰔷 ";
      nim.symbol = "󰆥 ";
      nix_shell.symbol = " ";
      nodejs.symbol = " ";
      ocaml.symbol = " ";
      os.symbols.Alpaquita = " ";
      os.symbols.Alpine = " ";
      os.symbols.AlmaLinux = " ";
      os.symbols.Amazon = " ";
      os.symbols.Android = " ";
      os.symbols.Arch = " ";
      os.symbols.Artix = " ";
      os.symbols.CentOS = " ";
      os.symbols.Debian = " ";
      os.symbols.DragonFly = " ";
      os.symbols.Emscripten = " ";
      os.symbols.EndeavourOS = " ";
      os.symbols.Fedora = " ";
      os.symbols.FreeBSD = " ";
      os.symbols.Garuda = "󰛓 ";
      os.symbols.Gentoo = " ";
      os.symbols.HardenedBSD = "󰞌 ";
      os.symbols.Illumos = "󰈸 ";
      os.symbols.Kali = " ";
      os.symbols.Linux = " ";
      os.symbols.Mabox = " ";
      os.symbols.Macos = " ";
      os.symbols.Manjaro = " ";
      os.symbols.Mariner = " ";
      os.symbols.MidnightBSD = " ";
      os.symbols.Mint = " ";
      os.symbols.NetBSD = " ";
      os.symbols.NixOS = " ";
      os.symbols.OpenBSD = "󰈺 ";
      os.symbols.openSUSE = " ";
      os.symbols.OracleLinux = "󰌷 ";
      os.symbols.Pop = " ";
      os.symbols.Raspbian = " ";
      os.symbols.Redhat = " ";
      os.symbols.RedHatEnterprise = " ";
      os.symbols.RockyLinux = " ";
      os.symbols.Redox = "󰀘 ";
      os.symbols.Solus = "󰠳 ";
      os.symbols.SUSE = " ";
      os.symbols.Ubuntu = " ";
      os.symbols.Unknown = " ";
      os.symbols.Void = " ";
      os.symbols.Windows = "󰍲 ";
      package.symbol = "󰏗 ";
      perl.symbol = " ";
      php.symbol = " ";
      pijul_channel.symbol = " ";
      python.symbol = " ";
      rlang.symbol = "󰟔 ";
      ruby.symbol = " ";
      rust.symbol = " ";
      scala.symbol = " ";
      swift.symbol = " ";
      zig.symbol = " ";
    };
  };
}
