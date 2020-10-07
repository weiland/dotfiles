# @weiland's dotfiles

## Installtion

```sh
# prepare directory
mkdir -p ~/code

# clone
git clone https://github.com/weiland/dotfiles ~/code/dotfiles
cd ~/code/dotfiles

# link dotfiles (using GNU stow)
stow -v -t $HOME fish neovim tmux
```

