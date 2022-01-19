source "${HOME}/.zgenom/zgenom.zsh"

zgenom autoupdate --background

# if the init script doesn't exist
if ! zgenom saved; then

  # specify plugins here
  zgenom ohmyzsh
  zgenom ohmyzsh plugins/asdf
  zgenom ohmyzsh plugins/command-not-found
  zgenom ohmyzsh plugins/docker
  zgenom ohmyzsh plugins/fd
  zgenom ohmyzsh plugins/gh
  zgenom ohmyzsh plugins/git
  zgenom ohmyzsh plugins/golang
  zgenom ohmyzsh plugins/macos
  zgenom ohmyzsh plugins/kubectl
  zgenom ohmyzsh plugins/lein
  zgenom ohmyzsh plugins/rust
  zgenom ohmyzsh plugins/yarn

  zgenom load andrewferrier/fzf-z
  zgenom load chrissicool/zsh-256color
  zgenom load junegunn/fzf
  zgenom load srijanshetty/docker-zsh
  zgenom load unixorn/autoupdate-zgenom
  zgenom load zsh-users/zsh-autosuggestions
  zgenom load zsh-users/zsh-completions src
  zgenom load zsh-users/zsh-syntax-highlighting

  # generate the init script from plugins above
  zgenom save
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

export PATH="$PATH:$HOME/utils/"

