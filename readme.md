# @weiland's nixy dotfiles


## Old dotfiles

My old dotfiles (managed using gnu `stow` for symlinking) can be found in the
[`dotfiles`](https://github.com/weiland/dotfiles/tree/dotfiles) branch.
## Prerequisites

Install **nix** as _multi-user installation_ (using _fish_):

```fish
sh (curl -L https://nixos.org/nix/install | psub)
```

<details>
<summary>or when using _zsh_/_bash_:</summary>

```bash
sh <(curl -L https://nixos.org/nix/install)
```

</details>

## Usage

In here we use `~/src/weiland/dotfiles` as destination for the dotfiles
and also as working directory.

Now, clone dotfiles:

    mkdir -p ~/src/weiland
    cd ~/src/weiland
    git clone https://github.com/weiland/dotfiles.git ~/src/weiland/dotfiles
    cd dotfiles

Get home-manager using the nix-command feature and flakes.

```command
nix build --no-link .#homeConfigurations.jdoe.activationPackage --extra-experimental-features nix-command --extra-experimental-features flakes
"$(nix path-info ~/src/weiland/dotfiles#homeConfigurations.pw.activationPackage)"/activate
```

Activate home-manager:

    home-manager switch --flake .#pw


## Updating nix and the system

Nix is upgraded via home-manager.

### Upgrade packages

```sh
nix flake update
```

then update home-manager

```bash
home-manager switch --flake .#pw
```

### Cleaning up

Nix garbage collection:

    nix-collect-garbage --delete-older-than 30d

    # or

    nix-collect-garbage -d

    # collect everything (also profile etc)
    sudo nix-collect-garbage -d

Optimise nix store:

    nix-store --optimise -v


#### Error handling

Select a previous home-manager generation:

```sh
# list generations
home-manager generations

# copy and paste a generation and append /activate to it i.e.
/nix/store/z0mdj491pf3mhcsv7zgi4c54wj38zxip-home-manager-generation/activate
```


The old way: https://nixos.org/manual/nix/unstable/installation/upgrading.html
