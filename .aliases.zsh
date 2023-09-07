alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias du="ncdu --color dark -rr -x --exclude .git"
alias v="nvim"
alias -g F="| fzf"
alias -g G="| rg"

# git
alias gll="git pull"
alias gsh="git push"

# eza
alias ls='eza'                                                         # ls
alias l='eza -lbF --git'                                               # list, size, type, git
alias ll='eza -lbGF --git'                                             # long list
alias llm='eza -lbGF --git --sort=modified'                            # long list, modified date sort
alias la='eza -lbhHigUmuSa --time-style=long-iso --git --color-scale'  # all list
alias lx='eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale' # all + extended list
alias lS='eza -1'                                                      # one column, just names
alias lt='eza --tree --level=2'                                        # tree

# docker
alias dl="docker logs"
alias dlf="docker logs -f"
alias deit="docker exec -it"
alias dps=~/utils/betterdps.rb
alias dim=~/utils/betterdim.rb
