# The following lines were added by compinstall
zstyle :compinstall filename '/home/triazo/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
bindkey -e
# End of lines configured by zsh-newuser-install

autoload -U compinit promptinit
promptinit

setopt globdots

local start="%(?,%F{red}☺,%F{red}☹)"

# Decode color based on hostname.
HOSTNAME=$(hostname)
COLOR=yellow
if [[ "$HOSTNAME" == *"tin"* ]]
then
    COLOR=magenta
elif [[ "$HOSTNAME" == *"zinc"* ]]
then
    COLOR=blue
elif [[ "$HOSTNAME" == *"iron"* ]]
then
    COLOR=black
fi

PROMPT="%K{green}%(?,%B%F{green}▒░,%F{red}█▒)%K{green}%F{yellow}%B%n@%F{$COLOR}%m%b%F{green}%K{black}▓▒░%F{blue}%K{black}%B%~/%b%k%f%F{black}%K{default}▓▒░%B%F{blue}%#%b%F{default} "
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
