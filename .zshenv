# Loaded for all zsh sessions (login, interactive, scripts) before .zshrc.
# Keep this minimal — only things every session needs.
#
# Note: GPG_TTY used to live here, but `tty` returns "not a tty" in
# non-interactive shells, which pollutes child shells and breaks pinentry-mac.
# It's now set conditionally in .zshrc (guarded by `[[ -t 0 ]]`).
