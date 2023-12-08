if [ -f $HOME/.aliases ]; then
    . $HOME/.aliases
fi

alias src="exec bash"
alias load-aliases="source $HOME/.aliases"
