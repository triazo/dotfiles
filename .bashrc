

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
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi


if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi
