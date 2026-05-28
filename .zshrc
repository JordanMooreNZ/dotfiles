# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Homebrew (prefix-aware: Apple Silicon vs Intel)
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
HIST_STAMPS="yyyy-mm-dd"

plugins=(
  git
  bundler
  copybuffer
  copypath
  history
  macos
  rake
  ruby
  zsh-autosuggestions
  zsh-syntax-highlighting
  safe-paste
)

source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Editor: Sublime, falling back to vi
if command -v subl >/dev/null 2>&1; then
  export EDITOR="subl -n -w"
else
  export EDITOR="vi"
fi

export CLICOLOR=1
export TERM=xterm-256color

# fnm (Node version manager)
command -v fnm >/dev/null 2>&1 && eval "$(fnm env --use-on-cd --shell zsh)"

# rbenv (only if installed)
command -v rbenv >/dev/null 2>&1 && eval "$(rbenv init - zsh)"

# OpenJDK 21 (only if installed via Homebrew)
[[ -d "$HOMEBREW_PREFIX/opt/openjdk@21/bin" ]] && export PATH="$HOMEBREW_PREFIX/opt/openjdk@21/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

alias src="exec zsh"
alias load-aliases="source $HOME/.aliases"
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# fzf shell integration (Ctrl+R history, Ctrl+T file search, Alt+C cd)
source <(fzf --zsh)

# GPG: only export TTY when stdin is a real terminal — pinentry-curses fallback
# needs it, but in non-tty shells `tty` returns "not a tty" and pollutes the env,
# breaking pinentry-mac.
[[ -t 0 ]] && export GPG_TTY=$(tty)

# direnv
eval "$(direnv hook zsh)"

# remove ls and directory completion highlight color
_ls_colors=':ow=01;33'
zstyle ":completion:*:default" list-colors "${(s.:.)_ls_colors}"
LS_COLORS+=$_ls_colors
