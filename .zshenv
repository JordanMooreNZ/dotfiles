# Loaded for all zsh sessions (login, interactive, scripts) before .zshrc.
# Keep this minimal — only things every session needs.

# Ensure GPG knows which terminal to prompt on (required for commit signing).
export GPG_TTY=$(tty)
