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

The `claude`, `codex` and `opencode` flags manage each harness's plugins and
skills, merged into its own config file so the harness's own edits survive.
The lists live in `dot_claude/modify_settings.json`, `.chezmoiscripts/*-codex-plugins.sh.tmpl`,
`dot_config/opencode/modify_private_opencode.jsonc` and `.chezmoiscripts/*-agent-skills.sh.tmpl`.
Applies only add: drop an entry, or turn a flag off, and uninstall by hand.
Why it works this way: `docs/research/harness-config.md`.

## Day to day

```shell
chezmoi edit ~/.zshrc     # edit the source, not the target
chezmoi diff              # preview
chezmoi apply             # write changes to $HOME
chezmoi re-add            # pull edits made directly in $HOME back into the source
chezmoi cd                # shell in the source repo to commit/push
chezmoi update            # git pull + apply
```
