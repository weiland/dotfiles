{ config, pkgs, lib, ... }:

{
  # imports = [ <home-manager/nix-darwin> ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # environment.systemPackages = with pkgs; [ ]; # most packages will be installed via home-manager

  # users.users.pw = {
  #   name = "pw";
  #   home = "/Users/pw";
  #   shell = pkgs.fish;
  # };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin-configuration.nix
  environment.darwinConfig = "$HOME/.config/nixpkgs/darwin-configuration.nix";

  nixpkgs.system = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;
  # nix.package = pkgs.nixFlakes; # for flakes
  # nix.extraOptions = ''
#extra-platforms = aarch64-darwin x86_64-darwin
#experimental-features = nix-command flakes
#'';

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = false;  # default shell on catalina
  #programs.fish.enable = true; # my default shell

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  networking.computerName = "hopper";
  networking.hostName = "hopper";
  networking.localHostName = "hopper";
  # networking.dns = ["1.1.1.1"];

  # Set default shell to fish.
  # https://shaunsingh.github.io/nix-darwin-dotfiles/#orgb26c90e
  #system.activationScripts.postActivation.text = ''
  #  chsh -s ${lib.getBin pkgs.fish}/bin/fish ${config.users.users.pw.name}
  #'';

  # TODO: handle Dock here

  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = "0.0";
      autohide-time-modifier = "0.0";
      orientation = "left";
      showhidden = true;
      show-recents = false;
      static-only = true;
      tilesize = 36;
    };
    finder = {
      _FXShowPosixPathInTitle = true;
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      FXDefaultSearchScope = "SCcf";
      FXPreferredViewStyle = "Nlsv";
      ShowPathbar = true;
      ShowStatusBar = true;
    };
    loginwindow = {
      GuestEnabled = false;
      LoginwindowText = "I do have your cookies!!!";
      SHOWFULLNAME = true;
    };
    LaunchServices = { LSQuarantine = false; };
    #messages = {
    #  EmojiReplacement = 0;
    #};
    NSGlobalDomain = {
      # AppleHighlightColor = "0.764700 0.976500 0.568600"; # or jade: "0.764700 0.976500 0.568600"
      AppleKeyboardUIMode = 3;
      AppleMeasurementUnits = "Centimeters";
      AppleMetricUnits = 1;
      ApplePressAndHoldEnabled = false;
      KeyRepeat = 2;
      InitialKeyRepeat = 25;
    };
    # Requires the directory to be existing if not /tmp. (Use system.activationScripts.postUserActivation for this.)
    screencapture = {
      disable-shadow = true;
      location = "/tmp";
    };
    smb.NetBIOSName = "Hopper";
    trackpad = {
      Clicking = true;
      TrackpadRightClick = true;
      TrackpadThreeFingerDrag = true;
    };
  };

  time.timeZone = "Europe/Berlin";

  homebrew = {
    enable = true;
    autoUpdate = true;

    brews = [
      "imagesnap"
    ];

    casks = [
      "discord"
      "firefox"
      "iterm2"
      "jumpcut"
      "shiftit"
    ];

    masApps = {
      bear = 1091189122;
      fantastical = 975937182;
      reeder = 1529448980;
      xcode = 497799835;
    };
  };

  # Import Home Manager configuration.
  #home-manager = {
  #  useUserPackages = true;
  #  useGlobalPkgs = true;
  #  users.pw = import ./home.nix;
  #};
}
