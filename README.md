# dotfiles

Personal dotfiles for macOS and Linux, managed with [chezmoi](https://www.chezmoi.io/).

## Setup on a new machine

1. macOS only: install [Homebrew](https://brew.sh/).
2. Install [chezmoi](https://www.chezmoi.io/install/). On Linux also install [mise](https://mise.jdx.dev/getting-started.html); on macOS the Brewfile does it.
3. Apply, answering the prompts (dev tools, docker helpers, work email):

   ```shell
   chezmoi init --apply acifani
   ```

   Or without prompts (the keys are the prompt text):

   ```shell
   chezmoi init --apply \
     --promptBool "Install dev tools=false,Install docker helpers=true,Sign git commits with SSH=false" \
     --promptString "Git email=me@example.com,Git email for ~/work (empty for none)=" \
     acifani
   ```

## Machine flags

```shell
chezmoi init              # answer newly added prompts
chezmoi edit-config       # change an answer (dev, docker, workEmail...), then apply
chezmoi data              # show this machine's answers
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
