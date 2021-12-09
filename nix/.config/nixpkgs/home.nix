{ config, pkgs, lib, ... }:

{
  imports = [
    # ./dotfiles.nix
  ];
  # use home-manager for managing user content (nix-darwin for darwin specific settings only)
  programs = {
    home-manager.enable = true;

    bat.enable = true;
    exa = {
      enable = true;
      enableAliases = true;
    };
    fzf.enable = true;
    gh.enable = true;
    # gpg.enable = true;
    htop.enable = true;
    jq.enable = true;

    git = {
      enable = true;

      userName = "Pascal Weiland";
      userEmail = "commits@mailbox.org";
    };

    # Project specific settings
    # direnv.enable = true;
    # lorri.enable = true;

    starship = {
      enable = true;
      enableFishIntegration = true;

      settings = {
      };
    };

    fish = {
      enable = true;
    };

    tmux = {
      enable = true;
    };

    # home.file = { "init.vim".source = dotfiles/init.vim; };
    # xdg.configFile = { };
    # xdg.configFile."nix/nix.conf".text = ''
    #     experimental-features = nix-command flakes
    #   '';
  }

  home = {
    username = "pw"; # TODO(pascal): Use env USER
    homeDirectory = "/Users/pw"; # TODO(pascal): Use env HOME

    stateVersion = "21.05";

    sessionVariables = {
      EDITOR = "nvim";
    };

    sessionPath = [
      "$HOME/.cargo/bin"
    ];

    packages = with pkgs; [
      ( python38.withPackages (ps: with ps; [ pip pynvim ]) )
      any-nix-shell
      # exa # also used for tree
      entr
      fd
      # ffmpeg
      # fish
      # imagemagick
      neovim
      nodePackages.serve
      nodePackages.git-open
      nodePackages.git-recent
      pandoc
      rustup
      ripgrep
      tig
      tldr
      # tree-sitter
      xsv
      yarn
      youtube-dl
    ];
  };
}
