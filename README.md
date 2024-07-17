# Dotfiles

A set of configuration files for my laptop written with flake nix.

# Prequisites

1. [Install nix](https://github.com/DeterminateSystems/nix-installer)
2. [Install brew](https://brew.sh/)
3. [Getting started with nix](https://zero-to-nix.com/concepts)

# Setup

1. Rename the home-manager user with your own at `flake.nix` file
2. Execute Nix command

    ```
    nix --extra-experimental-features "nix-command flakes" run nix-darwin -- switch --flake .
    ```

# Issues

1. Upstream connection issue

    Find the proper internet connection or connect to the VPN server to makes the connection faster

2. Nix config already exists

    Remove the `/etc/nix/nix.conf` or rename it to be `/etc/nix/nix.conf.before-nix-darwin`