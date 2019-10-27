source "${HOME}/.zgen/zgen.zsh"

# if the init script doesn't exist
if ! zgen saved; then

  # specify plugins here
  zgen oh-my-zsh
  zgen oh-my-zsh plugins/fd
  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/asdf
  zgen oh-my-zsh plugins/yarn
  zgen oh-my-zsh plugins/docker
  zgen oh-my-zsh plugins/npm
  zgen oh-my-zsh plugins/colorize
  zgen oh-my-zsh plugins/golang
  zgen oh-my-zsh plugins/node
  zgen oh-my-zsh plugins/command-not-found

  zgen load unixorn/autoupdate-zgen
  zgen load chrissicool/zsh-256color
  zgen load marzocchi/zsh-notify
  zgen load junegunn/fzf
  zgen load andrewferrier/fzf-z
  zgen load zsh-users/zsh-autosuggestions
  zgen load zsh-users/zsh-completions src
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load adrien-f/docker-zsh

  # generate the init script from plugins above
  zgen save
fi

ZSH_THEME=""

# zsh plugins
autoload bashcompinit
bashcompinit

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

. ~/.aliases.zsh
. ~/.env.zsh
. ~/.functions.zsh
. ~/.plugins.zsh
. ~/.work.zsh

# prompt
eval "$(starship init zsh)"
