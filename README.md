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
1. letsencrypt

*Don't forget to `sudo apt update` prior to installing.*

## vimrc repository
1. Configure git username and email.

  ```
  >> git config --global --edit
  # This is Git's per-user configuration file.
  [user]
   name = John Rinehart
   email = johnrichardrinehart@gmail.com
  ```
1. `git clone git@github.com:fuzzybear3965/vimrc.git ~/.vim`

## zsh
1. `chsh $(which zsh)`
1. `git clone git@github.com:fuzzybear3965/VPSSetup.git ~/VPSFiles`
1. `cp ~/VPSFiles/.zshrc ~`

## nginx
1. `sudo cp ~/VPSFiles/theline.design /etc/nginx/sites-available/theline.design`
1. `sudo ln -s /etc/nginx/sites-available/theline.design /etc/nginx/sites-enabled/theline.design`
1. `sudo cp ssl-params.conf ssl-theline.design.conf /etc/nginx/snippets/`

## letsencrypt
1. `sudo letsencrypt certonly -a webroot --webroot-path=/home/john/website -d theline.design -d www.theline.design`
1. `sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048`
1. `sudo ufw allow 'Nginx Full'`
1. `sudo ufw delete allow 'Nginx HTTP'`
1. `sudo nginx -t`
1. `sudo systemctl restart nginx`
1. Visit [Qualys SSL Labs Report](https://www.ssllabs.com/ssltest/analyze.html?d=theline.design)
1. `sudo chown root:root ~/VPSSetup/letsencrypt-renew.sh`
1. `sudo chmod 600 ~/VPSSetup/letsencrypt-renew.sh`
1. `sudo cp ~/VPSSetup/letsencrypt-renew.sh /home/root/`
1. `echo "30 2 * * 1 root /bin/bash /home/root/letsencrypt-renew.sh"
