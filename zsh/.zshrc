#!/usr/bin/env zsh

[[ -o interactive ]] || return

#######################################################
# EXPORTS
#######################################################

HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt share_history
setopt inc_append_history

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

stty -ixon

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select
autoload -Uz compinit && compinit

if command -v nvim &>/dev/null; then
  export EDITOR=nvim
  export VISUAL=nvim
else
  export EDITOR=vim
  export VISUAL=vim
fi

export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'

if command -v rg &>/dev/null; then
  alias grep='rg'
else
  alias grep='/usr/bin/grep --color=auto'
fi

export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

#######################################################
# ALIASES
#######################################################

case "$(uname)" in
  Darwin)
    alias alert="osascript -e 'display notification \"Command completed\" with title \"Terminal\"'"
    ;;
  *)
    alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
    ;;
esac

alias ebrc='edit ~/.zshrc'
alias da='date "+%Y-%m-%d %A %T %Z"'

if command -v nvim &>/dev/null; then
  alias vi='nvim'
  alias vim='nvim'
fi

alias cp='cp -i'
alias mv='mv -i'
if command -v trash &>/dev/null; then
  alias rm='trash -v'
else
  alias rm='rm -i'
fi
alias mkdir='mkdir -p'
alias ps='ps auxf'
alias less='less -R'
alias cls='clear'
alias multitail='multitail --no-repeat -c'
alias freshclam='sudo freshclam'

alias home='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias bd='cd "$OLDPWD"'
alias rmd='/bin/rm -rf --verbose '

if command -v eza &>/dev/null; then
  alias ls='eza -aF --color=always --group-directories-first'
  alias la='eza -alhF --color=always --group-directories-first'
  alias ll='eza -lF --color=always --group-directories-first'
  alias tree='eza -aF --color=always --group-directories-first --tree'
  alias treed='eza -aF --color=always --group-directories-first --tree --level=2'
elif command -v gls &>/dev/null; then
  alias ls='gls -aFh --color=always'
  alias la='gls -Alh'
  alias lx='gls -lXBh'
  alias lk='gls -lSrh'
  alias lc='gls -ltcrh'
  alias lu='gls -lturh'
  alias lr='gls -lRh'
  alias lt='gls -ltrh'
  alias lm='gls -alh |more'
  alias lw='gls -xAh'
  alias ll='gls -Fls'
  alias labc='gls -lap'
  alias lla='gls -Al'
  alias las='gls -A'
  alias lls='gls -l'
  alias lf="gls -l | grep -v '^d'"
  alias ldir="gls -l | grep '^d'"
  alias tree='tree -CAhF --dirsfirst'
  alias treed='tree -CAFd'
else
  case "$(uname)" in
    Darwin)
      alias ls='ls -aFhG'
      alias la='ls -AlhG'
      alias ll='ls -lF'
      alias lx='ls -lXBh'
      alias lk='ls -lSrh'
      alias lc='ls -ltcrh'
      alias lu='ls -lturh'
      alias lr='ls -lRh'
      alias lt='ls -ltrh'
      alias lm='ls -alhG |more'
      alias lw='ls -xAhG'
      alias labc='ls -lap'
      alias lla='ls -AlG'
      alias las='ls -AG'
      alias lls='ls -lG'
      alias lf="ls -lG | grep -v '^d'"
      alias ldir="ls -lG | grep '^d'"
      ;;
    *)
      alias ls='ls -aFh --color=always'
      alias la='ls -Alh'
      alias lx='ls -lXBh'
      alias lk='ls -lSrh'
      alias lc='ls -ltcrh'
      alias lu='ls -lturh'
      alias lr='ls -lRh'
      alias lt='ls -ltrh'
      alias lm='ls -alh |more'
      alias lw='ls -xAh'
      alias ll='ls -Fls'
      alias labc='ls -lap'
      alias lf="ls -l | grep -v '^d'"
      alias ldir="ls -l | grep '^d'"
      alias lla='ls -Al'
      alias las='ls -A'
      alias lls='ls -l'
      alias tree='tree -CAhF --dirsfirst'
      alias treed='tree -CAFd'
      ;;
  esac
fi

alias mx='chmod a+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'

alias h="history | grep "
alias p="ps aux | grep "
alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"
alias f="find . | grep "
alias countfiles="for t in files links directories; do echo \`find . -type \${t:0:1} | wc -l\` \$t; done 2> /dev/null"
alias checkcommand="type -t"

case "$(uname)" in
  Darwin) alias openports='lsof -iTCP -sTCP:LISTEN -P' ;;
  *)      alias openports='netstat -nape --inet' ;;
esac

alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'

alias diskspace="du -S | sort -n -r |more"
case "$(uname)" in
  Darwin)
    alias folders='du -h -d 1'
    alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
    alias mountedinfo='df -h'
    ;;
  *)
    alias folders='du -h --max-depth=1'
    alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
    alias mountedinfo='df -hT'
    ;;
