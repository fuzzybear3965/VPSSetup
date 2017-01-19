# VPSSetup
How to get my VPS set up painlessly each time

## Enable autocomplete
Tab completion for root isn't enabled by default. Navigate to ~/.bashrc and enable tab completion.

## Installing Software
1. nginx
1. git
1. vim

## Create users
1. john
1. git

john will be the general permission-less user whose home directory will store the website and other random files.
git will be the user that will store different git repositories (possibly set up with webhooks to deploy to ~/john)
