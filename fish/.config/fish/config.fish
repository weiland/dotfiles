set -gx LANG "en_GB"
set -gx LC_ALL "en_GB.UTF-8"
set -gx EDITOR vim

set -gx VOLTA_HOME ~/.local/share/volta

fish_add_path ~/.local/bin
fish_add_path -ga $VOLTA_HOME/bin
fish_add_path -a /opt/homebrew/sbin

#set -gx FZF_DEFAULT_COMMAND 'rg --files --follow --hidden'

set -gx export GPG_TTY (tty)

set fish_greeting

# Scripting
alias ql "qlmanage -p 2>/dev/null"

alias stfu "osascript -e 'set volume output muted true'"
alias lock "pmset sleepnow"
alias afk "open -a /System/Library/CoreServices/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine"
alias logout "/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
alias wifi "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -s"
alias wifiname '/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | grep -e "\\bSSID:" | sed -e "s/^.*SSID: //"'
alias nowplaying "osascript -e 'tell application \"Spotify\" to name of current track as string'; and echo ' by '; and osascript -e 'tell application \"Spotify\" to artist of current track as string'"
alias ports 'sudo lsof -i -n -P | grep TCP'
alias forte 'osascript -e "set volume output volume (output volume of (get volume settings) + 5) --100%"'
alias piano 'osascript -e "set volume output volume (output volume of (get volume settings) - 5) --100%"'
alias dl 'cd ~/Downloads'

# Overrides
if which exa > /dev/null 2>&1
  alias ls 'exa'
  alias ll 'exa -l --sort newest'
  alias la 'exa -la'
end
alias fd 'fd --hidden --follow' # search for "hidden" files and follow symlinks
if which nvim > /dev/null 2>&1
  alias vim 'nvim'
end

alias ping "ping -c 5"
alias ... "cd ../.."
alias .... "cd ../../.."
alias ..... "cd ../../../.."

alias cpr 'rsync -ah --progress'

#abbr -a npx 'npm exec --'

# Git stuff
abbr -a ga 'git add'
abbr gc 'git commit -v'
abbr gd 'git diff'
abbr -a gl 'git pull'
abbr -a glr 'git pull --rebase'
abbr glog "git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
abbr -a gp 'git push'
abbr gs 'git status -sb'
alias gss 'git status -sb'
abbr gds 'git diff --staged'
abbr -a gpf 'git push --force-with-lease'
abbr -a gco 'git checkout'
abbr gcm 'git checkout main'
abbr -a gcb 'git checkout -b'
abbr -a gap 'git add -p'
abbr gcp 'git commit -p -v'
abbr plr 'git push; and hub pull-request -o'



abbr ytdl "youtube-dl --restrict-filenames -o '%(title)s.%(ext)s'"


abbr -a reload 'source ~/.config/fish/config.fish'

function tree
  command exa --tree --all $argv
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

function zws --description 'Puts a zero width joiner into the clipboard'
    echo -n '\u200D' | pbcopy
end

function peek
  tmux split-window -p 33 "$EDITOR" "$0"
end

function toggle-darkmode
  osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to not dark mode'
end

function iswad
  test (wifiname) = 'WIFI@DB' && echo 'is WIFI@DB'
end

function iswoi
  test (wifiname) = "WIFIonICE" && echo "is WIFIonICE"
end

function woi_usage
  curl -s 'http://login.wifionice.de/usage_info/'
end

function woi_login
  curl -v 'http://10.101.64.10/en/' -H 'Cookie: csrf=asdf' --data 'login=true&CSRFToken=asdf'
end

function woi_login_with_domain
  curl 'http://login.wifionice.de/en/' -H 'Cookie: csrf=asdf' --data 'login=true&CSRFToken=asdf&connect='
end

function wl
  open 'http://10.101.64.10/en/'
end

function woi_logout
  curl 'http://login.wifionice.de/de/' -H 'Cookie: csrf=jkl' --data 'logout=true&CSRFToken=jkl'
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

function woi_used
  echo (woi_usage)"*100" | math | awk '{printf("%d\n",$1 + 0.5)}'
end

function woi_left
  echo "100-"(woi_used) | math
end

function sncf_login
  curl 'https://wifi.sncf/router/api/connection/activate/auto' -H 'Pragma: no-cache' -H 'Origin: https://wifi.sncf' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en,en-US;q=0.9,de;q=0.8,fr;q=0.7' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36' -H 'content-type: application/json' -H 'accept: application/json' -H 'Cache-Control: no-cache' -H 'Referer: https://wifi.sncf/en/internet/bot' -H 'Cookie: iob-context=f9vk6j; tracking-id=667b21ab-5f87-491b-ada7-9b2fa55ef7b4; io=ri3dEpOFq4J_m8VjAAAg; x-vsc-correlation-id=fbb43bed-4558-47f0-b610-8f4afda29cbe; gdpr-preferences={%22tracking%22:true%2C%22error%22:true%2C%22feedback%22:true}' -H 'Connection: keep-alive' -H 'DNT: 1' --data-binary '{}' --compressed
end

function safari_reload
  osascript -e 'tell application "Safari"' -e 'tell its first document' -e 'set its URL to (get its URL)' -e 'end tell' -e 'activate' -e 'end tell'
end

function k
  cd ~/src/github.com/weiland/knowledge
  vim +CtrlP
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
  #exit
end

function activate_conda
  eval /opt/homebrew/Caskroom/miniforge/base/bin/conda "shell.fish" "hook" $argv | source
end

# use starship Prompt
if command -v starship > /dev/null
  starship init fish | source
end

if command -v zoxide > /dev/null
  zoxide init fish | source
end

# sh /Users/pw/.nix-profile/etc/profile.d/nix.sh
#fish_vi_key_bindings

