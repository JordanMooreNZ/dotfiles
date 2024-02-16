#!/bin/bash

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# ln -sf "$DOTFILES_DIR/.bashrc" ~
# ln -sf "$DOTFILES_DIR/.bash_profile" ~

# load aliases
ln -sf "$DOTFILES_DIR/.aliases" ~
source ~/.aliases

# set gitconfig defaults
git config --global push.autoSetupRemote true
git config --global core.pager cat
git config --global core.editor "code --wait"

zshrc() {
    echo "==========================================================="
    echo "             cloning zsh-autosuggestions                   "
    echo "-----------------------------------------------------------"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    echo "==========================================================="
    echo "             cloning zsh-syntax-highlighting               "
    echo "-----------------------------------------------------------"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    echo "==========================================================="
    echo "             cloning powerlevel10k                         "
    echo "-----------------------------------------------------------"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    echo "==========================================================="
    echo "             import zshrc                                  "
    echo "-----------------------------------------------------------"
    ln -sf "$DOTFILES_DIR/.zshrc" ~
    echo "==========================================================="
    echo "             import powerlevel10k                          "
    echo "-----------------------------------------------------------"
    ln -sf "$DOTFILES_DIR/.p10k.zsh" ~
}

zshrc

# make directly highlighting readable - needs to be after zshrc line
echo "" >> $DOTFILES_DIR/.zshrc
echo "# remove ls and directory completion highlight color" >> $DOTFILES_DIR/.zshrc
echo "_ls_colors=':ow=01;33'" >> $DOTFILES_DIR/.zshrc
echo 'zstyle ":completion:*:default" list-colors "${(s.:.)_ls_colors}"' >> $DOTFILES_DIR/.zshrc
echo 'LS_COLORS+=$_ls_colors' >> $DOTFILES_DIR/.zshrc

# add source command to .bashrc
# echo "if [ -f ~/.aliases ]; then" >> ~/.bashrc
# echo "    source ~/.aliases" >> ~/.bashrc
# echo "fi" >> ~/.bashrc

# source .bashrc to load aliases into current session
# source ~/.bashrc
