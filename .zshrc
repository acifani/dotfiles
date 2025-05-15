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

. ~/.env.zsh
. ~/.functions.zsh
. ~/.plugins.zsh
. ~/.work.zsh
. ~/.aliases.zsh

# prompt
eval "$(starship init zsh)"

export PATH="$PATH:$HOME/utils/"

# BEGIN_AWS_SSO_CLI

# AWS SSO requires `bashcompinit` which needs to be enabled once and
# only once in your shell.  Hence we do not include the two lines:
#
# autoload -Uz +X compinit && compinit
# autoload -Uz +X bashcompinit && bashcompinit
#
# If you do not already have these lines, you must COPY the lines
# above, place it OUTSIDE of the BEGIN/END_AWS_SSO_CLI markers
# and of course uncomment it

__aws_sso_profile_complete() {
    local _args=${AWS_SSO_HELPER_ARGS:-}
    _multi_parts : "($(yes | /opt/homebrew/bin/aws-sso list --csv $_args Profile 2>/dev/null))"
}

aws-sso-profile() {
    local _args=${AWS_SSO_HELPER_ARGS:-}
    if [ -n "$AWS_PROFILE" ]; then
        echo "Unable to assume a role while AWS_PROFILE is set"
        return 1
    fi
    eval $(/opt/homebrew/bin/aws-sso $_args eval -p "$1")
    if [ "$AWS_SSO_PROFILE" != "$1" ]; then
        return 1
    fi
}

aws-sso-clear() {
    local _args=${AWS_SSO_HELPER_ARGS:-}
    if [ -z "$AWS_SSO_PROFILE" ]; then
        echo "AWS_SSO_PROFILE is not set"
        return 1
    fi
    eval $(/opt/homebrew/bin/aws-sso eval $_args -c)
}

compdef __aws_sso_profile_complete aws-sso-profile
complete -C /opt/homebrew/bin/aws-sso aws-sso

# END_AWS_SSO_CLI

