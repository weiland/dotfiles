{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-small.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    nixpkgs-neovim.url = "github:nixos/nixpkgs/5d6f45172279af8822d44a4d748de3e3704a770b";
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs-neovim";
    };
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "aarch64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: { };
      flake = {
        homeConfigurations.pw = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = import inputs.nixpkgs {
            system = "aarch64-darwin";
            overlays = [ inputs.neovim-nightly-overlay.overlay (final: prev: {
                inherit (inputs.nixos-small.legacyPackages.${final.stdenv.system}) fish;
                }) ];
          };

          modules = [
            ./config/home
            ./config/neovim
          ];
        };
      };
    };
}
