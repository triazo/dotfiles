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
    if [[ -n "$1" ]]
    then
	todir="$1"
    fi

    if [[ ! -d $todir ]]
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

newres() {
    ml="$1x$2_$3"
    echo $ml
    modeline="$(cvt -i $1 $2 $3 | tail -n 1 | sed -e 's/Modeline//g' | sed -e 's/^\ //g')"
    echo $modeline
    cmd=$(echo "xrandr --newmode $modeline")
    eval $cmd
    echo "HERE"
    xrandr --output HDMI-1 --mode "$ml"
}

filebottvtest () {
    filebot -rename -r "${1}" -non-strict --output /media/tv --format "{n}/Season {s}/{n} - {S00E00} - {t} {vs}-{vf}" --action test
}

filebottv () {
    filebot -rename -r "${1}" -non-strict --output /media/tv --format "{n}/Season {s}/{n} - {S00E00} - {t} {vs}-{vf}" --action hardlink
}

filebotmovietest () {
    filebot -rename -r "${1}" -non-strict --output /media/movies --format "{n} - ({y})/{n} - {vs}-{vf}" --action test
}

filebotmovie () {
    filebot -rename -r "${1}" -non-strict --output /media/movies --format "{n} - ({y})/{n} - {vs}-{vf}" --action hardlink
}



function update_terraform {
    pushd /tmp
    dl_url="https://www.terraform.io/downloads.html"
    bin_url=$(curl -s $dl_url | grep -A 5 "Linux" | grep "64-bit" | egrep -o "\".*\"" | tr -d "\"")
    curl $bin_url > terraform_bin.zip
    gunzip -f -S .zip terraform_bin.zip
    chmod +x terraform_bin
    mv terraform_bin $(which terraform)
    echo $(which terraform)
    terraform --version
    popd
}

function update_tofu {
    pushd /tmp
    releases_url="https://api.github.com/repos/opentofu/opentofu/releases/latest"
    version=$(curl "${releases_url}" | grep "tag_name" | sed -e 's/.*tag_name": "v//' -e 's/".*//')
    zipfile="tofu_${version}_linux_amd64.zip"
    bin_url="https://github.com/opentofu/opentofu/releases/download/v${version}/${zipfile}"
    wget "${bin_url}" -O tofu_bin.zip
    unzip -o tofu_bin.zip
    chmod +x ./tofu
    mv tofu $(which tofu)
    echo $(which tofu)
    tofu --version
    popd
}

function vrcencode {
    ffmpeg -i "$1" -c:v h264 -b:v 5M -maxrate 9M -bufsize 1M -vf "subtitles=${1}:stream_index=0" -movflags +faststart -pix_fmt yuv420p -c:a aac -ab 1536k -strict 2 -threads 8 "$2"
}

function calibre-convert {
    azwbook="$(realpath "$1")"
    epubbook=$(echo "$azwbook" | sed 's/\.azw3/\.epub/')
    /usr/bin/flatpak run --branch=stable --arch=x86_64 --command=ebook-convert com.calibre_ebook.calibre "$azwbook" "$epubbook"
}

alias la='ls -a'
alias ll='ls -al'
alias cd='pushd'
alias back='popd'
alias flip='pushd_builtin'
alias f='flip'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'x
alias egrep='egrep --color=auto'
# alias sl="sl -e"
alias e="emacsclient -c -nw --alternate-editor=''"
alias se="sudo emacs -q -nw"
alias mpc='mpc -h $(cat /tmp/mpd_host)'
alias conky='conky -c ~/.conky.d/default'
alias xek="xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'"
alias paci='sudo pacman -S'
alias pacs='pacman -Ss'
alias pacu='sudo pacman -Syu'
alias apti='sudo aptitude install'
alias apts='aptitude search'
alias aptr='sudo aptitude remove'
alias aptu='sudo aptitude update && sudo aptitude upgrade'
alias dnfi='sudo dnf install'
alias dnfr='sudo dnf autoremove'
alias dnfu='sudo dnf update'
alias dnfs='dnf search'
alias kitty='cat'
alias soff='xset dpms force off'
alias gdb='gdb -q'
alias cdsia="cd $HOME/go/src/gitlab.com/NebulousLabs/Sia"
alias cdsiabe="cd $HOME/go/src/gitlab.com/NebulousLabs/Sia-Block-Explorer"
alias idn='sudo ifdown --force wlan0'
alias iup='sudo ifup wlan0'

alias goodsteam='ENABLE_HDR_WSI=1 DXVK_HDR=1 DISPLAY= gamescope -f -e -W 3840 -H 2160 -r 144 --hdr-enabled --hdr-debug-force-output -- steam'
alias goodsteam2='ENABLE_HDR_WSI=1 DXVK_HDR=1 DISPLAY= gamescope -f -e -W 3840 -H 2160 -r 60 --hdr-enabled --hdr-debug-force-output --backend drm -- steam'

function vrctest
{
    vrcdir="/home/triazo/.var/app/com.valvesoftware.Steam/data/Steam/steamapps/compatdata/438100/pfx/drive_c/users/steamuser/AppData/LocalLow/VRChat/VRChat/Avatars/"
    cp "$1" ${vrcdir}
}
cdf () { cd "$(ls | grep $1)"; }
text() { ssh triazo "echo $@ | mail 8455490721@vtext.com"; }
filebottest () {
    filebot -rename -r "${1}" -non-strict --output /media/tv --format "{n}/Season {s}/{n} - {S00E00} - {t} {vs}-{vf}" --action hardlink
    }
filebotlink () {
    filebot -rename -r "${1}" -non-strict --output /media/tv --format "{n}/Season {s}/{n} - {S00E00} - {t} {vs}-{vf}" --action hardlink
    }
