{ pkgs }:

with pkgs; [
  # General packages for development and system management
  # alacritty
  kitty
  aspell
  aspellDicts.en
  bash-completion
  bat
  btop
  coreutils
  killall
  neofetch
  openssh
  #sqlite
  wget
  zip

  neovim

  # Encryption and security tools
  #age
  #age-plugin-yubikey
  #gnupg
  #libfido2

  # Cloud-related tools and SDKs
  docker
  docker-compose

  # Media-related packages
  #emacs-all-the-icons-fonts
  #dejavu_fonts
  #ffmpeg
  #fd
  #font-awesome
  #hack-font
  #noto-fonts
  #noto-fonts-emoji
  #meslo-lgs-nf

  # Node.js development tools
  #nodePackages.npm # globally install npm
  #nodePackages.prettier
  #nodejs

  # Go development tools
  go
  gopls
  
  # html-lsp
  htmx-lsp
  tailwindcss-language-server

  # Text and terminal utilities
  htop
  hunspell
  iftop
  jetbrains-mono
  fzf
  jq
  ripgrep
  tree
  tmux
  unrar
  unzip
  zsh-powerlevel10k
  yazi
  tldr

  # Python packages
  #python39
  #python39Packages.virtualenv # globally install virtualenv
]
