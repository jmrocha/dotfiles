bindkey -v
bindkey -M viins jj vi-cmd-mode
bindkey '^R' history-incremental-pattern-search-backward
# allow delete in vi insert mode. See https://vi.stackexchange.com/a/31672.
bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char

export SSL_CERT_FILE=/usr/local/etc/openssl@3/cert.pem

alias eplus8.6='/Applications/EnergyPlus-8-6-0/energyplus'
alias eplus23='/Applications/EnergyPlus-23-1-0/energyplus-23.1.0'
alias eplus9.4='/Applications/EnergyPlus-9-4-0/energyplus'
alias python='python3'
alias ls='ls -a -CFG --color'
alias l='ls -a -G --color'
alias la='ls -la -G --color'
alias ll='ls -l -G --color'
alias node='NODE_NO_READLINE=1 rlwrap node'
alias tmux='tmux -u'
alias less='less -S'
alias view='nvim -R'

export LC_CTYPE="UTF-8"
export LANG="C"

export PATH="/usr/local/bin:$PATH:$HOME/.docker/bin"
function gi() { curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/$@ ;}
export PATH="/usr/local/opt/openjdk/bin:$PATH"

function pman() {
  mandoc -T pdf "$(/usr/bin/man -w $@)" | open -fa Preview
}

#source ~/key-bindings.zsh
#source ~/completion.zsh

export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_ALT_C_COMMAND="fd --type d"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height 70% --tmux 70% --layout=reverse --border'
export FZF_TMUX_OPTS='-p80%,60%'
#export FZF_ALT_C_COMMAND="fd --type d --ignore $HOME/.ignore"
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
export FZF_CTRL_T_OPTS="
	--preview 'bat -n --color=always {}'
	--bind 'ctrl-/:change-preview-window(down|hidden|)'"

# CTRL-/ to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"	

#source /Users/jrocha/.config/broot/launcher/bash/br
export EDITOR='nvim'
#source /usr/local/opt/chruby/share/chruby/chruby.sh
#source /usr/local/opt/chruby/share/chruby/auto.sh
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/binutils/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/usr/local/opt/node@20/bin:$PATH"

source /Users/joao/.config/broot/launcher/bash/br
### key-bindings.zsh ###
#     ____      ____
#    / __/___  / __/
#   / /_/_  / / /_
#  / __/ / /_/ __/
# /_/   /___/_/ key-bindings.zsh
#
# - $FZF_TMUX_OPTS
# - $FZF_CTRL_T_COMMAND
# - $FZF_CTRL_T_OPTS
# - $FZF_CTRL_R_OPTS
# - $FZF_ALT_C_COMMAND
# - $FZF_ALT_C_OPTS


# Key bindings
# ------------

# The code at the top and the bottom of this file is the same as in completion.zsh.
# Refer to that file for explanation.
if 'zmodload' 'zsh/parameter' 2>'/dev/null' && (( ${+options} )); then
  __fzf_key_bindings_options="options=(${(j: :)${(kv)options[@]}})"
else
  () {
    __fzf_key_bindings_options="setopt"
    'local' '__fzf_opt'
    for __fzf_opt in "${(@)${(@f)$(set -o)}%% *}"; do
      if [[ -o "$__fzf_opt" ]]; then
        __fzf_key_bindings_options+=" -o $__fzf_opt"
      else
        __fzf_key_bindings_options+=" +o $__fzf_opt"
      fi
    done
  }
fi

'builtin' 'emulate' 'zsh' && 'builtin' 'setopt' 'no_aliases'

