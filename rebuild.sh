#!/bin/sh
cd ~/dev/nix-dotfiles
sudo nixos-rebuild switch -I nixos-config=./configuration.nix
