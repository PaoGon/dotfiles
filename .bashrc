# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

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
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    #test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='exa --icons'
    alias ll='exa --icons --tree -L 1 -la'
    alias la='exa --icons --tree -a'
    alias l='exa --icons --tree -L 2'

    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#neofetch

# pokemon
gen_poke(){
    pokemon=("hoothoot" "larvitar" "wartortle" "cyndaquil" "shellder" "aron" "totodile" "psyduck") 
    pokemon-colorscripts -n "${pokemon[$((RANDOM%${#pokemon[@]}))]}"
}
gen_poke

gen_make(){
    if [[ $1 == 'esp' ]]; then
        printf ".PHONY: default all flash clean\n\ndefault: all flash\n\nall:\n\tarduino-cli compile -b esp8266:esp8266:nodemcuv2\n\nflash:\n\tarduino-cli upload -v -p /dev/ttyUSB0 -b esp8266:esp8266:nodemcuv2" > Makefile
        echo "Makefile succesfully created"
    else
        printf ".PHONY: default all flash clean\n\ndefault: all flash\n\nall:\n\tarduino-cli compile\n\nflash:\n\tarduino-cli upload -v " > Makefile
        echo "Makefile succesfully created"
    fi
}


##powerline
#export PATH="$PATH:/home/gon/.local/bin/"
#powerline-daemon -q 
#POWERLINE_BASH_CONTINUATION=1
#POWERLINE_BASH_SELECT=1
#source /home/gon/.local/lib/python3.9/site-packages/powerline/bindings/bash/powerline.sh




# enable VI navigation 
set -o vi
bind '"jj":vi-movement-mode'

# windows shortcut aliases
alias naut='nautilus .'
alias so='source'
alias cl='clear && gen_poke'



# alias cd ..
alias b1='cd ..'
alias b2='cd .. && cd ..'
alias b3='cd .. && cd .. && cd ..'
alias b4='cd .. && cd .. && cd .. && cd ..'
alias b5='cd .. && cd .. && cd .. && cd .. && cd ..'

# back 
alias b='cd -'

alias vim='nvim'
alias py3='python3'
alias pyvenv='source venv/bin/activate'
alias ard-cli='arduino-cli'


alias cat='batcat --theme ansi-dark'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(starship init bash)"
export PATH=/opt/firefox/firefox:$PATH

# flutter completion
###-begin-flutter-completion-###

if type complete &>/dev/null; then
  __flutter_completion() {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           flutter completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -F __flutter_completion flutter
elif type compdef &>/dev/null; then
  __flutter_completion() {
    si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 flutter completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef __flutter_completion flutter
elif type compctl &>/dev/null; then
  __flutter_completion() {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       flutter completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K __flutter_completion flutter
fi

###-end-flutter-completion-###

## Generated 2021-12-22 13:43:15.037009Z
## By /home/gon/snap/flutter/common/flutter/bin/cache/flutter_tools.snapshot

# setting JRE environment path
JAVA_HOME=/usr/lib/jvm/jdk-11
PATH=$PATH:$HOME/bin:$JAVA_HOME/bin

export JAVA_HOME

export JRE_HOME


# Android 
export ANDROID_SDK_ROOT=/opt/android-sdk/cmdline-tools/latest/
export PATH=$PATH:$ANDROID_SDK_ROOT/tools

alias config='/usr/bin/git --git-dir=/home/gon/dotfiles/ --work-tree=/home/gon'
