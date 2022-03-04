# @weiland's dotfiles

## Prerequisites

1. Install nix

2. Install home-manager

```command
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

nix-shell '<home-manager>' -A install

home-manager --version
```

## Usage

Now, clone dotfiles:

    git clone https://github.com/weiland/dotfiles.git ~/.config/nixpkgs

Activate home-manager:

    home-manager switch


### Updates

todo