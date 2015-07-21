# -*- mode: shell-script -*-

pushd()
{
  if [ $# -eq 0 ]; then
    DIR="${HOME}"
  else
    DIR="$1"
  fi

  builtin pushd "${DIR}" > /dev/null
  echo -n "DIRSTACK: "
  dirs
}

pushd_builtin()
{
  builtin pushd > /dev/null
  echo -n "DIRSTACK: "
  dirs
}

popd()
{
  builtin popd > /dev/null
  echo -n "DIRSTACK: "
  dirs
}

rpiprint()
{
    printer=$1
    file=$2
    scp "$file" rcs:/tmp/toprint.ps
    ssh -c lpr -P $printer /tmp/toprint.ps
    ssh -c rm /tmp/toprint.ps
}

unsymlink()
{
    link=$1
    source="$(readlink -f $link)"
    rm "$link"
    cp "$source" "$link"
}

ctxchg()
{
    # Default goes to home
    todir="$HOME"
    if [ -n "$1" ]
    then
	todir="$1"
    fi

    if [ ! -d $todir ]
    then
	echo "No such directory: $todir"
	return 1
    fi

    curdirs=($(echo -e $(realpath $PWD) | tr '/' ' '))
    todirs=($(echo -e $(realpath $todir) | tr '/' ' '))
    overlapdirs=""

    # find what directories overlap at the beginning. Do not need to
    # run multiple times
    for i in $(seq 1 $((${#curdirs[@]}>${#todirs[@]}?${#todirs[@]}:${#curdirs[@]})))
    do
	if [[ ${curdirs[$i]} = ${todirs[$i]} ]]
	then
	    overlapdirs+=(${curdirs[$i]})
	else
	    break
	fi
    done

    # Remove the overlapping dirs from the directories where scripts
    # are to be run
    for dir in ${overlapdirs[*]}
    do
	curdirs=(${curdirs[@]/$dir})
	todirs=(${todirs[@]/$dir})
    done

    # Run scripts
    if [[ -n $curdirs ]]
    then
       for i in $(seq ${#curdirs[@]} 1)
       do
	   dircleanup ()
	   {
	       echo -n ''
	   }
	   dirname=$(echo "$overlapdirs ${curdirs[@]:0:$i}" | tr ' ' '/')
	   [[ -f "$dirname/.subrc" ]] && source "$dirname/.subrc"
	   dircleanup
       done
    fi

    if [[ -n $todirs ]]
    then
	for i in $(seq 1 ${#todirs[@]})
	do
	    dirsetup ()
	    {
		echo -n ''
	    }
	    dirname=$(echo "$overlapdirs ${todirs[@]:0:$i}" | tr ' ' '/')
	    [[ -f "$dirname/.subrc" ]] && source "$dirname/.subrc"
	    dirsetup
	done
    fi

    pushd $@
}

alias la='ls -a'
alias ll='ls -al'
alias cd='ctxchg'
alias back='popd'
alias flip='pushd_builtin'
alias f='flip'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'x
alias egrep='egrep --color=auto'
# alias sl="sl -e"
alias e="emacs -q -nw -l /home/adam/.emacs.d/qinit.el"
alias mpc='mpc -h $(cat /tmp/mpd_host)'
alias conky='conky -c ~/.conky.d/default'
alias indent='while read line; do echo "        $line"; done'
alias xek="xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'"
alias paci='sudo pacman -S'
alias pacs='pacman -Ss'
alias pacu='sudo pacman -Syu'
alias apti='sudo aptitude install'
alias apts='aptitude search'
alias aptr='sudo aptitude remove'
alias aptu='sudo aptitude update && sudo aptitude upgrade'
alias kitty='cat'
alias soff='xset dpms force off'
alias gdb='gdb -q'
cdf () { cd "$(ls | grep $1)"; }
text() { ssh triazo "echo $@ | mail 8455490721@vtext.com"; }
