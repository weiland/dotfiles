{ config, pkgs, ... }:

let 
  pkgsDarwin = import <nixpkgs-darwin> {}; 
in

{

  home = {
    username = "pw";
    homeDirectory = "/Users/pw"; # TODO(pascal): Include macos

    # disable last login message
    file.".hushlogin".text = "";

    packages = with pkgs; [
      alacritty
      any-nix-shell
      # entr
      # imagemagick
      curl
      docker
      docker-compose
      fzf
      fd
      git-open
      htop
      jq
      neovim # due to lua config trouble up here
      nodejs
      #openconnect
      pandoc
      ripgrep
      stow
      terminal-notifier
      tree-sitter

      yarn
      #nodePackages.gulp
      nodePackages.eslint
      nodePackages.eslint_d
      nodePackages.prettier
      #nodePackages.elasticdump
    ];

    sessionPath = [ "/opt/homebrew/bin/" ];

    sessionVariables = {
      EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
    };

    # will be defined in flake (for standalone)
    stateVersion = "21.11";
  };

  programs = {
    home-manager.enable = true;

    bat = {
      enable = true;
      config = {
        theme = "Nord";
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
        {
          name = "done";
          src = pkgs.fetchFromGitHub {
            owner = "franciscolourenco";
            repo = "done";
            rev = "d6abb267bb3fb7e987a9352bc43dcdb67bac9f06";
            sha256 = "1h8v5jg9kkali50qq0jn0i1w68wp4c2l0fapnglnnpg0v4vv51za";
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
      '';
      shellAliases = {
        nvim = "nvim -p";
        vim = "nvim -p";
        rm = "rm -i";
        cp = "cp -i";
        hm = "home-manager";
        mv = "mv -i";
        mkdir = "mkdir -p";
        du = "du -hs";
        ll = "exa -l --sort newest";
        la = "exa -la";
        ql = "qlmanage -p 2>/dev/null";
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
	reload = {
          description = "reload fish config";
          body = "source ~/.config/fish/config.fish";
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
          syntax-theme = "Nord";
        };
      };
      extraConfig = {
        core = {
          editor = "nvim";
          # https://github.com/NixOS/nixpkgs/issues/15686#issuecomment-865928923
          # sshCommand = "/usr/bin/ssh"; # macOS thing
        };
	credential.helper = "osxkeychain";
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
          insteadOf = "https://github.com/";
          pushInsteadOf = "https://github.com/";
        };
      };
      ignores = [
        ".*.swp"
        ".bundle"
        ".DS_Store"
        ".envrc"
      ];
      includes = [
        {
          condition = "gitdir:~/src/weiland";
          contents = {
            user = {
              email = "weiland@users.noreply.github.com";
              signingkey = "8F592971";
            };
          };
        }
        {
          condition = "gitdir:~/src/rp-online";
          contents = {
            user = {
              email = "pascal.weiland@rp-digital.de";
              signingkey = "34562F25";
            };
          };
        }
      ];
    };

    gpg = {
      enable = true;
      homedir = "${config.xdg.dataHome}/gnupg";
    };

    neovim = {
      enable = false;
      vimAlias = true;
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        command_timeout = 100;
        add_newline = true;
        right_format = "$time";
        time = {
          disabled = false;
          format = "[ $time ]($style) ";
          time_format = "%T";
        };
      };
    };

    ssh = {
      enable = true;

      includes = [ "~/Documents/Configs/ssh/.ssh/private_ssh_config" ];

      matchBlocks = {
        "*" = {
          identityFile = "~/Documents/Configs/ssh/.ssh/id_pw_hopper";
          extraOptions = {
            ChallengeResponseAuthentication = "no";
            HashKnownHosts = "yes";
            AddKeysToAgent = "yes";
            IgnoreUnknown = "UseKeychain";
            UseKeychain = "yes";
          };
        };
        "y" = {
          "hostname" = "spahr.uberspace.de";
          "user" = "y";
        };
      };
    };

    tmux = {
      enable = true;

      clock24 = true;

    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  nixpkgs.overlays = [
    (self: super: {
      starship = pkgsDarwin.starship;
      #openconnect = pkgsDarwin.openconnect_openssl;
      #openconnect = pkgsUnstable.openconnect;
    })
  ];

  xdg.enable = true;

  # extra config
  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes
  '';

  xdg.configFile.nvim = {
    source = ./config/neovim;
    recursive = true;
  };
}
