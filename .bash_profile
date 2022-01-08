export PATH="/usr/local/opt/tcl-tk/bin:$PATH"
source ~/git-prompt.sh

alias ls='ls -CFG'
alias l='ls -G'
alias la='ls -la -G'
alias ll='ls -l -G'
alias python=python3
alias maxima=rmaxima

PS1='\u@\h:\w$(__git_ps1 " (%s)")\$ '

export GREP_OPTIONS='--color=always'
export GREP_COLOR='1;35;40'
export PATH="/usr/local/opt/tcl-tk/bin:$PATH"
export PROMPT_DIRTRIM=2

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

export GPG_TTY=$(tty)
export PATH="/usr/local/opt/llvm/bin:$PATH"
# comment the line below to use latest JDK 
#export JAVA_11_HOME=/usr/local/opt/openjdk@11
#export PATH="$JAVA_11_HOME/bin:$PATH"
export PATH="/usr/local/opt/sqlite/bin:$PATH"
set -o vi
# key bindings to clear screen in insert mode
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

source /Users/jrocha/.config/broot/launcher/bash/br
bind '"jj":vi-movement-mode'
function gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@ ;}
export VISUAL='vim'
export LESS='-R'
export PATH="/usr/local/opt/llvm@12/bin:$PATH"
# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 2>/dev/null ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end

# Created by `pipx` on 2021-10-31 22:46:45
export PATH="$PATH:/Users/jrocha/.local/bin"
alias eplus8.6='/Applications/EnergyPlus-8-6-0/energyplus'

function pretty_csv {
  perl -pe 's/((?<=,)|(?<=^)),/ ,/g;' "$@" | column -t -s, | view -s $HOME/.vimcsvrc -
}

function pretty_json {
  python -m json.tool --no-ensure-ascii $@ | pygmentize -l json | less
}

export PATH="/usr/local/opt/util-linux/bin:$PATH"
export PATH="/usr/local/opt/util-linux/sbin:$PATH"

function emit_bitcode {
  clang -emit-llvm -c -O0 -Xclang -disable-O0-optnone -Xclang -disable-llvm-passes $@
}

