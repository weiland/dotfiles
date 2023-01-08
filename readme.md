# @weiland's nixy dotfiles

## Prerequisites

Install nix:

```command
sh <(curl -L https://nixos.org/nix/install)
```

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

```command
nix flake update
```

then update home-manager

```command
home-manager switch --flake .#pw
```

#### Error handling

Select a previous home-manager generation:

```sh
# list generations
home-manager generations

# copy and paste a generation and append /activate to it i.e.
/nix/store/z0mdj491pf3mhcsv7zgi4c54wj38zxip-home-manager-generation/activate
```


The old way: https://nixos.org/manual/nix/unstable/installation/upgrading.html
