{ config, pkgs, lib, ... }:

let name = "Michal Kopczynski";
    user = "michal";
    email = "26494112+michal-kopczynski@users.noreply.github.com"; in
{
  # Shared shell configuration
  # zsh = {
  #   enable = true;
  #   autocd = false;
  #   plugins = [
  #     {
  #       name = "powerlevel10k";
  #       src = pkgs.zsh-powerlevel10k;
  #       file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  #     }
  #     {
  #       name = "powerlevel10k-config";
  #       src = lib.cleanSource ./config;
  #       file = "p10k.zsh";
  #     }
  #   ];

  #   initExtraFirst = ''
  #     if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
  #       . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
  #       . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
  #     fi

  #     # Define variables for directories
  #     #export PATH=$HOME/.pnpm-packages/bin:$HOME/.pnpm-packages:$PATH
  #     #export PATH=$HOME/.npm-packages/bin:$HOME/bin:$PATH
  #     #export PATH=$HOME/.local/share/bin:$PATH

  #     # Remove history data we don't want to see
  #     export HISTIGNORE="pwd:ls:cd"

  #     # Emacs is my editor
  #     #export ALTERNATE_EDITOR=""
  #     #export EDITOR="emacsclient -t"
  #     #export VISUAL="emacsclient -c -a emacs"
  #     export EDITOR="nvim"

  #     #e() {
  #     #    emacsclient -t "$@"
  #     #}

  #     # nix shortcuts
  #     shell() {
  #         nix-shell '<nixpkgs>' -A "$1"
  #     }

  #     # Use difftastic, syntax-aware diffing
  #     alias diff=difft

  #     # Always color ls and group directories
  #     alias ls='ls --color=auto'
  #   '';
  # };

  # git = {
  #   enable = true;
  #   ignores = [ "*.swp" ];
  #   userName = name;
  #   userEmail = email;
  #   lfs = {
  #     enable = true;
  #   };
  #   extraConfig = {
  #     init.defaultBranch = "main";
  #     core = {
	#     editor = "vim";
  #       autocrlf = "input";
  #     };
  #     pull.rebase = true;
  #     rebase.autoStash = true;
  #   };
  # };

  vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline vim-airline-themes vim-startify vim-tmux-navigator ];
    settings = { ignorecase = true; };
    extraConfig = ''
      "" General
      set number
      set history=1000
      set nocompatible
      set modelines=0
      set encoding=utf-8
      set scrolloff=3
      set showmode
      set showcmd
      set hidden
      set wildmenu
      set wildmode=list:longest
      set cursorline
      set ttyfast
      set nowrap
      set ruler
      set backspace=indent,eol,start
      set laststatus=2
      set clipboard=autoselect

      " Dir stuff
      set nobackup
      set nowritebackup
      set noswapfile
      set backupdir=~/.config/vim/backups
      set directory=~/.config/vim/swap

      " Relative line numbers for easy movement
      set relativenumber
      set rnu

      "" Whitespace rules
      set tabstop=8
      set shiftwidth=2
      set softtabstop=2
      set expandtab

      "" Searching
      set incsearch
      set gdefault

      "" Statusbar
      set nocompatible " Disable vi-compatibility
      set laststatus=2 " Always show the statusline
      let g:airline_theme='bubblegum'
      let g:airline_powerline_fonts = 1

      "" Local keys and such
      let mapleader=","
      let maplocalleader=" "

      "" Change cursor on mode
      :autocmd InsertEnter * set cul
      :autocmd InsertLeave * set nocul

      "" File-type highlighting and configuration
      syntax on
      filetype on
      filetype plugin on
      filetype indent on

      "" Paste from clipboard
      nnoremap <Leader>, "+gP

      "" Copy from clipboard
      xnoremap <Leader>. "+y

      "" Move cursor by display lines when wrapping
      nnoremap j gj
      nnoremap k gk

      "" Map leader-q to quit out of window
      nnoremap <leader>q :q<cr>

      "" Move around split
      nnoremap <C-h> <C-w>h
      nnoremap <C-j> <C-w>j
      nnoremap <C-k> <C-w>k
      nnoremap <C-l> <C-w>l

      "" Easier to yank entire line
      nnoremap Y y$

      "" Move buffers
      nnoremap <tab> :bnext<cr>
      nnoremap <S-tab> :bprev<cr>

      "" Like a boss, sudo AFTER opening the file to write
      cmap w!! w !sudo tee % >/dev/null

      let g:startify_lists = [
        \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      }
        \ ]

      let g:startify_bookmarks = [
        \ '~/.local/share/src',
        \ ]

      let g:airline_theme='bubblegum'
      let g:airline_powerline_fonts = 1
      '';
     };

  # alacritty = {
  #   enable = true;
  #   settings = {
  #     cursor = {
  #       style = "Block";
  #     };

  #     window = {
  #       opacity = 1.0;
  #       padding = {
  #         x = 24;
  #         y = 24;
  #       };
  #     };

  #     font = {
  #       normal = {
  #         family = "MesloLGS NF";
  #         style = "Regular";
  #       };
  #       size = lib.mkMerge [
  #         (lib.mkIf pkgs.stdenv.hostPlatform.isLinux 10)
  #         (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin 14)
  #       ];
  #     };

  #     dynamic_padding = true;
  #     decorations = "full";
  #     title = "Terminal";
  #     class = {
  #       instance = "Alacritty";
  #       general = "Alacritty";
  #     };

  #     colors = {
  #       primary = {
  #         background = "0x1f2528";
  #         foreground = "0xc0c5ce";
  #       };

  #       normal = {
  #         black = "0x1f2528";
  #         red = "0xec5f67";
  #         green = "0x99c794";
  #         yellow = "0xfac863";
  #         blue = "0x6699cc";
  #         magenta = "0xc594c5";
  #         cyan = "0x5fb3b3";
  #         white = "0xc0c5ce";
  #       };

  #       bright = {
  #         black = "0x65737e";
  #         red = "0xec5f67";
  #         green = "0x99c794";
  #         yellow = "0xfac863";
  #         blue = "0x6699cc";
  #         magenta = "0xc594c5";
  #         cyan = "0x5fb3b3";
  #         white = "0xd8dee9";
  #       };
  #     };
  #   };
  # };

  # ssh = {
  #   enable = true;
  #   includes = [
  #     (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
  #       "/home/${user}/.ssh/config_external"
  #     )
  #     (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
  #       "/Users/${user}/.ssh/config_external"
  #     )
  #   ];
  #   matchBlocks = {
  #     "github.com" = {
  #       identitiesOnly = true;
  #       identityFile = [
  #         (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
  #           "/home/${user}/.ssh/id_github"
  #         )
  #         (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
  #           "/Users/${user}/.ssh/id_github"
  #         )
  #       ];
  #     };
  #   };
  # };

  # tmux = {
  #   enable = true;
    # plugins = with pkgs.tmuxPlugins; [
    #   vim-tmux-navigator
    #   sensible
    #   yank
    #   prefix-highlight
    #   {
    #     plugin = power-theme;
    #     extraConfig = ''
    #        set -g @tmux_power_theme 'gold'
    #     '';
    #   }
    #   {
    #     plugin = resurrect; # Used by tmux-continuum

    #     # Use XDG data directory
    #     # https://github.com/tmux-plugins/tmux-resurrect/issues/348
    #     extraConfig = ''
    #       set -g @resurrect-dir '$HOME/.cache/tmux/resurrect'
    #       set -g @resurrect-capture-pane-contents 'on'
    #       set -g @resurrect-pane-contents-area 'visible'
    #     '';
    #   }
    #   {
    #     plugin = continuum;
    #     extraConfig = ''
    #       set -g @continuum-restore 'on'
    #       set -g @continuum-save-interval '5' # minutes
    #     '';
    #   }
    # ];
    # terminal = "screen-256color";
    # prefix = "C-x";
    # escapeTime = 10;
    # historyLimit = 50000;
    # extraConfig = ''
    #   # Remove Vim mode delays
    #   set -g focus-events on

    #   # Enable full mouse support
    #   set -g mouse on

    #   # -----------------------------------------------------------------------------
    #   # Key bindings
    #   # -----------------------------------------------------------------------------

    #   # Unbind default keys
    #   unbind C-b
    #   unbind '"'
    #   unbind %

    #   # Split panes, vertical or horizontal
    #   bind-key x split-window -v
    #   bind-key v split-window -h

    #   # Move around panes with vim-like bindings (h,j,k,l)
    #   bind-key -n M-k select-pane -U
    #   bind-key -n M-h select-pane -L
    #   bind-key -n M-j select-pane -D
    #   bind-key -n M-l select-pane -R

    #   # Smart pane switching with awareness of Vim splits.
    #   # This is copy paste from https://github.com/christoomey/vim-tmux-navigator
    #   is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    #     | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
    #   bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
    #   bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
    #   bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
    #   bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
    #   tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
    #   if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
    #     "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
    #   if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
    #     "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

    #   bind-key -T copy-mode-vi 'C-h' select-pane -L
    #   bind-key -T copy-mode-vi 'C-j' select-pane -D
    #   bind-key -T copy-mode-vi 'C-k' select-pane -U
    #   bind-key -T copy-mode-vi 'C-l' select-pane -R
    #   bind-key -T copy-mode-vi 'C-\' select-pane -l
    #   '';

  #   extraConfig = ''
  #     unbind-key C-b

  #     set-option -g prefix C-Space

  #     bind-key C-Space send-prefix

  #     bind r source-file ~/.tmux.conf

  #     set -s escape-time 0
  #     set -g base-index 1

  #     # vim-like pane switching
  #     bind -r ^ last-window
  #     bind -r k select-pane -U
  #     bind -r j select-pane -D
  #     bind -r h select-pane -L
  #     bind -r l select-pane -R

  #     set -g mouse on
  #     set -g set-clipboard on

  #     setw -g mode-keys vi
  #     #bind-key -T copy-mode-vi y send-keys -X copy-selection

  #     # To address ssh forwarding issue in tmux 
  #     # (Permission denied (publickey))
  #     # See https://werat.dev/blog/happy-ssh-agent-forwarding/
  #     set-environment -g 'SSH_AUTH_SOCK' ~/.ssh/ssh_auth_sock

  #     # List of plugins
  #     set -g @plugin 'tmux-plugins/tpm'
  #     set -g @plugin 'tmux-plugins/tmux-sensible'
  #     set -g @plugin 'jabirali/tmux-tilish'
  #     set -g @tilish-default 'even-horizontal'

  #     # Plugin options.
  #     set -g @tilish-navigate 'on'

  #     # Smart pane switching with awareness of Vim splits.
  #     # See: https://github.com/christoomey/vim-tmux-navigator
  #     is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
  #         | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
  #     bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
  #     bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
  #     bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
  #     bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
  #     tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
  #     if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
  #         "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
  #     if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
  #         "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

  #     bind-key -T copy-mode-vi 'C-h' select-pane -L
  #     bind-key -T copy-mode-vi 'C-j' select-pane -D
  #     bind-key -T copy-mode-vi 'C-k' select-pane -U
  #     bind-key -T copy-mode-vi 'C-l' select-pane -R
  #     bind-key -T copy-mode-vi 'C-\' select-pane -l

  #     # end of config for vim-tmux-navigator

  #     set -g @plugin 'tmux-plugins/tmux-yank'
  #     set -g @yank_selection_mouse 'clipboard' # or 'primary' or 'secondary'

  #     set -g window-style 'fg=colour247,bg=colour236'
  #     set -g window-active-style 'fg=colour250,bg=black'


  #     set -g @plugin 'tmux-plugins/tmux-resurrect'
  #     set -g @plugin 'tmux-plugins/tmux-continuum'

  #     set -g @continuum-boot 'on'
  #     set -g @continuum-restore 'on'

  #     # Other examples::w
  #     # set -g @plugin 'github_username/plugin_name'
  #     # set -g @plugin 'github_username/plugin_name#branch'
  #     # set -g @plugin 'git@github.com:user/plugin'
  #     # set -g @plugin 'git@bitbucket.com:user/plugin'

  #     # For yazi image preview
  #     # https://yazi-rs.github.io/docs/image-preview
  #     set -g allow-passthrough on
  #     set -ga update-environment TERM
  #     set -ga update-environment TERM_PROGRAM
  #     # If yazi hangs or there is some issue try to restart tmux
  #     # tmux kill-server && tmux || tmux

  #     # Install `tpm` if needed.
  #     if "test ! -d ~/.tmux/plugins/tpm" \
  #       "run 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins'"

  #     # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
  #     run '~/.tmux/plugins/tpm/tpm'
  #   '';
