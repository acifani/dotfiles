# dotfiles

Personal dotfiles for MacOS

## Usage

### Prerequisites

- Homebrew

### Checkout files

```shell
git clone --bare git@github.com:acifani/dotfiles.git $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles checkout
```

### Finishing up

- Install [zgenom](https://github.com/jandamm/zgenom), [vim-plug](https://github.com/junegunn/vim-plug), [scm-breeze](https://github.com/scmbreeze/scm_breeze)
- Install asdf plugins

```sh
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf plugin-add terraform https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add rust https://github.com/asdf-community/asdf-rust.git
```
