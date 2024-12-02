eval "$(starship init zsh)"


ZFUNCDIR=${ZDOTDIR:-$HOME}/.zfunctions
# Add functions directory to fpath and autoload all functions
if [[ -d "$ZFUNCDIR" ]]; then
    # Ensure directory is in fpath
    fpath=($ZFUNCDIR $fpath)

    # Autoload all functions from the directory
    autoload -Uz $ZFUNCDIR/*(:t)
fi

# +---------+
# | ANTIDOTE |
# +---------+

# source antidote
source $ZDOTDIR/.antidote/antidote.zsh

# Set the root name of the plugins files (.txt and .zsh) antidote will use.
zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins

# Ensure the .zsh_plugins.txt file exists so you can add plugins.
[[ -f ${zsh_plugins}.txt ]] || touch ${zsh_plugins}.txt

# Lazy-load antidote from its functions directory.
fpath=($ZDOTDIR/.antidote/functions $fpath)
autoload -Uz antidote

# Generate a new static file whenever .zsh_plugins.txt is updated.
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  antidote bundle <${zsh_plugins}.txt >|${zsh_plugins}.zsh
fi

# Source your static plugins file.
source ${zsh_plugins}.zsh

# +---------+
# | ALIASES |
# +---------+
source $XDG_CONFIG_HOME/.aliases


setopt HIST_SAVE_NO_DUPS # Do not write a duplicate event to the history file.
