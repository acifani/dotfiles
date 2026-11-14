# fzf
command -v fzf >/dev/null && source <(fzf --zsh)

export FZF_DEFAULT_COMMAND='fd --type f --color=never'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d . --color=never'
export FZF_DEFAULT_OPTS='
  --height 75% --multi --reverse
  --bind ctrl-f:page-down,ctrl-b:page-up,ctrl-o:"execute(code {})+abort"
'
alias preview="fzf --preview 'bat --color always {}'"

# fd
command -v fd >/dev/null && source <(fd --gen-completions zsh)

# zoxide: `z <dir>` jumps by frecency, `zi` picks with fzf
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"
