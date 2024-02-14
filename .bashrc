#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Make terminal default 258 colors
export TERM=xterm-256color

# Set to superior editing mode
set -o vi

# keybinds
bind -x '"\C-l":clear'

# PATH
export PATH="$HOME/.local/bin:$HOME/go/bin:$PATH"

# Support gpt globally
declare OPENAI_API_KEY
OPENAI_API_KEY="$(head -1 "$HOME/.config/gpt/token")"
export OPENAI_API_KEY

# ~~~~~~~~~~~~~~~ Exports  ~~~~~~~~~~~~~~~~~~~~~~~~

# export HISTFILE=~/.histfile
export HISTSIZE=25000
export SAVEHIST=25000
export HISTCONTROL=ignorespace


export PKM="$HOME/repos/zet"
# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

alias vi="nvi"
alias repos="cd $HOME/repos"
alias dotfiles="cd $HOME/repos/dotfiles"
alias src="source $HOME/.bashrc"
alias ideaverse="cd $HOME/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Ideaverse"
alias raspi="ssh raspibolt"
# alias ls="eza --group-directories-first"
# alias cat="bat"
alias lynx="$HOME/.local/bin/lynx"
alias rss="newsboat -r"
alias '?'="duck"
alias '??'="gpt"
alias mutt="neomutt"



# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~
# CTRL+R shows fuzzy history
fzf_history() {
  selected_command=$(history | fzf --tac | sed 's/^ *[0-9]* //')
  if [[ -n "$selected_command" ]]; then
    printf "%s\n" "$selected_command"
    # Set a timeout for Enter key press (adjust as needed)
    read -t 2 -n 1 key
    # If Enter key was pressed (key is empty), execute the command
    if [[ -z "$key" ]]; then
      bash -c "$selected_command"
    fi
  fi
}

builtin set -o histexpand;
builtin bind -x '"\C-x1": fzf_history';
builtin bind '"\C-r": "\C-x1\e^\er"'
set t_ut=