esac

alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

alias logs="sudo find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"
alias sha1='openssl sha1'
alias docker-clean='docker container prune -f && docker image prune -f && docker network prune -f && docker volume prune -f'
alias gitamendpush="git commit -a --amend --no-edit && git forcepush"
alias npmupdateall="npx npm-check-updates -u"
alias kssh="kitty +kitten ssh"

#######################################################
# FUNCTIONS
#######################################################

extract() {
  for archive in "$@"; do
    if [ -f "$archive" ]; then
      case $archive in
        *.tar.bz2) tar xvjf $archive ;;
        *.tar.gz)  tar xvzf $archive ;;
        *.bz2)     bunzip2 $archive ;;
        *.rar)     rar x $archive ;;
        *.gz)      gunzip $archive ;;
        *.tar)     tar xvf $archive ;;
        *.tbz2)    tar xvjf $archive ;;
        *.tgz)     tar xvzf $archive ;;
        *.zip)     unzip $archive ;;
        *.Z)       uncompress $archive ;;
        *.7z)      7z x $archive ;;
        *)         echo "don't know how to extract '$archive'..." ;;
      esac
    else
      echo "'$archive' is not a valid file!"
    fi
  done
}

ftext() {
  grep -iIHrn --color=always "$1" . | less -r
}

cpp() {
  set -e
  strace -q -ewrite cp -- "${1}" "${2}" 2>&1 |
    awk '{
        count += $NF
        if (count % 10 == 0) {
            percent = count / total_size * 100
            printf "%3d%% [", percent
            for (i=0;i<=percent;i++) printf "="
            printf ">"
            for (i=percent;i<100;i++) printf " "
            printf "]\r"
        }
    }
    END { print "" }' total_size="$(stat -c '%s' "${1}")" count=0
}

cpg() {
  if [ -d "$2" ]; then
    cp "$1" "$2" && cd "$2"
  else
    cp "$1" "$2"
  fi
}

mvg() {
  if [ -d "$2" ]; then
    mv "$1" "$2" && cd "$2"
  else
    mv "$1" "$2"
  fi
}

mkdirg() {
  mkdir -p "$1" && cd "$1"
}

up() {
  local d=""
  limit=$1
  for ((i = 1; i <= limit; i++)); do
    d=$d/..
  done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd $d
}

chpwd() {
  ls
}

pwdtail() {
  pwd | awk -F/ '{nlast = NF -1;print $nlast"/"$NF}'
}

distribution() {
  local dtype="unknown"
  if [ -r /etc/os-release ]; then
    source /etc/os-release
    case $ID in
      fedora|rhel|centos)          dtype="redhat" ;;
      sles|opensuse*)              dtype="suse" ;;
      ubuntu|debian)               dtype="debian" ;;
      gentoo)                      dtype="gentoo" ;;
      arch|manjaro)                dtype="arch" ;;
      slackware)                   dtype="slackware" ;;
      *)
        if [ -n "$ID_LIKE" ]; then
          case $ID_LIKE in
            *fedora*|*rhel*|*centos*) dtype="redhat" ;;
            *sles*|*opensuse*)        dtype="suse" ;;
            *ubuntu*|*debian*)        dtype="debian" ;;
            *gentoo*)                 dtype="gentoo" ;;
            *arch*)                   dtype="arch" ;;
            *slackware*)              dtype="slackware" ;;
          esac
        fi
        ;;
    esac
  fi
  echo $dtype
}

DISTRIBUTION=$(distribution)
if command -v bat &>/dev/null; then
  alias cat='bat'
elif command -v batcat &>/dev/null; then
  alias cat='batcat'
fi

ver() {
  local dtype
  dtype=$(distribution)
  case $dtype in
    redhat)   [ -s /etc/redhat-release ] && cat /etc/redhat-release || cat /etc/issue; uname -a ;;
    suse)     cat /etc/SuSE-release ;;
    debian)   lsb_release -a ;;
    gentoo)   cat /etc/gentoo-release ;;
    arch)     cat /etc/os-release ;;
    slackware) cat /etc/slackware-version ;;
    *)
      [ -s /etc/issue ] && cat /etc/issue || echo "Error: Unknown distribution"
      ;;
  esac
}

install_bashrc_support() {
  local dtype
  dtype=$(distribution)
  case $dtype in
    redhat)   sudo yum install multitail tree zoxide trash-cli fzf bash-completion fastfetch ;;
    suse)     sudo zypper install multitail tree zoxide trash-cli fzf bash-completion fastfetch ;;
    debian)
      sudo apt-get install multitail tree zoxide trash-cli fzf bash-completion
      FASTFETCH_URL=$(curl -s https://api.github.com/repos/fastfetch-cli/fastfetch/releases/latest | grep "browser_download_url.*linux-amd64.deb" | cut -d '"' -f 4)
      curl -sL $FASTFETCH_URL -o /tmp/fastfetch_latest_amd64.deb
      sudo apt-get install /tmp/fastfetch_latest_amd64.deb
      ;;
    arch)     sudo paru multitail tree zoxide trash-cli fzf bash-completion fastfetch ;;
    slackware) echo "No install support for Slackware" ;;
    *)        echo "Unknown distribution" ;;
  esac
}

