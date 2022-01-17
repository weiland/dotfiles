{ config, pkgs, ... }:

{
  # use home-manager
  # imports = [ <home-manager/nix-darwin> ];

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # macOS specific packages
  environment.systemPackages =
    [
      pkgs.bat
      pkgs.fd
      pkgs.jq
      pkgs.ripgrep
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Enable fish TODO(pascal): Can we skip this here if already done in home.nix?
  programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