#   };
  # tmux = {
  #   enable = true;
  #   plugins = [ pkgs.tmuxPlugins.tilish ];
  #   extraConfig = ''
  #     set -g @tilish-navigate 'on'
  #     set -g @tilish-default 'even-horizontal'
  #   '';
  # };
  #
  tmux = {
    enable = true;
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/misc/tmux-plugins/efault.nix
    # base-index = 3;
    plugins = with pkgs;
    [
      {
        plugin = tmuxPlugins.tilish;
        extraConfig = ''
          set -g @tilish-default 'even-horizontal'
          set -g @tilish-navigate 'on'
        '';
      }
      tmuxPlugins.sensible
      tmuxPlugins.resurrect
      # tmuxPlugins.continuum
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-boot 'on'
          set -g @continuum-restore 'on'
        '';
      }
      tmuxPlugins.yank
    ];
    extraConfig = ''

      # As we can't use Command(which is under Ctrl key)+space on MacOs - leave with Ctrl+b
      unbind-key C-b
      set-option -g prefix C-Space
      bind-key C-Space send-prefix

      # set-option -g prefix C-b
      # bind-key C-b send-prefix

      bind r source-file ~/.config/tmux/tmux.conf

      set -s escape-time 0
      set -g base-index 1

      # vim-like pane switching
      bind -r ^ last-window
      bind -r k select-pane -U
      bind -r j select-pane -D
      bind -r h select-pane -L
      bind -r l select-pane -R

      set -g mouse on
      set -g set-clipboard on

      setw -g mode-keys vi
      #bind-key -T copy-mode-vi y send-keys -X copy-selection

      # To address ssh forwarding issue in tmux 
      # (Permission denied (publickey))
      # See https://werat.dev/blog/happy-ssh-agent-forwarding/
      set-environment -g 'SSH_AUTH_SOCK' ~/.ssh/ssh_auth_sock


      # Smart pane switching with awareness of Vim splits.
      # See: https://github.com/christoomey/vim-tmux-navigator
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R
      bind-key -T copy-mode-vi 'C-\' select-pane -l

      # end of config for vim-tmux-navigator

      # set -g @plugin 'tmux-plugins/tmux-yank'
      # does it actually work?
      set -g @yank_selection_mouse 'clipboard' # or 'primary' or 'secondary'

      # doesn't really work
      # if-shell -b 'test $(uname) = "Linux"' 'bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -in -selection clipboard"'
      # if-shell -b 'test $(uname) = "Darwin"' 'bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"'

      set -g window-style 'fg=colour247,bg=colour236'
      set -g window-active-style 'fg=colour250,bg=black'
    '';
  };

  bat = {
    enable = true;
    config = {
      theme = "Dracula";
    };
  };
}
