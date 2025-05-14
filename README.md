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

Run the `install.sh` script
