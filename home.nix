{ config, pkgs, ... }:

let 
  pkgsDarwin = import <nixpkgs-darwin> {}; 
  # pkgsUnstable = import <nixpkgs-unstable> {}; 
in

{

  home = {
    username = "pw";
    homeDirectory = "/Users/pw"; # TODO(pascal): Include macos

    # disable last login message
    file.".hushlogin".text = "";

    file.".curlrc".text = ''
      referer = ";auto"
      connect-timeout = 60
      max-time = 90
      remote-time
      show-error
      progress-bar
      #user-agent = "Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0"
    '';

    file.".gemrc".text = "gem: --no-document";
    
    file."Library/Application Support/iTerm2/DynamicProfiles/Profiles.json".source = ./config/iterm/Profiles.json;

    file.".local/bin" = {
      source = ./config/bin;
      recursive = true;
    };

    packages = with pkgs; [
      alacritty
      any-nix-shell
      curl
      deno
      #docker
      #docker-compose
      entr
      # ffmpeg
      fzf
      fd
      git-open
      htop
      httpie
      # imagemagick
      jq
      neovim # due to lua config trouble up here
      nodejs
      #openconnect
      pandoc
      pdfgrep
      ripgrep
      shellcheck
      stow
      tealdeer
      terminal-notifier
      tig
      tree-sitter
      wifi-password
      xsv
      yt-dlp

      yarn
      #nodePackages.gulp
      nodePackages.eslint
      nodePackages.eslint_d
      nodePackages.prettier
      #nodePackages.elasticdump
    ];

    sessionPath = [
      "/opt/homebrew/bin/"
      "$HOME/.local/bin"
      # "~/.cache/cargo"
    ];

    sessionVariables = {
      EDITOR = "nvim";
      GOPATH = "~/src/go";

      CARGO_HOME = "~/.cache/cargo";
      RUSTUP_HOME = "~/.config/rustup";

      MANPAGER = "nvim +Man!";

      XDG_CACHE_HOME  = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME   = "$HOME/.local/share";
      XDG_BIN_HOME    = "$HOME/.local/bin";
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
        afk = "open -a /System/Library/CoreServices/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine";
        cp = "cp -i";
        dl = "cd ~/Downloads";
        du = "du -hs";
        fd = "fd --hidden --follow";
        hm = "home-manager";
        rm = "rm -i";
        ping = "ping -c 5";
        la = "exa -la";
        ls = "exa";
        ll = "exa -l --sort newest";
        lock = "pmset sleepnow";
        nvim = "nvim -p";
        #mv = "mv -i";
        mkdir = "mkdir -p";
        vim = "nvim -p";
        wifiname = "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | grep -e '\\bSSID:' | sed -e 's/^.*SSID: //'";
        ql = "qlmanage -p 2>/dev/null";
      };

      shellAbbrs = {
        "..." = "../..";
        "...." = "../../..";
        "....." = "../../../..";
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
        youtube-dl = "yt-dlp";
        ytdl = "yt-dlp --restrict-filenames -o '%(title)s.%(ext)s'";
      };
      functions = {
        cdf = {
          description = "Change to directory opened by Finder";
          body = ''
            if [ -x /usr/bin/osascript ]
              set -l target (osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)')
              if [ "$target" != "" ]
                cd "$target"; pwd
              else
                echo 'No Finder window found' >&2
              end
            end
          '';
        };
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
        k = {
          description = "Go to knowledge";
          body = ''
            cd ~/src/weiland/knowledge
            vim +CtrlP
          '';
        };
        tree = {
          description = "Tree of directory (aliasing exa)";
          body = ''
            command exa --tree --all $argv
          '';
        };
        lastfm = {
          description = "MKdir and cd into it.";
          body = ''
            set -q RECENTTRACKS || set RECENTTRACKS "/Users/$USER/.local/share/recenttracks.csv"

            if not test -f "$RECENTTRACKS"
              echo "Tracks $RECENTTRACKS file does not exist yet."
              echo 'Perhaps download new file? https://lastfm.ghan.nl/export/'
              return 1
            end

            if not type -q xsv
              echo '"xsv" is not installed'
              return 1
            end

            xsv search -i "$argv" "$RECENTTRACKS" | xsv select utc_time,artist,track,album | xsv table
          '';
        };
        mkd = {
          description = "MKdir and cd into it.";
          body = ''
            mkdir -p $argv; and cd $argv
          '';
        };
        woi_login = {
          description = "Wifi@DB / WifiOnICE login script";
          body = ''
          curl -vk 'https://10.101.64.10/en/' -H 'Host: wifi.bahn.de' -H 'Cookie: csrf=asdf' --data 'login=true&CSRFToken=asdf'
          '';
        };
        zws = {
          description = "Puts a zero width joiner into the clipboard";
          body = "echo -n '\u200D' | pbcopy";
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
