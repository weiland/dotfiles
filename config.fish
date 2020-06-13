set -gx LANG "en_US"
set -gx LC_ALL "en_US.UTF-8"
# vim all the things
set -gx EDITOR vim

# Paths
# set -gx RUBY_HOME /usr/local/opt/ruby/bin
# set -gx GEM_PATH ~/.gem/ruby/2.7.0
# set -gx PATH $PATH $RUBY_HOME $GEM_PATH
set -gx PATH $PATH ~/bin
set -gx PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
set -gx PATH /usr/local/opt/fidnutils/libexec/gnubin $PATH
set -gx GOPATH ~/code/go
#set -gx PATH $PATH /usr/local/opt/gnu-sed/libexec/gnubin

#set -gx PATH $PATH "/Applications/Postgres.app/Contents/Versions/latest/bin"

# set -gx CMAKE_C_COMPILER "gcc-9"

# Shortcuts
alias g="git"


# Scripting
alias stfu="osascript -e 'set volume output muted true'"
# Lock the screen (when going AFK)
alias lock="pmset sleepnow"
alias afk="open -a /System/Library/CoreServices/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine"
alias logout="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
# Reload the shell (i.e. invoke as a login shell)
alias ql="qlmanage -p 2>/dev/null"
# alias qlf='qlmanage -p "$@" > /dev/null'
alias preview='groff -Tps > /tmp/tmp.ps; and open -a Preview /tmp/tmp.ps'
alias wifi="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -s"
alias wifiname='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | grep -e "\\bSSID:" | sed -e "s/^.*SSID: //"'
alias of="open $PWD"
alias redo='sudo \!-1'
alias nowplaying="osascript -e 'tell application \"Spotify\" to name of current track as string'; and echo ' by '; and osascript -e 'tell application \"Spotify\" to artist of current track as string'"
alias we='/Applications/WebStorm.app/Contents/MacOS/webide'
alias ports='sudo lsof -i -n -P | grep TCP'
alias killrails="ps aux | ack 'rails' | head -n1 | awk '{print $2}' | xargs kill"
alias louder='osascript -e "set volume output volume (output volume of (get volume settings) + 5) --100%"'
alias piano='osascript -e "set volume output volume (output volume of (get volume settings) + 5) --100%"'
#alias most_used_commands="history|awk '{print $2}'|awk 'BEGIN {FS=\"|\"} {print $1}'|sort|uniq -c|sort -r"
alias kantine='node ~/rpo/kantine/read.js'
alias pulse='node ~/code/pulse-reader/index.js'
alias dl='cd ~/Downloads'

# Overrides
alias ls 'exa'
alias ll 'exa -l --sort newest'
#alias wget'curl -O'
#alias vi='vim'
#funcsave vi
#alias vim='nvim'
alias ag 'ag --hidden --follow' # search for "hidden" files and follow symlinks
# alias fd 'fd --hidden --follow' # search for "hidden" files and follow symlinks

# Aliasing
#function vim
#  command nvim $argv
#end
alias hi='hicat'
alias :q='exit'
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias cpr='rsync -ah --progress'

# Customizations
alias la='exa -la'
#alias la="ls -laF $colorflag"
alias cppcompile='c++ -std=c++11 -stdlib=libc++'

abbr -a gpg gpg2

# Git stuff
abbr -a ga 'git add'
alias gc='git commit -v'
alias gd='git diff'
abbr -a gl 'git pull'
abbr -a glr 'git pull --rebase'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
abbr -a gp 'git push'
alias gs='git status -sb'
alias gss='git status -sb'
alias gds='git diff --staged'
abbr -a gpf 'git push --force-with-lease'
abbr -a gco 'git checkout'
alias gcm='git checkout master'
abbr -a gcb 'git checkout -b'
abbr -a gap 'git add -p'
alias gac='git add -A; and git commit -m'
alias gcp='git commit -p -v'
alias plr='git push; and hub pull-request -o'

# elixir stuff
alias im="iex -S mix"
alias is="iex -S phoenix.server"
alias ms="mix phoenix.server"
alias mt="mix test.watch"

# docker
alias dcr='docker-compose run'

function d
  cd ~/code/dotfiles
  vim +CtrlP
