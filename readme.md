# @weiland's nixy dotfiles

## Prerequisites

1. have tools installed


## Installation

Install Nix:

```bash
sh <(curl -L https://nixos.org/nix/install)
```

Add nixos unstable channel:

```sh
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update
```

Also add home-manager:

```command
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
```

Backup `nix.conf`:

```command
mv /etc/nix/nix.conf /etc/nix/nix.conf.before_nixdarwin
```

Install homebrew (for nix-darwin) in non-fish shell:

```command
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install _nix-darwin_ (https://github.com/LnL7/nix-darwin):

```command
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer

./result/bin/darwin-installer
```

Then, open a new shell window.

Since we are using a different location for the nix-darwin config, we can remove the `~/.nixpkgs/` directory (with it's `darwin-configuration.nix` file).

Now, clone nix dotfiles:

```command
git clone https://github.com/weiland/dotfiles.git ~/.config/nixpkgs
```

And cd into `~/.config/nixpgs`.


Now, verify configurations at `darwin-configuration.nix` and build the system:

```command
darwin-rebuild switch -I darwin-config=~/.config/nixpkgs/darwin-configuration.nix
```

Open a new shell window.

We can verify that the config is found via

    $ echo $NIX_PATH

The darwin-configuration.nix should be in the `~/.config/nixpkgs/` directory.


## Old Installtion

```sh
# prepare directory
mkdir -p ~/code

# clone
git clone https://github.com/weiland/dotfiles ~/code/dotfiles
cd ~/code/dotfiles

# link dotfiles (using GNU stow)
stow -v -t $HOME fish starship git nvim ssh tmux curl
```

