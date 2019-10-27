# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='/usr/local/opt/fd/bin/fd --type f --color=never'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='/usr/local/opt/fd/bin/fd --type d . --color=never'
export FZF_DEFAULT_OPTS='
  --height 75% --multi --reverse
  --bind ctrl-f:page-down,ctrl-b:page-up,ctrl-o:"execute(code {})+abort"
'
alias preview="fzf --preview 'bat --color always {}'"

# asdf
. $(brew --prefix asdf)/asdf.sh
. $(brew --prefix asdf)/etc/bash_completion.d/asdf.bash

# scm_breeze
[ -s "/Users/alessandro.cifani/.scm_breeze/scm_breeze.sh" ] && source "/Users/alessandro.cifani/.scm_breeze/scm_breeze.sh"

# cani use
[ -f /Users/alessandro.cifani/.config/cani/completions/_cani.zsh ] && source /Users/alessandro.cifani/.config/cani/completions/_cani.zsh

# z 
. /usr/local/etc/profile.d/z.sh

