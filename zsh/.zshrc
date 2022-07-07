# Lines configured by zsh-newuser-install
HISTFILE=~/.cache/.histfile
HISTSIZE=1000
SAVEHIST=1000

bindkey -v
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	exec startx
fi

export GPG_TTY=$(tty)
export LIBGL_ALWAYS_SOFTWARE=1 alacritty
export XDG_CONFIG_HOME=$HOME/.config
export LESSHISTFILE=-
export EDITOR=vim

alias ls='ls --color=auto'

alias c='xsel --clipboard --input'
alias p='xsel --clipboard --output'
# End of lines configured by zsh-newuser-install
