# dotfiles

Personal dotfiles for macOS and Linux, managed with [chezmoi](https://www.chezmoi.io/).

## Setup on a new machine

1. macOS only: install [Homebrew](https://brew.sh/).
2. Install [chezmoi](https://www.chezmoi.io/install/) and [mise](https://mise.jdx.dev/getting-started.html). Neither is installed by this repo.
3. Apply, answering the prompts (profile, git emails, dev tools, docker helpers, cask directory, coding harnesses):

   ```shell
   chezmoi init --apply acifani
   ```

   Or without prompts (the keys are the prompt text):

   ```shell
   chezmoi init --apply \
     --promptChoice "Profile=work" \
     --promptBool "Install dev tools=false,Install docker helpers=true,Sign git commits with SSH=false,Configure Claude Code plugins and skills=true,Configure Codex plugins and skills=true,Configure OpenCode plugins and skills=false" \
     --promptString "Git email=me@example.com,Git email for ~/work (empty for none)=me@work.com,Cask install directory=~/Applications" \
     acifani
   ```

   `Git email for ~/work` is only asked with the `work` profile and `Cask install directory` only on macOS; answers to prompts that aren't asked are ignored.

## Machine flags

```shell
chezmoi init              # answer newly added prompts; re-run after changing the profile
chezmoi edit-config       # change an answer (profile, dev, docker, appdir, workEmail...), then apply
chezmoi data              # show this machine's answers
```

## Coding harnesses

Turn on the `claude`, `codex` and `opencode` flags for the harnesses this machine uses.
Install `npx` (node comes with the dev flag) and, for Codex, `codex` first: without them `chezmoi apply` fails at that step.

```shell
chezmoi edit ~/.claude/settings.json             # Claude plugins and settings
chezmoi edit ~/.claude/statusline-command.sh     # Claude status line
chezmoi edit ~/.config/opencode/opencode.json    # OpenCode plugins and skills
chezmoi edit ~/.codex/config.toml                # Codex settings; adding one drops the file's comments and sorts its keys
chezmoi cd                                       # Codex plugins and shared skills live in .chezmoiscripts/
```

To drop a plugin, skill or setting, remove it from its list, then uninstall or change it by hand: apply puts back any Claude or OpenCode entry that is still listed.

## Day to day

```shell
chezmoi edit ~/.zshrc     # edit the source, not the target
chezmoi diff              # preview
chezmoi apply             # write changes to $HOME
chezmoi re-add            # pull edits made directly in $HOME back into the source
chezmoi cd                # shell in the source repo to commit/push
chezmoi update            # git pull + apply
```
