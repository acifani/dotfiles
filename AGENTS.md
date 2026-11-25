# dotfiles

Every file in the repo root without a leading dot is deployed to `$HOME`; list repo-only files in `.chezmoiignore`.

Rules for writing and reviewing changes:

- **README:** holds instructions a reader can't get from the source. What the code does is read from the code.
- **Prerequisites:** when a flag needs a tool, that flag installs it (mise config or a `.chezmoiscripts` script), so the README never lists it.
- **Errors:** let the shell report a missing tool or a failed command. Write a custom check only when its message says something the shell's doesn't.
- **Least surprise:** a flag does what someone answering its prompt would expect.
