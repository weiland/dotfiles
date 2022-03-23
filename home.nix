{ config, pkgs, ... }:

let 
  pkgsDarwin = import <nixpkgs-darwin> {}; 
in

{

  home = {
    #username = "pw";
    # homeDirectory = "/home/pw"; # TODO(pascal): Include macos
    packages = with pkgs; [
      any-nix-shell
      # entr
      # imagemagick
      curl
      fzf
      fd
      htop
      jq
      neovim # due to lua config trouble up here
      nodejs
      pandoc
      ripgrep
      # tree # exa will do it
      tree-sitter

      yarn
      #nodePackages.gulp
      nodePackages.eslint
      nodePackages.eslint_d
      nodePackages.prettier
      #nodePackages.elasticdump
    ];

    sessionVariables = {
      EDITOR = "nvim";
    };

    # will be defined in flake (for standalone)
    stateVersion = "21.11";
  };

  programs = {
    home-manager.enable = true;

    bat = {
      enable = true;
      config = {
        theme = "GitHub";
        italic-text = "always";
      };
    };

    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };

    exa = {
      enable = true;
      enableAliases = true;
    };

    fish = {
      enable = true;
      plugins = [
        {
          name = "nix-env";
          src = pkgs.fetchFromGitHub {
            owner = "lilyball";
            repo = "nix-env.fish";
            rev = "00c6cc762427efe08ac0bd0d1b1d12048d3ca727";
            sha256 = "1hrl22dd0aaszdanhvddvqz3aq40jp9zi2zn0v1hjnf7fx4bgpma";
          };
        }
      ];
      shellInit = ''
        # Set syntax highlighting colours; var names defined here:
        set fish_color_normal normal
        set fish_color_command white
        set fish_color_quote brgreen
        set fish_color_redirection brblue
        set fish_color_end white
        set fish_color_error -o brred
        set fish_color_param brpurple
        set fish_color_comment --italics brblack
        set fish_color_match cyan
        set fish_color_search_match --background=brblack
        set fish_color_operator cyan
        set fish_color_escape white
        set fish_color_autosuggestion brblack
      '';
      interactiveShellInit = ''
if command -v starship > /dev/null
  starship init fish | source
end
      '';
      shellAliases = {
        nvim = "nvim -p";
        vim = "nvim -p";
        rm = "rm -i";
        cp = "cp -i";
        mv = "mv -i";
        mkdir = "mkdir -p";
        du = "du -hs";
        # ll = "exa -l sort newest";
        # la = "exa -la"; # conflicts already with exa program
      };

      shellAbbrs = {
        ga = "git add";
        gap = "git add -p";
        gb = "git branch";
        gc = "git commit";
        gcm = "git commit -m";
        gco = "git checkout";
        gd = "git diff";
        gds = "git diff --staged";
        gl = "git pull";
        gp = "git push";
        gpf = "git push --force-with-lease";
        gr = "git restore";
        gs = "git status -sb";
        gss = "git status -sb";
        gsw = "git switch";
        gcb = "git switch -c";
        gsc = "git switch -c";
        hme = "home-manager edit";
        hms = "home-manager switch";
      };
      functions = {
        ctrlp = {
          description = "Launch Neovim file finder from the shell";
          argumentNames = "hidden";
          body = ''
            if test -n "$hidden"
              nvim -c 'lua require(\'telescope.builtin\').find_files({hidden = true})'
            else
              nvim -c 'lua require(\'telescope.builtin\').find_files()'
            end
          '';
        };
        fish_greeting = {
          description = "Greeting to show when starting a fish shell";
          body = "";
        };
        fish_user_key_bindings = {
          description = "Set custom key bindings";
          body = ''
            bind \cp ctrlp
            bind \cl 'ctrlp --hidden'
          '';
        };
        tree = {
          description = "Tree of directory (aliasing exa)";
          body = ''
            command exa --tree --all $argv
          '';
        };
        mkd = {
          description = "MKdir and cd into it.";
          body = ''
            mkdir -p $argv; and cd $argv
          '';
        };
      };
    };

    gh = {
      enable = true;
      settings = {
        aliases = {
          co = "pr checkout";
          pv = "pr view";
        };
        git_protocol = "ssh";
      };
    };

    git = {
      enable = true;
      userName = "Pascal Weiland";
      userEmail = "commits@mailbox.org";
      aliases = {
        prettylog = "log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
        branches = "branch -a";
        remotes = "remote -v";
      };
      delta = {
        enable = true;
        options = {
          navigate = true;
          line-numbers = true;
          syntax-theme = "GitHub";
        };
      };
      extraConfig = {
        core = {
          editor = "nvim";
          # https://github.com/NixOS/nixpkgs/issues/15686#issuecomment-865928923
          # sshCommand = "/usr/bin/ssh"; # macOS thing
        };
        color = {
          ui = true;
        };
        push = {
          default = "simple";
        };
        pull = {
          ff = "only";
        };
        status = {
          showUntrackedFiles = "normal";
        };
        init = {
          defaultBranch = "main";
        };
        url."git@github.com:" = {
          insteadOf = "gh:";
          pushInsteadOf = "gh:";
        };
      };
      ignores = [
        ".*.swp"
        ".bundle"
        ".DS_Store"
        ".envrc"
      ];
    };


    starship = {
      enable = false;
      enableFishIntegration = true;
      settings = {
        add_newline = true;
        right_format = "$time";
        time = {
          disabled = false;
          format = "[\[ $time \]]($style) ";
          time_format = "%T";
        };
      };
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  nixpkgs.overlays = [
    (self: super: {
      starship = pkgsDarwin.starship;
    })
  ];

  # already set by nix-darwin
  #xdg.configFile."nix/nix.conf".text = ''
  #  experimental-features = nix-command flakes
  #'';

  #xdg.configFile.nvim = {
  #  source = ./config/neovim;
  #  recursive = true;
  #};
}
