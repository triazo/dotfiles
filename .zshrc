# The following lines were added by compinstall
zstyle :compinstall filename '/home/triazo/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000000
SAVEHIST=10000000
bindkey -e
# End of lines configured by zsh-newuser-install

autoload -U compinit promptinit
promptinit

setopt globdots
set bell-style none

local start="%(?,%F{red}☺,%F{red}☹)"

# Decode hostname color based on hostname.
HOSTNAME=$(cat /etc/hostname)
COLOR=yellow
if [[ "$HOSTNAME" == *"tin"* ]]
then
    COLOR=129
elif [[ "$HOSTNAME" == *"zinc"* ]]
then
    COLOR=blue
elif [[ "$HOSTNAME" == *"nicrosil"* ]]
then
    COLOR=cyan
elif [[ "$HOSTNAME" == *"iron"* ]]
then
    COLOR=black
fi

# Other prompt colors
SYSTEM_COLOR=69
BGCOLOR=183
ERRORCOLOR=196
PATHBGCOLOR=53
PATHCOLOR=69

PROMPT="%K{$BGCOLOR}%(?,%B%F{$BGCOLOR}▒░,%F{$ERRORCOLOR}█▒)%K{$BGCOLOR}%F{$SYSTEM_COLOR}%B%n@%F{$COLOR}%m%b%F{$BGCOLOR}%K{$PATHBGCOLOR}▓▒░%F{$PATHCOLOR}%K{$PATHBGCOLOR}%B%~/%b%k%f%F{$PATHBGCOLOR}%K{default}▓▒░%B%F{$PATHCOLOR}%#%b%F{default} "
RPROMPT=""

# Cascading preferences of editors
EDITOR="$HOME/usr/bin/emacs"
[ -x "$EDITOR" ] || EDITOR="$HOME/scripts/emacs"
[ -x "$EDITOR" ] || EDITOR='/usr/bin/emacs'
[ -x "$EDITOR" ] || EDITOR='/usr/bin/vim'
[ -x "$EDITOR" ] || EDITOR='/usr/bin/vi'

# source ~/.zsh/zsh-syntax-highlighting.zsh
export PATH=$HOME/usr/bin:$HOME/scripts:$HOME/go/bin:$PATH

export GOPATH=$HOME/go
export CC=/usr/bin/clang

[ -f ~/.localrc ] && source ~/.localrc
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

export WINEPREFIX="$HOME/usr/wine"
export PREFIX="$HOME/usr"

# SSH-agent starting
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

