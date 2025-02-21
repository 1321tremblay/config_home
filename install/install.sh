#!/bin/bash

# Check if Stow is installed and install it if needed
if ! command -v stow &> /dev/null; then
  echo "GNU Stow is not installed. Installing..."
  sudo pacman -Syu --noconfirm stow
else
  echo "GNU Stow is already installed."
fi

# Pull the config_home repository
git clone --recurse-submodules git@github.com:1321tremblay/config_home.git ~/personal/config_home

# Initialize and update submodules
cd ~/personal/config_home
git submodule update --init --recursive

# Create symbolic links using Stow
SOURCE_DIR=~/personal/config_home/xdg_config_home
TARGET_DIR=~/.config

# Ensure target directory exists
mkdir -p $TARGET_DIR

# Use Stow to create symbolic links
cd $SOURCE_DIR
for DIR in */ ; do
  stow -t $TARGET_DIR $DIR
  echo "Stowed $DIR"
done

# Check and add ZDOTDIR to /etc/zsh/zshenv
ZSHENV_FILE=/etc/zsh/zshenv
ZDOTDIR_LINE='export ZDOTDIR="$HOME/.config/zsh"'

if grep -qF "$ZDOTDIR_LINE" "$ZSHENV_FILE"; then
  echo "$ZDOTDIR_LINE is already present in $ZSHENV_FILE"
else
  echo "$ZDOTDIR_LINE is not present in $ZSHENV_FILE. Adding it..."
  echo "$ZDOTDIR_LINE" | sudo tee -a "$ZSHENV_FILE"
  echo "$ZDOTDIR_LINE added to $ZSHENV_FILE"
fi

echo "Installation and configuration completed successfully!"

