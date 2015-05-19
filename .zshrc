# The following lines were added by compinstall
zstyle :compinstall filename '/home/adam/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -e
# End of lines configured by zsh-newuser-install

autoload -U compinit promptinit
promptinit

setopt globdots

local start="%(?,%F{red}☺,%F{red}☹)"

PROMPT="%K{green}%(?,%B%F{green}▒░,%F{red}█▒)%K{green}%F{yellow}%B%n@%m%b%F{green}%K{black}▓▒░%F{blue}%K{black}%B%~/%b%k%f%F{black}%K{default}▓▒░%B%F{blue}%#%b%F{default} "
RPROMPT=""

# Cascading preferences of editors
EDITOR='/home/adam/usr/bin/emacs'
[ -x "$EDITOR" ] || EDITOR='/home/adam/scripts/emacs'
[ -x "$EDITOR" ] || EDITOR='/usr/bin/emacs'
[ -x "$EDITOR" ] || EDITOR='/usr/bin/vim'
[ -x "$EDITOR" ] || EDITOR='/usr/bin/vi'


# source ~/.zsh/zsh-syntax-highlighting.zsh
export PATH=/home/adam/usr/bin:/home/adam/scripts:$PATH


[ -f ~/.localrc ] && source ~/.localrc
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

WINEPREFIX='/home/adam/usr/wine'
