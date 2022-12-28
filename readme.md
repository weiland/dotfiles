# @weiland's dotfiles

## Prerequisites

Install nix

## Usage

In here we use `~/src/weiland/dotfiles` as destination for the dotfiles
directory.

Now, clone dotfiles:

    git clone https://github.com/weiland/dotfiles.git ~/src/weiland/dotfiles

Activate home-manager:

    home-manager switch --flake ~/src/weiland/dotfiles#pw


### Updates

#### Upgrading Nix

```
sudo -i sh -c 'nix-channel --update && nix-env -iA nixpkgs.nix && launchctl remove org.nixos.nix-daemon && launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist'
```

(Source: https://nixos.org/manual/nix/unstable/installation/upgrading.html)