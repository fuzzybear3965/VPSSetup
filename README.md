# VPSSetup
How to get my VPS set up painlessly each time

## Autocomplete
Tab completion for root isn't enabled by default. Navigate to ~/.bashrc and enable tab completion.

## Software
1. nginx
1. git
1. vim

## Users
1. john
  `>> adduser john `
  `>> visudo ` (add `john	ALL=(ALL:ALL) ALL` below the corresponding line for root)
1. git
  `>> adduser git `

john will be the general permission-less user whose home directory will store the website and other random files.
git will be the user that will store different git repositories (possibly set up with webhooks to deploy to ~/john)

## SSH Keys
1.  `su john`
1.  Generate john's keys: `ssh-keygen -t rsa -b 4096 -C "john@theline.design"`
1.  Check the key's password: `ssh-keygen -y`

## Clone Vim repository
1. `git clone git@github.com:fuzzybear3965/vimrc.git`
