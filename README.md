# dotfiles

My personal macOS / zsh setup: oh-my-zsh + [powerlevel10k](https://github.com/romkatv/powerlevel10k)
(rainbow style), aliases, git config, Homebrew packages, and an iTerm2 profile.
Works on both Apple Silicon and Intel Macs.

Originally based on [joshjohanning/dotfiles](https://github.com/joshjohanning/dotfiles)
(see the [blog post](https://josh-ops.com/posts/github-codespaces-powerlevel10k/)).

## Set up a new Mac

```bash
# 1. Install the Xcode command line tools (gives you git)
xcode-select --install

# 2. Clone this repo to ~/dotfiles (the path the configs expect)
git clone git@github.com:JordanMooreNZ/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 3. Run the installer (idempotent — safe to re-run)
./install.sh
```

`install.sh` will:

- install Homebrew (if missing) and everything in the `Brewfile`
  (including the `MesloLGS NF` font and iTerm2),
- install oh-my-zsh, the zsh plugins, and powerlevel10k,
- symlink `.zshrc`, `.zshenv`, `.p10k.zsh`, `.gitconfig`, and `.aliases` into `$HOME`.

### 4. Configure iTerm2 (for the powerlevel10k look)

1. iTerm2 → Settings → Profiles → **Other Actions → Import JSON Profiles** →
   select `iterm2-profile.json`.
2. Make it the default profile.
3. The profile already specifies the font **MesloLGS NF** (installed by the
   Brewfile). If glyphs/separators look wrong, set it manually under
   Profiles → Text → Font → **MesloLGS NF**.

Open a new tab (or run `exec zsh`) and you should get the rainbow prompt with no
startup errors.

### 5. GPG commit signing

`.gitconfig` enables signed commits (`commit.gpgsign = true`). On a machine
without a GPG key set up, commits will fail. Either
[set up a signing key](https://docs.github.com/en/authentication/managing-commit-signature-verification),
or disable signing locally:

```bash
git config --global commit.gpgsign false
```

## Manual symlinks (alternative to install.sh)

```bash
for f in .zshrc .zshenv .p10k.zsh .gitconfig .aliases; do
  ln -sf ~/dotfiles/$f ~/$f
done
```

To remove them: `unlink ~/.zshrc` (and so on for each file).

## Updating the exported configs

```bash
# Brewfile (formulae, casks, VS Code extensions)
brew bundle dump --file=~/dotfiles/Brewfile --force

# iTerm2 profile (iTerm2 → Settings → Profiles → Other Actions → Save Profile as JSON)
# overwrite iterm2-profile.json

# VS Code profile: Code → Settings → Profiles → Export → Default.code-profile

# gh CLI extensions
gh extension list | awk '{print $3}' > ~/dotfiles/gh-extensions-list.txt
```

## GitHub Codespaces

This repo also works as a Codespaces dotfiles repo — Codespaces runs `install.sh`
automatically. See [this guide](https://burkeholland.github.io/posts/codespaces-dotfiles/).
