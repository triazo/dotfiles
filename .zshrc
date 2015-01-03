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

# source ~/.zsh/zsh-syntax-highlighting.zsh

export PATH=/home/adam/usr/bin:/home/adam/scripts:$PATH
export PATH=$PATH:/home/adam/usr/local/adt-bundle-linux-x86_64-20140321/sdk/tools:/home/adam/usr/local/adt-bundle-linux-x86_64-20140321/sdk/platform-tools

source ~/.bash_aliases

EDITOR='/usr/bin/emacs'
WINEPREFIX='/home/adam/usr/wine'
export PATH=$PATH:/opt/android-sdk/tools:/opt/android-sdk/platform-tools


# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
export COCOS_CONSOLE_ROOT=/home/adam/usr/local/cocos2d-x-3.2/tools/cocos2d-console/bin
export PATH=$COCOS_CONSOLE_ROOT:$PATH

# Add environment variable ANDROID_SDK_ROOT for cocos2d-x
export ANDROID_SDK_ROOT=/home/adam/usr/local/adt-bundle-linux-x86_64-20140321/sdk
export PATH=$ANDROID_SDK_ROOT:$PATH
export PATH=$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$PATH

# Add environment variable ANT_ROOT for cocos2d-x
export ANT_ROOT=/usr/share/ant/bin
export PATH=$ANT_ROOT:$PATH

# Add environment variable NDK_ROOT for cocos2d-x
export NDK_ROOT=/home/adam/usr/local/adt-bundle-linux-x86_64-20140321/android-ndk-r10
export PATH=$NDK_ROOT:$PATH
export OAUTH_TOKEN=993247e66b3b4250f0c6be0a922bb153d76d3244
