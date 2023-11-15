#!/bin/bash

# Made January 2015 by triazo

# The structure of the dotfiles dir mirrors that of the home folder.
# Thus we can just list files that need to be linked
weechatfiles=".weechat/plugins.conf .weechat/aspell.conf .weechat/irc.conf .weechat/trigger.conf .weechat/sec.conf .weechat/exec.conf .weechat/weechat.conf .weechat/logger.conf .weechat/alias.conf .weechat/script.conf .weechat/xfer.conf .weechat/buffers.conf .weechat/relay.conf .weechat/charset.conf .weechat/python/anotify2.py scripts/weenotify.py scripts/relay.py"
emacsfiles=".emacs.d/lisp .emacs.d/bindings.el .emacs.d/modes .emacs.d/styles .emacs.d/init.el .emacs.d/tetris-scores .emacs.d/custom.el .emacs.d/packages.el .emacs.d/qinit.el .emacs.d/fairyfloss-theme.el"
basicfiles="${emacsfiles} ${weechatfiles} .bash_aliases .tmux.conf .zshrc scripts/shellsetup.sh scripts/share.sh .config/starship.toml"
xfiles="${basicfiles} scripts/p-urxvtc scripts/dwm_run.sh scripts/automon.sh scripts/xinit .config/dunst/dunstrc usr/src/dwm .xinitrc .xbindkeysrc .xmodmap scripts/touchpad.sh scripts/header.py scripts/screenie.sh .config/rofi .config/hyprland .config/kitty/kitty.conf"

# Convinence function used below
link () {
    to="$1"
    ! [ -d "$(dirname "$to")" ] && mkdir -p "$(dirname "$to")"

    [ -a "$to" ] && rm -r "$to"
    [ -h "$to" ] && rm -r "$to"
    todir=$(dirname $to)
    destpath="$(/usr/bin/realpath -s --relative-to=$todir $HOME/usr/dotfiles/$to)"
    ln -s "${destpath}" "$to"

}

usage () {
    cat <<EOF
Usage: $0 [-xc]
  -x  Include x configuration files
  -c  Re-compile x utilities
  -g  Clone emacs from git
  -d  Compile gdbp
EOF
}


# get the options
install_x=
compile_x=
clone_emacs=
compile_gdb=
while getopts ":xc" OPTION
do
    case $OPTION in
	x)
	    install_x="true"
	    ;;
	c)
	    compile_x="true"
	    ;;
	g)
	    clone_emacs="true"
	    ;;
	d)
	    compile_gdb="true"
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

if [[ -z $(which basename) ]]
then
  echo "Please install basename before running this script"
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
    git clone git@github.com:triazo/dotfiles.git
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

if [ $compile_x ]
then
    mkdir -p ~/usr/src
    cd ~/usr/src

    if ! [ -x "$(which makeinfo)" ]
    then
	echo "install texinfo to compile emacs"
	exit 0
    fi

    # Emacs compilation ##############################
    #
    # First pull source from git

    if [ $clone_emacs ]
    then
	if [ -d emacs/.git ]
	then
	    cd emacs
	    git pull --rebase
	    git clean -fdx
	else
	    git clone git://git.savannah.gnu.org/emacs.git
	    cd emacs
	fi
    else
	# Some code to get the latest version. Should be decently robust?
	url="http://ftpmirror.gnu.org/emacs/"
	latest_version=$(curl -sL $url | grep -o 'href=".*"' | grep -e 'emacs-[0-9]' | grep -v '.sig' | sed 's/href="//' | sed 's/".*//' | sort -V | tail -n 1)
	curl -OL ${url}${latest_version}

	if [ -d "emacs" ]; then
	    echo "removing previous emacs build directory"
	    rm -r "emacs"
	fi
	tar -xf "${latest_version}"
	mv "$(basename ${latest_version} .tar.xz)" "emacs"
	cd emacs
    fi

    /bin/bash ./autogen.sh
    configargs="--prefix=$HOME/usr/"
    if [ $install_x ]
    then
	configargs="$configargs --without-toolkit-scroll-bars"
    else
	configargs="$configargs --without-x"
    fi
    /bin/bash ./configure $configargs
    make
    make install

    cd ~/usr/src

    # gdb compilation ##############################
    #
    # First update source

    if [ $compile_gdb ]
    then
	if [ -d binutils-gdb/.git ]
	then
	    cd binutils-gdb
	    git pull --rebase
	    git clean -fdx
	else
	    git clone git://sourceware.org/git/binutils-gdb.git
	    cd binutils-gdb
	fi


	configargs="--prefix=$HOME/usr/ --with-python=python3"
	/bin/bash ./configure $configargs
	/usr/bin/make
	/usr/bin/make install

	# Now clone peda
	cd ~/usr/src
	git clone git@github.com:longld/peda.git
	echo "source ~/usr/src/peda/peda.py" > "$HOME/.gdbinit"
    fi
fi