alias whatismyip="whatsmyip"
whatsmyip() {
  case "$(uname)" in
    Darwin)
      echo -n "Internal IP: "
      ifconfig en0 | grep "inet " | awk '{print $2}'
      ;;
    *)
      if command -v ip &>/dev/null; then
        echo -n "Internal IP: "
        ip addr show wlan0 | grep "inet " | awk '{print $2}' | cut -d/ -f1
      else
        echo -n "Internal IP: "
        ifconfig wlan0 | grep "inet " | awk '{print $2}'
      fi
      ;;
  esac
  echo -n "External IP: "
  curl -s ifconfig.me
}

apachelog() {
  if [ -f /etc/httpd/conf/httpd.conf ]; then
    cd /var/log/httpd && ls -xAh && multitail --no-repeat -c -s 2 /var/log/httpd/*_log
  else
    cd /var/log/apache2 && ls -xAh && multitail --no-repeat -c -s 2 /var/log/apache2/*.log
  fi
}

apacheconfig() {
  if [ -f /etc/httpd/conf/httpd.conf ]; then
    sedit /etc/httpd/conf/httpd.conf
  elif [ -f /etc/apache2/apache2.conf ]; then
    sedit /etc/apache2/apache2.conf
  else
    echo "Error: Apache config file could not be found."
    echo "Searching for possible locations:"
    sudo updatedb && locate httpd.conf && locate apache2.conf
  fi
}

phpconfig() {
  if [ -f /etc/php.ini ]; then
    sedit /etc/php.ini
  elif [ -f /etc/php/php.ini ]; then
    sedit /etc/php/php.ini
  elif [ -f /etc/php5/php.ini ]; then
    sedit /etc/php5/php.ini
  elif [ -f /usr/bin/php5/bin/php.ini ]; then
    sedit /usr/bin/php5/bin/php.ini
  elif [ -f /etc/php5/apache2/php.ini ]; then
    sedit /etc/php5/apache2/php.ini
  else
    echo "Error: php.ini file could not be found."
    echo "Searching for possible locations:"
    sudo updatedb && locate php.ini
  fi
}

mysqlconfig() {
  if [ -f /etc/my.cnf ]; then
    sedit /etc/my.cnf
  elif [ -f /etc/mysql/my.cnf ]; then
    sedit /etc/mysql/my.cnf
  elif [ -f /usr/local/etc/my.cnf ]; then
    sedit /usr/local/etc/my.cnf
  elif [ -f /usr/bin/mysql/my.cnf ]; then
    sedit /usr/bin/mysql/my.cnf
  elif [ -f ~/my.cnf ]; then
    sedit ~/my.cnf
  elif [ -f ~/.my.cnf ]; then
    sedit ~/.my.cnf
  else
    echo "Error: my.cnf file could not be found."
    echo "Searching for possible locations:"
    sudo updatedb && locate my.cnf
  fi
}

trim() {
  local var=$*
  var="${var#"${var%%[![:space:]]*}"}"
  var="${var%"${var##*[![:space:]]}"}"
  echo -n "$var"
}

gcom() {
  git add .
  git commit -m "$1"
}

lazyg() {
  git add .
  git commit -m "$1"
  git push
}

hb() {
  if [ $# -eq 0 ]; then
    echo "No file path specified."
    return
  elif [ ! -f "$1" ]; then
    echo "File path does not exist."
    return
  fi
  uri="http://bin.christitus.com/documents"
  response=$(curl -s -X POST -d @"$1" "$uri")
  if [ $? -eq 0 ]; then
    hasteKey=$(echo $response | jq -r '.key')
    echo "http://bin.christitus.com/$hasteKey"
  else
    echo "Failed to upload the document."
  fi
}

#######################################################
# PATH
#######################################################

export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

if [ -f /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# opencode
if [ -d "$HOME/.opencode/bin" ]; then
  export PATH="$HOME/.opencode/bin:$PATH"
fi

#######################################################
# PROMPT & INIT
#######################################################

if [[ "${TERM:-}" != "dumb" ]]; then
  eval "$(starship init zsh)"
fi

eval "$(zoxide init zsh)"

_cd_widget() {
  zle -I
  zi
}
zle -N _cd_widget
bindkey '^f' _cd_widget

alias lg='lazygit'

restow() {
  (
    cd "$HOME/dotfiles" || return
    git pull --ff-only && stow --restow */
  )
}
