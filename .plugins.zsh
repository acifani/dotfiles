# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='fd --type f --color=never'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d . --color=never'
export FZF_DEFAULT_OPTS='
  --height 75% --multi --reverse
  --bind ctrl-f:page-down,ctrl-b:page-up,ctrl-o:"execute(code {})+abort"
'
alias preview="fzf --preview 'bat --color always {}'"

# asdf
. $(brew --prefix asdf)/asdf.sh
. $(brew --prefix asdf)/etc/bash_completion.d/asdf.bash

# scm_breeze
[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"

# z 
. $(brew --prefix)/etc/profile.d/z.sh

