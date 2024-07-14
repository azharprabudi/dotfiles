# Dotfiles

A set of configuration files for my laptop written with flake nix.

# Prequisites

1. [Install nix](https://github.com/DeterminateSystems/nix-installer)
2. [Getting started with nix](https://zero-to-nix.com/concepts)

# Setup

Actually the execution script was very simple, just by executing the command below
```
nix --extra-experimental-features "nix-command flakes" run nix-darwin -- switch --flake .
```
