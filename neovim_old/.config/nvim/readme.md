# neovim setup

```sh
mkdir ~/.local/share/nvim/plugged

curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim +PlugInstall +qa
```

Spell checking:

`mkdir -p ~/.local/share/nvim/site/spell`