{
if [[ -o interactive ]]; then

__fzf_defaults() {
  # $1: Prepend to FZF_DEFAULT_OPTS_FILE and FZF_DEFAULT_OPTS
  # $2: Append to FZF_DEFAULT_OPTS_FILE and FZF_DEFAULT_OPTS
  echo "--height ${FZF_TMUX_HEIGHT:-40%} --bind=ctrl-z:ignore $1"
  command cat "${FZF_DEFAULT_OPTS_FILE-}" 2> /dev/null
  echo "${FZF_DEFAULT_OPTS-} $2"
}

# CTRL-T - Paste the selected file path(s) into the command line
__fzf_select() {
  setopt localoptions pipefail no_aliases 2> /dev/null
  local item
  FZF_DEFAULT_COMMAND=${FZF_CTRL_T_COMMAND:-} \
  FZF_DEFAULT_OPTS=$(__fzf_defaults "--reverse --walker=file,dir,follow,hidden --scheme=path" "${FZF_CTRL_T_OPTS-} -m") \
  FZF_DEFAULT_OPTS_FILE='' $(__fzfcmd) "$@" < /dev/tty | while read item; do
    echo -n "${(q)item} "
  done
  local ret=$?
  echo
  return $ret
}

__fzfcmd() {
  [ -n "${TMUX_PANE-}" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "${FZF_TMUX_OPTS-}" ]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
}

fzf-file-widget() {
  LBUFFER="${LBUFFER}$(__fzf_select)"
  local ret=$?
  zle reset-prompt
  return $ret
}
if [[ "${FZF_CTRL_T_COMMAND-x}" != "" ]]; then
  zle     -N            fzf-file-widget
  bindkey -M emacs '^T' fzf-file-widget
  bindkey -M vicmd '^T' fzf-file-widget
  bindkey -M viins '^T' fzf-file-widget
fi

# ALT-C - cd into the selected directory
fzf-cd-widget() {
  setopt localoptions pipefail no_aliases 2> /dev/null
  local dir="$(
    FZF_DEFAULT_COMMAND=${FZF_ALT_C_COMMAND:-} \
    FZF_DEFAULT_OPTS=$(__fzf_defaults "--reverse --walker=dir,follow,hidden --scheme=path" "${FZF_ALT_C_OPTS-} +m") \
    FZF_DEFAULT_OPTS_FILE='' $(__fzfcmd) < /dev/tty)"
  if [[ -z "$dir" ]]; then
    zle redisplay
    return 0
  fi
  zle push-line # Clear buffer. Auto-restored on next prompt.
  BUFFER="builtin cd -- ${(q)dir:a}"
  zle accept-line
  local ret=$?
  unset dir # ensure this doesn't end up appearing in prompt expansion
  zle reset-prompt
  return $ret
}
if [[ "${FZF_ALT_C_COMMAND-x}" != "" ]]; then
  zle     -N             fzf-cd-widget
  bindkey -M emacs '\ec' fzf-cd-widget
  bindkey -M vicmd '\ec' fzf-cd-widget
  bindkey -M viins '\ec' fzf-cd-widget
fi

# CTRL-R - Paste the selected command from history into the command line
fzf-history-widget() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
  # Ensure the associative history array, which maps event numbers to the full
  # history lines, is loaded, and that Perl is installed for multi-line output.
  if zmodload -F zsh/parameter p:history 2>/dev/null && (( ${#commands[perl]} )); then
    selected="$(printf '%1$s\t%2$s\000' "${(vk)history[@]}" |
      perl -0 -ne 'if (!$seen{(/^\s*[0-9]+\**\s+(.*)/, $1)}++) { s/\n/\n\t/gm; print; }' |
      FZF_DEFAULT_OPTS=$(__fzf_defaults "" "-n2..,.. --scheme=history --bind=ctrl-r:toggle-sort --highlight-line ${FZF_CTRL_R_OPTS-} --query=${(qqq)LBUFFER} +m --read0") \
      FZF_DEFAULT_OPTS_FILE='' $(__fzfcmd))"
  else
    selected="$(fc -rl 1 | awk '{ cmd=$0; sub(/^[ \t]*[0-9]+\**[ \t]+/, "", cmd); if (!seen[cmd]++) print $0 }' |
      FZF_DEFAULT_OPTS=$(__fzf_defaults "" "-n2..,.. --scheme=history --bind=ctrl-r:toggle-sort --highlight-line ${FZF_CTRL_R_OPTS-} --query=${(qqq)LBUFFER} +m") \
      FZF_DEFAULT_OPTS_FILE='' $(__fzfcmd))"
  fi
  local ret=$?
  if [ -n "$selected" ]; then
    if num=$(awk '{print $1; exit}' <<< "$selected" | grep -o '^[1-9][0-9]*'); then
      zle vi-fetch-history -n $num
    else # selected is a custom query, not from history
      LBUFFER="$selected"
    fi
  fi
  zle reset-prompt
  return $ret
}
if [[ -o zle ]]; then
	zle     -N            fzf-history-widget
fi
bindkey -M emacs '^R' fzf-history-widget
bindkey -M vicmd '^R' fzf-history-widget
bindkey -M viins '^R' fzf-history-widget
fi

} always {
  eval $__fzf_key_bindings_options
  'unset' '__fzf_key_bindings_options'
}
### end: key-bindings.zsh ###
export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="/usr/local/opt/openjdk/bin:$PATH"
#export TERM=tmux-256color

export PATH="$PATH:$HOME/practice/eiffel/Eifell_25.02/studio/spec/macosx-86-64/bin"
export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="/usr/local/opt/homebrew/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export ISE_LIBRARY="/usr/local/Cellar/eiffelstudio/24.05.107822/library"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/joao/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
#
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_BAT=1

source $HOME/fzf-git.sh
