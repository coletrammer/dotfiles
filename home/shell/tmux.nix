{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  options = {
    shell.tmux = {
      enable = lib.mkEnableOption "tmux" // {
        default = config.shell.enable;
      };

      autostart = lib.mkEnableOption "tmux autostart";
    };
  };

  config = lib.mkIf config.shell.tmux.enable {
    programs.tmux = {
      enable = true;
      package = pkgs.tmux.overrideAttrs {
        version = "git";
        src = inputs.tmux;
      };
      aggressiveResize = true;
      baseIndex = 1;
      historyLimit = 50000;
      customPaneNavigationAndResize = true;
      disableConfirmationPrompt = true;
      mouse = true;
      escapeTime = 0;
      keyMode = "vi";
      shortcut = "a";
      shell = "${config.preferences.shell}";
      terminal = "tmux-256color";

      extraConfig = ''
        # Renumber windows
        set-option -g renumber-windows on

        # Disable confirmation prompt when killing panes
        bind-key x kill-pane

        # Stay in tmux unless explicitly detaching
        set -g detach-on-destroy off

        # Shift arrow to switch windows
        bind -n S-Left  previous-window
        bind -n S-Right next-window

        # Shift alt vim keys to switch windows
        bind -n M-H previous-window
        bind -n M-L next-window

        # Copy mode keybindings
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

        # Sensible split window shortcuts
        bind '-' split-window -v -c "#{pane_current_path}"
        bind '|' split-window -h -c "#{pane_current_path}"

        # Visual Activity
        set -g visual-activity off

        # Clipboard
        set -s set-clipboard on

        # Focus events
        set -g focus-events on

        # Status bar on top
        set -g status-position top

        # Reload config
        bind R source-file ~/.config/tmux/tmux.conf
      '';

      plugins = with pkgs; [
        tmuxPlugins.vim-tmux-navigator
        tmuxPlugins.yank
        tmuxPlugins.tmux-fzf
        tmuxPlugins.sessionist
        tmuxPlugins.session-wizard
        {
          plugin = tmuxPlugins.resurrect;
          extraConfig = ''
            # Resurrect Config
            set -g @resurrect-processes '"~nvim->nvim"'

            # Terminal features
            set-option -sa terminal-overrides ",xterm*:Tc"
            set -as terminal-overrides ",alacritty*:Tc"
            set-option -sa terminal-features ",xterm*:RGB"
            set -as terminal-features 'xterm*:hyperlinks'

            # Extended keys
            set -s extended-keys on
            set -as terminal-features 'xterm*:extkeys'

            # Passthrough
            set -g allow-passthrough on
          '';
        }
        {
          plugin = tmuxPlugins.continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-save-interval '15'
          '';
        }
      ];
    };

    programs.fzf.tmux = {
      enableShellIntegration = true;
      shellIntegrationOptions = [ "-p" ];
    };

    home.persistence."/persist/home" = {
      allowOther = true;
      directories = [
        {
          directory = ".tmux";
          method = "symlink";
        }
      ];
    };

    programs.bash.initExtra = lib.mkIf config.shell.tmux.autostart (
      lib.mkOrder 10000 ''
        [ -z "$TMUX" ] && [ "$TERM_PROGRAM" != "vscode" ] && { tmux attach || exec tmux new-session; }
      ''
    );

    programs.zsh.initContent = lib.mkIf config.shell.tmux.autostart (
      lib.mkOrder 5 ''
        [ -z "$TMUX" ] && [ "$TERM_PROGRAM" != "vscode" ] && { tmux attach || exec tmux new-session; }
      ''
    );

    systemd.user.services.tmux = {
      Unit = {
        Description = "Tmux";
      };

      Service = {
        Type = "forking";
        ExecStart = "${config.programs.tmux.package}/bin/tmux start-server";
        ExecStop = "${config.programs.tmux.package}/bin/tmux kill-server";
      };

      Install.WantedBy = [ "default.target" ];
    };
  };
}
