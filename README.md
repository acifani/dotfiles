# dotfiles

Personal dotfiles for macOS and Linux, managed with [chezmoi](https://www.chezmoi.io/).

## Setup on a new machine

1. macOS only: install [Homebrew](https://brew.sh/).
2. Install [chezmoi](https://www.chezmoi.io/install/). On Linux also install [mise](https://mise.jdx.dev/getting-started.html); on macOS the Brewfile does it.
3. Apply:

   ```shell
   chezmoi init --apply acifani
   ```

## Machine flags

Machines differ by feature flags, never by machine name. `chezmoi init` asks each
question once and stores the answer in `~/.config/chezmoi/chezmoi.toml`. The OS is not
asked: templates read `.chezmoi.os`.

| Prompt                                  | Key           | Adds                                                                                           |
| --------------------------------------- | ------------- | ---------------------------------------------------------------------------------------------- |
| Git email                               | `email`       | personal git identity                                                                          |
| Git email for ~/work (empty for none)   | `workEmail`   | `includeIf "gitdir:~/work/"` switching to this email (same signing key)                        |
| Install dev tools                       | `dev`         | go, node, bun, python, pnpm, uv, ast-grep, difftastic, gh, git-filter-repo; gh/golang plugins |
| Install docker helpers                  | `docker`      | dive, `dps`, `dim`, `docker-cleanup.sh`, docker aliases and zsh plugins (not Docker itself)    |
| Sign git commits with SSH               | `signCommits` | SSH commit signing, plus a prompt for the key                                                  |

Every machine gets the baseline: zsh config (aliases, functions, starship), git config, the
`git-*` scripts and the core CLI tools through mise (rg, fd, fzf, bat, eza, zoxide, jq, delta, neovim, git-lfs).

To set up a VM without prompts, pass every answer. The flags match on the prompt text:

```shell
chezmoi init --apply \
  --promptBool "Install dev tools=false,Install docker helpers=true,Sign git commits with SSH=false" \
  --promptString "Git email=me@example.com,Git email for ~/work (empty for none)=" \
  acifani
```

After a new prompt is added, run `chezmoi init` once on each existing machine to answer it.
To change an answer, edit `~/.config/chezmoi/chezmoi.toml` and run `chezmoi apply`.

## Day to day

```shell
chezmoi edit ~/.zshrc     # edit the source, not the target
chezmoi diff              # preview
chezmoi apply             # write changes to $HOME
chezmoi re-add            # pull edits made directly in $HOME back into the source
chezmoi cd                # shell in the source repo to commit/push
chezmoi update            # git pull + apply
```
