#!/usr/bin/env zsh

# Make sure all config file get into a config folder
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export ZDOTDIR=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}

export EDITOR="code"
export VISUAL="code"
export LANG=en_US.UTF-8


export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

export DOTFILES="$HOME/.dotfiles"
export WORKSPACE="$HOME/development"

# Ensure path arrays do not contain duplicates.
typeset -gU path fpath

path=(
  $HOME/{,s}bin(N)
  $HOME/.local/{,s}bin(N)
  $XDG_CONFIG_HOME/bin
  $HOME/.rbenv/bin:$PATH
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)
