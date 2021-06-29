#!/bin/bash
	echo "export EDITOR=vim" >> $1
	echo "alias ls=’ls --color=auto’" >> $1
	echo "alias grep=’grep --color=auto’" >> $1
	echo "alias egrep=’egrep --color=auto’" >> $1
	echo "alias fgrep=’fgrep --color=auto’" >> $1
	echo "[ ! -e ~/.dircolors ] && eval \$(dircolors -p > ~/.dircolors)" >> $1
	echo "[ -e /bin/dircolors ] && eval \$(dircolors -b ~/.dircolors)" >> $1
