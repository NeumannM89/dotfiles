#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# https://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

DOCS_PATH=${HOME}/Documents/work/aidocs
export TEXMFHOME="${HOME}/.texmf:${DOCS_PATH}/texmf"
export BIBINPUTS=".:${DOCS_PATH}/bib:${DOCS_PATH}/bib/fromtum:${DOCS_PATH}/bib/external"
export PATH=”${DOCS_PATH}/tools:$PATH”
alias l='ls -CF'
alias ll='ls -alF'
alias la='ls -A'
alias ..='cd ..'
alias n='nvim'
export PATH="$HOME/.local/bin:$PATH"
bind -x '"\C-f": tmux-sessionizer'
