# dotfiles

Personal dotfiles for macOS and Linux, managed with [chezmoi](https://www.chezmoi.io/).

## Setup on a new machine

1. macOS only: install [Homebrew](https://brew.sh/).
2. Install [chezmoi](https://www.chezmoi.io/install/).
3. Apply:

   ```shell
   chezmoi init --apply acifani
   ```

## Day to day

```shell
chezmoi edit ~/.zshrc     # edit the source, not the target
chezmoi diff              # preview
chezmoi apply             # write changes to $HOME
chezmoi re-add            # pull edits made directly in $HOME back into the source
chezmoi cd                # shell in the source repo to commit/push
chezmoi update            # git pull + apply
```
