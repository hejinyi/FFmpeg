# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='[${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]: \[\033[01;34m\]\W\[\033[00m\] \t]\$ '
else
    # PS1='[${debian_chroot:+($debian_chroot)}\u@\h: \W \t]\$ '
    # PS1='\[\033[01;32m\][\[\033[01;31m\]${debian_chroot:+($debian_chroot)}\u@\h: \[\033[01;33m\]\W\[\033[01;35m\] \t\[\033[01;32m\]]\[\033[01;36m\]\$\[\033[00m\] '
    PS1='\n\[\033[01;32m\][\[\033[01;31m\]${debian_chroot:+($debian_chroot)}\u@\h\[\033[01;35m\] \t\[\033[01;32m\]] \[\033[01;33m\]${PWD}\n\[\033[01;36m\]\$\[\033[00m\] '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    # PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \W\a\]$PS1"
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \W\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias sudo='sudo env PATH=$PATH'

## Added by gary 2013/10/21 ##
alias cdVidaa3App='cd ~/jamdeo-5328/vm_linux/android/kk-4.x/vendor/jamdeo/cinesense/packages/apps'
alias cdVidaa3Build='cd ~/jamdeo-5328/vm_linux/project_x/sys_build/hisense_android/ledhdmi5861_cn_android'
alias cdVidaa3Out='cd ~/jamdeo-5328/vm_linux/android/kk-4.x/out/target/product/mt5861/system'
alias adbconnectvidaa3='adb disconnect; adb connect 192.168.1.101; adb remount'
alias adbconnectvidaa4='adb disconnect; adb connect 192.168.1.107; sleep 1; adb remount'
alias adbconnecthisi='adb disconnect; adb connect 192.168.1.106; adb remount'
alias adbconnect5508='adb disconnect; adb connect 192.168.1.105; adb remount'
alias adbconnect5329='adb disconnect; adb connect 192.168.1.107; adb remount'
alias adbPushSystemUI='adb push ~/jamdeo-5328/vm_linux/android/kk-4.x/out/target/product/mt5861/system/priv-app/CinesenseSystemUI.apk /system/priv-app'
alias adbPushMediaCenter='adb push ~/jamdeo-5328/vm_linux/android/kk-4.x/out/target/product/mt5861/system/app/MediaCenter.apk /system/app'
alias reporeset='echo "repo forall -c git reset --hard HEAD^; repo forall -c git clean -df; repo sync -j4"; repo forall -c git reset --hard HEAD^; repo forall -c git clean -df; repo sync -j4'
alias vim='VimEnvSet.sh > /dev/null; vim'
alias goHome='cd ~/jamdeo-5328/; resetBranch.sh; cd ~/jamdeo-5328/vm_linux/project_x/sys_build/hisense_android/ledhdmi5861_cn_android/; . init.sh; make clean; make; cd ~/jamdeo-5328/; ctag_cscope_lookupfile_set.sh; sudo shutdown -h now'
alias changeRoute='sudo ip route change default via 10.18.87.1 dev eth0 proto static'
alias addDomain='sudo domainjoin-cli join hisense.ad hejinyi'
alias leaveDomain='sudo domainjoin-cli leave hejinyi'
alias syncBranch='repo start hejinyi_tmp .; git branch -D master; repo start master .; git branch -D hejinyi_tmp'
alias mstar-addr2line='/home/gary/prebuilts/tools/mstar-gcc/arm-2012.09/bin/arm-none-linux-gnueabi-addr2line'
alias ffmpeg='ffmpeg -hide_banner'
## Added by gary 2013/10/21 ##


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias git-diff='git difftool -y'
alias ffprobe-i='ffprobe -print_format json -show_format -show_streams -i '

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


# add by gary for gerrit account in 2013-09-22
export PATH="${PATH}:${HOME}/bin:${HOME}/Myscript:/mtkoss/jdk/1.6.0_23-ubuntu-10.04/x86_64/bin"
export PATH="${PATH}:${HOME}/Documents/android4.4/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.7/bin"
export PATH="${PATH}:${HOME}/Documents/android4.4/out/host/linux-x86/bin"
export PATH="${PATH}:/opt/Hisilicon-tools/arm-hisiv200-linux/target/bin"
export ANDROID_PRODUCT_OUT="${HOME}/Documents/android4.4/out/target/product/generic"
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
export XIM_PROGRAM=/usr/bin/ibus-daemon
export JAVA_HOME=/usr/lib/jvm/java-6-sun/
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tool.jar
# export INIT_BOOTCHART=true
# add by gary for gerrit account in 2013-09-22