end

# what did i do today and what did i intend to do?
alias did="vim +'normal Go' +'r!date' ~/did.txt"

alias ytdl="youtube-dl --restrict-filenames -o '%(title)s.%(ext)s'"

# mostly helpful for OpenMP
# abbr -a gcc 'gcc-9'

# Functions

# abbr -a reload 'exec $SHELL -l'
abbr -a reload 'source ~/.config/fish/config.fish'

function tree
	command tree -aFC -L 4 -I 'node_modules|.git' --dirsfirst --sort=name $argv
end
function ftree # flat tree
	command tree -afFiC -L 4 -I 'node_modules|.git' --dirsfirst --sort=name $argv
end

function mkd
	mkdir -p $argv; and cd $argv
end

function cdf --description 'Change to directory opened by Finder'
  if [ -x /usr/bin/osascript ]
    set -l target (osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)')
    if [ "$target" != "" ]
      cd "$target"; pwd
    else
      echo 'No Finder window found' >&2
    end
  end
end

function zws
    echo -n '\u200D' | pbcopy
end

function server
	python -m SimpleHTTPServer&
	sleep 1
	open http://localhost:8000
end

# function v
#     if count $argv > /dev/null
#         nvim $argv
#     else
#         nvim .
#     end
# end

function work
  open -a 'Docker'
  open -a 'PhpStorm'
  open -a 'Slack'
  open -a 'Spark'
  open -a 'Google Chrome'
  cd ~/rpo/interred_deployment/
  clear
end

function other
  open -a 'Messages'
  open -a 'Reeder'
  open /Applications/Tweetbot.localized/Tweetbot.app
  open -a 'Spotify'
end

#function ir
#  #cd ~/rpo/interred_deployment/;
#  cd ~/rpo/interred_deployment/opt/InterRed/gera/data/webserver/global/php_includes/templates/; and
#  osascript -e 'tell application "System Events" to key code 17 using command down'; and sleep 1; and # new tab
#  cd ~/rpo/docker/; and
#  docker-compose up;
#  osascript -e 'tell application "System Events" to key code 2 using command down'; and sleep 1; and # veritcal split
#end

function rr
  # Activate DrRacket
  osascript -e 'activate application "DrRacket"';
  sleep 1
  # CMD + Shift + E (Revert File in DrRacket)
  osascript -e 'tell application "System Events" to key code 14 using {command down, shift down}';
  sleep 1
  # Run current file (CMD + R)
  osascript -e 'tell application "System Events" to key code 15 using command down';
end

function tud
  cd "$HOME/Documents/TU Darmstadt"
end

function tus
  cd "$HOME/Documents/TU Darmstadt/studium/"
  vim summary.md
  sleep 1
  git add -p summary.md
  sleep 1
  git commit
end

function wr
  watchman-make -p $argv --run "racket $argv"
end

function peek
  tmux split-window -p 33 "$EDITOR" "$0"
end

function toggle-darkmode
  osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to not dark mode'
end

function iswoi
  test (wifiname) = "WIFIonICE" && echo "is WIFIonICE"
end

function woi_usage
  curl -s 'http://login.wifionice.de/usage_info/'
end

function woi_login
  curl 'http://login.wifionice.de/en/' -H 'Cookie: csrf=asdf' --data 'login=true&CSRFToken=asdf&connect='
end

function woi_logout
  curl 'http://www.wifionice.de/de/' -H 'Cookie: csrf=jkl' --data 'logout=true&CSRFToken=jkl'
end

function cap
 curl -s 'http://captive.apple.com'
end

function _has_internet
 cap | grep -q "<BODY>Success"
end

function has_internet
 _has_internet && echo "true" || echo "false"
end

function woi_left
  echo (woi_usage)"*100" | math | awk '{printf("%d\n",$1 + 0.5)}'
end

