#!/usr/bin/env sh

DOTFILES_DIR="$HOME/code/dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
  echo "The dotfiles directory ('$DOTFILES_DIR') does not exist."
  exit 1;
fi

create_symlink() {
  local source="$DOTFILES_DIR/$1"
  local target="$HOME/${2:-$1}"

  if [ ! -f "$source" ]; then
    echo "The source file '$source' does not exist."
    if [ ! -d "$source" ]; then
      echo "The source directory '$source' does not exist."
      return
    fi
  fi

  if [ -f "$target" ]; then
    echo "The target file '$target' already exists."
    return
  fi

  if [ -d "$target" ]; then
    echo "The target directory '$target' already exists."
    return
  fi

  ln -s "$source" "$target"
  echo "Linked $source to $target"
}

# create symlinks
create_symlink 'config.fish' '.config/fish/config.fish'
create_symlink 'bin' 'bin'
create_symlink 'ssh_config' '.ssh/config'
create_symlink '.gitconfig'
create_symlink '.gitignore_global'
create_symlink '.tmux.conf'
create_symlink '.vimrc'
create_symlink '.curlrc'
create_symlink '.gemrc'
create_symlink '.agignore'
create_symlink '.npmrc'
create_symlink '.npm-init.js'

create_symlink '.mbsyncrc'
create_symlink '.muttrc'
create_symlink '.notmuch-config'

create_symlink '.netrc'
create_symlink '.spacemacs'
create_symlink '.nvm'
create_symlink '.latexmkrc'

# remove welcome message
if [ ! -f "$HOME/.hushlogin" ]; then
  touch "$HOME/.hushlogin"
fi

# setup mbsync/isync
if [ ! -d "$HOME/.mail" ]; then
  mkdir "$HOME/.mail"
fi
