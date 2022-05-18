#!/bin/bash

# clone dotfiles
cd ~
mkdir -p ~/.ssh && touch ~/.ssh/known_hosts
ssh-keyscan github.com > ~/.ssh/known_hosts
git clone git@github.com:cheeseNA/dotfiles.git

# nvim settings
mkdir -p ~/.config/nvim/
ln -s ~/dotfiles/.config/nvim/init.vim ~/.config/nvim/init.vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c PlugInstall -c q -c q

# git settings
cat <(echo -e "\n") ~/.gitconfig >> ~/dotfiles/.gitconfig
rm -rf ~/.gitconfig
ln -s ~/dotfiles/.gitconfig ~/.gitconfig

# tmux settings
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins

# powerlevel10k settings
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
ln -s ~/dotfiles/.p10k.zsh ~/.p10k.zsh

# zsh settings
ln -s ~/dotfiles/.zprofile ~/.zprofile
ln -s ~/dotfiles/.zshrc ~/.zshrc

# poetry settings
poetry self update --preview
poetry completions zsh > ~/.zfunc/_poetry
echo export 'PATH="$HOME/.poetry/bin:$PATH"' >> ~/.zshrc

# bat settings
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat
echo export 'PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc

# fzf settings
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --xdg --completion --key-bindings --no-update-rc

# switch to zsh
chsh -s $(which zsh)
