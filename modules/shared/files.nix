{ pkgs, config, ... }:

{
  # Initializes Emacs with org-mode so we can tangle the main config
  # ".emacs.d/init.el" = {
  #   text = builtins.readFile ../shared/config/emacs/init.el;
  # };
      # file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;
      # ".tmux.conf".source = ../.tmux.conf; 
      # ".vimrc".source = ../.vimrc;
      ".zshrc".source = ../shared/config/.zshrc;
      # ".config" = {
      #   source = ../../../.config;
      #   recursive = true;
      # };
      ".config/kitty" = {
        source = ../shared/config/kitty;
        recursive = true;
      };
      ".config/nvim" = {
        source = ../shared/config/nvim;
        recursive = true;
      };
      # "rc" = {
      #   source = ../rc;
      #   recursive = true;
      # };

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    # };
}
