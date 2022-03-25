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

      DOCKER_SCAN_SUGGEST = false;

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
        identity = "! git config user.name \"$(git config user.$1.name)\"; git config user.email \"$(git config user.$1.email)\"; git config user.signingkey \"$(git config user.$1.signingkey)\"; :";
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
        difftool.prompt = false;
        merge = {
          log = true;
          conflictStyle = "zdiff3";
        };
        push = {
          default = "simple";
        };
        pull = {
          ff = "only";
        };
        remote.origin = {
          prune = true;
        };
        rerere = {
          enabled = 1;
        };
        status = {
          showUntrackedFiles = "normal";
        };
        init = {
          defaultBranch = "main";
        };
        user.gmail = {
          email = "pasweiland@gmail.com";
          signingkey = "182E88B5";
        };
        url."git@github.com:" = {
          insteadOf = "https://github.com/";
          pushInsteadOf = "https://github.com/";
        };
      };
      ignores = [
        ".DS_Store"
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
        battery = {
          full_symbol = "🔋";
          charging_symbol = "⚡️";
          discharging_symbol = "💀";
        };
        command_timeout = 100;
        directory = {
          truncation_length = 5;
          truncation_symbol = "…/";
        };
        git_status.conflicted = "🤯";
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

      baseIndex = 1;
      clock24 = true;
      escapeTime = 0;
      historyLimit = 133742;
      keyMode = "emacs"; # the vi mode does not yet feel right

      prefix = "C-s";
      newSession = true;
      terminal = "screen-256color";

      extraConfig = ''
        # Start window numbering at 1 (it hurts but it's faster to type)
        set -g base-index 1
        set -g pane-base-index 0
        set -g renumber-windows on
        set-window-option -g pane-base-index 1

        set-window-option -g automatic-rename on
        set -g set-titles on
        set -g set-titles-string '#T'

        # basic
        set -g status-keys "emacs" # the vim emulation is not as good

        # Switche between panes (without prefix key)
        # See: https://github.com/christoomey/vim-tmux-navigator
        is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
            | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
        bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
        bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
        bind-key -n 'M-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
        bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
        bind-key -n 'C-\' if-shell "$is_vim" 'send-keys C-\\\\'  'select-pane -l'

        bind-key -T copy-mode-vi 'C-h' select-pane -L
        bind-key -T copy-mode-vi 'C-j' select-pane -D
        bind-key -T copy-mode-vi 'C-k' select-pane -U
        bind-key -T copy-mode-vi 'C-l' select-pane -R
        bind-key -T copy-mode-vi 'C-\' select-pane -l

        # re-bind existing new-window shortcut to open current directory
        bind c new-window -c '#{pane_current_path}'

        # reload tmux config
        bind-key r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded"

        # kill it with fire
        bind Q send-keys "tmux kill-server" Enter

        bind-key s split-window -v -c '#{pane_current_path}'
        bind-key v split-window -h -c '#{pane_current_path}'

        # not so often used, but good
        bind-key - split-window -fv -c '#{pane_current_path}'
        bind-key \\ split-window -fh -c '#{pane_current_path}'

        # modify window size with Shift and Arrow keys
        bind -n S-Left resize-pane -L 2
        bind -n S-Right resize-pane -R 2
        bind -n S-Down resize-pane -D 1
        bind -n S-Up resize-pane -U 1

        # resize panes size with larger sizes using Shift and Arrow keys
        bind -n C-Left resize-pane -L 10
        bind -n C-Right resize-pane -R 10
        bind -n C-Down resize-pane -D 5
        bind -n C-Up resize-pane -U 5

        bind-key -r < swap-window -t -1
        bind-key -r > swap-window -t +1

        # break pane out detached (move it to new window in the background)
        bind b break-pane -d

        # bind C-j split-window -v "tmux list-sessions | sed -E 's/:.*$//' | grep -v \"^$(tmux display-message -p '#S')\$\" | fzf --reverse | xargs tmux switch-client -t"
        # jump to another session/window/pane (or just see what's going on)
        bind C-j choose-tree

        # toggle mouse mode
        # bind-key m setw mouse

        # improve scrolling and mouse support
        set -g mouse on
        set -g terminal-overrides 'xterm*:smcup@:rmcup@' # does the same as mouse on
        bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'copy-mode -e; send-keys -M'"

        # Statusbar
        set -g status on
        set -g status-position top
        set -g status-justify centre # center window list for clarity
        set -g status-bg colour235 #base02
        set -g status-fg '#eeeeee'
        # set -g status-attr dim #invalid TODO

        set -g status-left-length 75
        set -g status-left "[#{session_name}] #[fg=green]#h  #[fg=brightblue]#(dig +short myip.opendns.com @resolver1.opendns.com) #[fg=yellow]#(ifconfig en0 | grep 'inet ' | awk '{print \"en0 \" $2}') #(ifconfig en1 | grep 'inet ' | awk '{print \"en1 \" $2}') #(ifconfig en3 | grep 'inet ' | awk '{print \"en3 \" $2}') #[fg=red]#(ifconfig tun0 | grep 'inet ' | awk '{print \"vpn \" $2}') #[fg=green]#(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk -F': ' '/ SSID/{print $2}') "

        set-window-option -g clock-mode-style 24

        set -g status-right-length 75
        # set -g status-right "#[fg=blue]#S #I:#P #[fg=yellow]: %d %b %Y #[fg=green]: %l:%M %p : #(date -u | awk '{print $4}') :"
        # set -g status-right "#{?client_prefix,PREFIX ,}#{?window_zoomed_flag,🔍, } #{weather} #(battery -t) %a %d. %b  %H:%M"
        # set-option -g @tmux-weather-location "Darmstadt"


        set-option -g window-status-format '#{window_index}:#{window_name}'
        set-option -g window-status-current-format '[#{window_index}:#{window_name}]'

        # window status
        set-window-option -g window-status-style fg=brightblue #base0
        set-window-option -g window-status-style bg=colour236
        set-window-option -g window-status-style dim

        set-window-option -g window-status-current-style fg=brightred #orange
        set-window-option -g window-status-current-style bg=colour236
        set-window-option -g window-status-current-style bright

        # using clipboard and scrolling
        # Use vim keybindings in copy mode
        setw -g mode-keys vi

        # Set that stupid Esc-Wait off, so VI works again
        set-option -sg escape-time 0

        # set -g default-command 'fish' # is not necessary

        # Setup 'v' to begin selection as in Vim
        bind-key -T copy-mode-vi 'v' send -X begin-selection
        bind-key -T copy-mode-vi 'y' send -X copy-pipe-and-cancel "pbcopy"
        bind-key -T copy-mode-vi 'V' send -X select-line

        # Update default binding of `Enter` to also use copy-pipe
        # bind-key -T copy-mode-vi Enter copy-pipe "reattach-to-user-namespace pbcopy"

      '';
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

  services = {
    spotifyd = {
      enable = false;
      settings = {
        global = {
          username = "passj";
          # password_cmd = "security find-generic-password -s spotifyd -w";
          use_keyring = true; # use macos keychain instead of command above
          use_mpris = false; # false for headless
          backend = "portaudio";
          volume_controller = "softvol";
          device_name = "hopper";
          device_type = "computer";
          # The audio bitrate. 96, 160 or 320 kbit/s
          bitrate = 160;
          no_audio_cache = true;
          volume_normalisation = true;
          zeroconf_port = 1234;
        };
      };
    };

  };

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
