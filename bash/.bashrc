# source old .bashrc
[ -f ~/.bashrc.bak ] && source ~/.bashrc.bak

# source alias file 
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Add linuxbrew to path
test -d ~/.linuxbrew && LINUXBREW_PATH=$HOME/.linuxbrew
test -d /home/linuxbrew/.linuxbrew && LINUXBREW_PATH=/home/linuxbrew/.linuxbrew
PATH="$LINUXBREW_PATH/bin:$LINUXBREW_PATH/sbin:$PATH"

# Add composer vendor binary path
PATH="$HOME/.config/composer/vendor/bin:$PATH"

# rupa/z
[ -f $LINUXBREW_PATH/etc/profile.d/z.sh ] && source $LINUXBREW_PATH/etc/profile.d/z.sh

# Fuzzy finder with fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# make z fuzzy with fzf
unalias z 2> /dev/null

z() {
  [ $# -gt 0  ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf-tmux +s --tac --query "$*" | sed 's/^[0-9,.]* *//')"
}

