# @weiland's nixy dotfiles

## Prerequisites

Install nix:

```command
sh <(curl -L https://nixos.org/nix/install)
```

## Usage

In here we use `~/src/weiland/dotfiles` as destination for the dotfiles
directory.

Now, clone dotfiles:

    git clone https://github.com/weiland/dotfiles.git ~/src/weiland/dotfiles

Activate home-manager:

    home-manager switch --flake ~/src/weiland/dotfiles#pw


#### Upgrading Nix

Nix is upgraded via home-manager.


The old way: https://nixos.org/manual/nix/unstable/installation/upgrading.html