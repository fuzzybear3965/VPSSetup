# VPS Setup
How to get my VPS set up painlessly each time

## Users
1. john

  `>> adduser john `

  `>> visudo` (add `john	ALL=(ALL:ALL) ALL` below the corresponding line for root)
1. git

  `>> adduser git `

john will be the general permission-less user whose home directory will store
the website and other random files.
git will be the user that will store different git repositories (possibly set up
with webhooks to deploy to ~/john)

## SSH Keys
1. `su john`
1. Generate john's keys: `ssh-keygen -t rsa -b 4096 -C "john@theline.design"`
1. Check the key's password: `ssh-keygen -y`
1. Add the keys to all of the servers that require them

## Software
1. nginx
1. git
1. vim
1. tmux
1. zsh

## Clone vimrc repository
1. Configure git username and email.

  ```
  >> git config --global --edit
  # This is Git's per-user configuration file.
  [user]
   name = John Rinehart
   email = johnrichardrinehart@gmail.com
  ```
1. `git clone git@github.com:fuzzybear3965/vimrc.git ~/.vim`

## Terminal
1. `chsh $(which zsh)`
1. `git clone git@github.com:fuzzybear3965/VPSSetup.git ~/VPSFiles`
1. `mv ~/VPSFiles/.zshrc ~`
