# get fzf version
fzf_version=$(fzf --version | cut -f 1 -d " ")

# Auto-completion
# ---------------
source "home/linuxbrew/.linuxbrew/Cellar/fzf/$fzf_version/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/linuxbrew/.linuxbrew/Cellar/fzf/$fzf_version/shell/key-bindings.bash"
