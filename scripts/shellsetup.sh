#!/bin/bash

# Made January 2015 by triazo

# The structure of the dotfiles dir mirrors that of the home folder.
# Thus we can just list files that need to be linked
weechatfiles=".weechat/plugins.conf .weechat/aspell.conf .weechat/irc.conf .weechat/trigger.conf .weechat/sec.conf .weechat/exec.conf .weechat/weechat.conf .weechat/logger.conf .weechat/alias.conf .weechat/script.conf .weechat/xfer.conf .weechat/buffers.conf .weechat/relay.conf .weechat/charset.conf .weechat/python/anotify2.py scripts/weenotify.py scripts/relay.py"
emacsfiles=".emacs.d/lisp .emacs.d/bindings.el .emacs.d/modes .emacs.d/styles .emacs.d/init.el .emacs.d/tetris-scores .emacs.d/custom.el .emacs.d/qinit.el"
basicfiles="${emacsfiles} ${weechatfiles} .bash_aliases .tmux.conf .zshrc scripts/shellsetup.sh"
xfiles="${basicfiles} scripts/p-urxvtc scripts/dwm_run.sh scripts/automon.sh .config/dunst/dunstrc usr/src/dwm .xinitrc .xbindkeysrc .xmodmap"

# Convinence function used below
link () {
    to="$1"
    ! [ -d "$(dirname "$to")" ] && mkdir -p "$(dirname "$to")"
    
    if ! [ -h "$to" ]
    then
	[ -a "$to" ] && rm -r "$to"
	ln -s "$HOME/usr/dotfiles/$to" "$to"
    fi
}

usage () {
    cat <<EOF
Usage: $0 [-xc]
  -x  Include x configuration files
  -c  Re-compile x utilities
EOF
}


# get the options
install_x=
compile_x=
while getopts ":xc" OPTION
do
    case $OPTION in
	x)
	    install_x="true"
	    ;;
	c)
	    compile_x="true"
	    ;;
	?)
	    usage
	    exit 1
	    ;;
    esac
done

# Have user install git
if [[ -z $(which git) ]] 
then
  echo "Please install git before running this script"
  exit 1
fi



# Clone the dotfiles directory if it is not already a git repo. otherwise, update
mkdir -p usr
cd ~/usr
if [ -d dotfiles/.git ]
then
    cd dotfiles
    git pull
else
    git clone https://github.com/triazo/dotfiles
fi

# Change back to the home directory
cd ~

if [ $install_x ]
then
    for file in ${xfiles}
    do
	echo "linking $file"
	link $file
    done
else
    for file in ${basicfiles}
    do
	echo "linking $file"
	link $file
    done
fi


echo "Install these packages to use everything:"
echo "    gcc"
echo "    dunst"
