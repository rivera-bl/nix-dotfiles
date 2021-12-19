#!/bin/sh
set -e

currentDirectory=$(pwd)
cd ~/dev/nix-dotfiles
nix build .#homeManagerConfigurations.atlas.activationPackage
./result/activate
nix flake update
# requires root privileges
sudo nixos-rebuild switch --flake .#
cd $currentDirectory