function sncf_login
  curl 'https://wifi.sncf/router/api/connection/activate/auto' -H 'Pragma: no-cache' -H 'Origin: https://wifi.sncf' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en,en-US;q=0.9,de;q=0.8,fr;q=0.7' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36' -H 'content-type: application/json' -H 'accept: application/json' -H 'Cache-Control: no-cache' -H 'Referer: https://wifi.sncf/en/internet/bot' -H 'Cookie: iob-context=f9vk6j; tracking-id=667b21ab-5f87-491b-ada7-9b2fa55ef7b4; io=ri3dEpOFq4J_m8VjAAAg; x-vsc-correlation-id=fbb43bed-4558-47f0-b610-8f4afda29cbe; gdpr-preferences={%22tracking%22:true%2C%22error%22:true%2C%22feedback%22:true}' -H 'Connection: keep-alive' -H 'DNT: 1' --data-binary '{}' --compressed
end

function safari_reload
  osascript -e 'tell application "Safari"' -e 'tell its first document' -e 'set its URL to (get its URL)' -e 'end tell' -e 'activate' -e 'end tell'
end

function k
  cd ~/code/knowledge
  vim +CtrlP
end

function kk
  vim ~/code/knowledge/$argv.md
end

function node-project
  git init
  npx license (npm get init.license) -o (npm get init.author.name) > LICENSE
  npx gitignore node
  # run for external public projects
  #npx covgen "$(npm get init.author.email)"
  npm init -y
  touch readme.md
  echo '#' (basename (pwd))\n >> readme.md
  git add -A
  git commit -m "Initial commit :octocat:"
  #hub create -p && git push
end

function study
  killall Messages 2>/dev/null
  killall Mail 2>/dev/null
  killall Things3 2>/dev/null
  killall Docker 2>/dev/null
  killall Spotify 2>/dev/null
  killall Notes 2>/dev/null
  tu
  #exit
end

function arm
  scp -q $argv arm:tmp/$argv; and ssh arm "source .bash_profile && arm tmp/$argv"
end

function armpi
  scp -q $argv pi:tmp/$argv; and ssh pi '/bin/bash -c "source .bash_profile && arm tmp/$argv"'
end

function hours
  open ~/Library/Mobile\ Documents/com~apple~CloudDocs/Documents/RP/StundenPascal(date +"%m").numbers
  # else cp Preset
end

# Univerisity stuff
function sim
  $HOME/Library/Mobile\ Documents/com~apple~CloudDocs/Documents/TU\ Darmstadt/Digitaltechnik/SystemVerilog/bin/sim.mac $argv
end

function synth
  $HOME/Library/Mobile\ Documents/com~apple~CloudDocs/Documents/TU\ Darmstadt/Digitaltechnik/SystemVerilog/bin/synth.sh $argv
end

# include grc to colorize generic command output
# source (brew --prefix)/etc/grc.fish

alias ping="ping -c 5"
alias nmap="nmap"

# enable fish vi key bindings
#fish_vi_key_bindings

# ASDF version manager
#source ~/.asdf/asdf.fish
# source ~/.asdf/asdf.fish

#thefuck --alias | source
# set -g fish_user_paths "/usr/local/opt/node@8/bin" $fish_user_paths
#set -g fish_user_paths "/usr/local/opt/sphinx-doc/bin" $fish_user_paths

# Startup: Add all identities stored in keychain
# /usr/bin/ssh-add -A
#set -g fish_user_paths "/usr/local/opt/llvm/bin" $fish_user_paths
# set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

# rbenv ruby
status --is-interactive; and source (rbenv init -|psub)

# set -x fish_user_paths $fish_user_paths ~/.rbenv/shims

# set -x fish_user_paths $fish_user_paths $RUBY_HOME

# attempts to fix rbenv installations
# set RUBY_CONFIGURE_OPTS --with-openssl-dir=(brew --prefix openssl@1.1) --with-readline-dir=(brew --prefix readline)
# set RUBY_CONFIGURE_OPTS --with-readline-dir=(brew --prefix readline)
# set RUBY_CONFIGURE_OPTS --with-openssl-dir=(brew --prefix openssl@1.1)
# export RUBY_CONFIGURE_OPTS="--with-openssl-dir="(brew --prefix openssl@1.1)" --with-readline-dir="(brew --prefix readline)

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# eval /usr/local/Caskroom/miniconda/base/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

function activate_conda
  eval /usr/local/Caskroom/miniconda/base/bin/conda "shell.fish" "hook" $argv | source
end

# sh /Users/pw/.nix-profile/etc/profile.d/nix.sh
