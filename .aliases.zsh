alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias du="ncdu --color dark -rr -x --exclude .git"
alias v="nvim"
alias -g F="| fzf"
alias -g G="| rg"

# git
alias gll="git pull"
alias gsh="git push"

# exa
alias ls='exa'                                                         # ls
alias l='exa -lbF --git'                                               # list, size, type, git
alias ll='exa -lbGF --git'                                             # long list
alias llm='exa -lbGF --git --sort=modified'                            # long list, modified date sort
alias la='exa -lbhHigUmuSa --time-style=long-iso --git --color-scale'  # all list
alias lx='exa -lbhHigUmuSa@ --time-style=long-iso --git --color-scale' # all + extended list
alias lS='exa -1'                                                      # one column, just names
alias lt='exa --tree --level=2'                                        # tree

# docker
alias dl="docker logs"
alias dlf="docker logs -f"
alias deit="docker exec -it"
alias dps=~/utils/betterdps.rb
alias dim=~/utils/betterdim.rb
