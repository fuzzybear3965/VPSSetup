# VPS Setup
How to get my VPS set up painlessly each time

## Users
1. `adduser john`
1. `visudo` (add `john	ALL=(ALL:ALL) ALL` below the corresponding line for root)
1. `adduser git`
1. `usermod -a -G www-data git` (used so it can copy to `/home/john/website/`)

john will be the general permission-less user whose home directory will store
the website and other random files.
git will be the user that will store different git repositories (possibly set up
with webhooks to deploy to ~/john)

## SSH Keys
1. `su john`
1. Generate john's keys: `ssh-keygen -t rsa -b 4096 -C "john@theline.design"`
1. Check the key's password: `ssh-keygen -y`
1. Add the keys to all of the servers that require them

## ~/website/
1. `mkdir /home/john/website/`
1. `chown -R john:www-data /home/john/website/`
1. `chmod -R 0770 /home/john/website/`

## Software
### apt
1. nginx
1. git
1. vim-gtk
1. tmux
1. zsh
1. letsencrypt
1. ufw
1. nodejs
1. gcc
1. make


### gem
1. jekyll

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

## DNS Records
It's important that the DNS records are updated before letsencrypt. SSL
certification requires a challenge to be successfully answered from the domain of
your website. If the DNS records point to an old IP than this won't work. It
will look as if someone else owns your website.

| DNS Record Types | Host | Value | TTL | 
|---|---|---|---|
| A+ Dynamic DNS Record | @ | \<_Current IP_\> | Automatic |
| CNAME Record | www | theline.design. | Automatic |
| TXT Record | @ | google-site-verification=387ffIYWxviWZnerAZxsWvz8_OFzzpEg85zyKTRtYsM | Automatic |

To accommodate changing the IP automatically, I have written a bash script
`dyndns.sh`.

1. Edit `~/VPSSetup/dyndns.sh` to include the domain name registrar's provided API key.
1. `sudo chown root:root ~/VPSSetup/dyndns.sh`
1. `sudo chmod 700 ~/VPSSetup/dyndns.sh`
1. `sudo cp ~/VPSSetup/dyndns.sh /home/root/`
1. `echo "5 * * * * root /bin/bash /home/root/dyndns.sh >> /var/log/dyndns.log 2>&1"`

## letsencrypt
1. `sudo letsencrypt certonly -a webroot --webroot-path=/home/john/website -d theline.design -d www.theline.design`
1. `sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048`
1. `sudo ufw enable`
1. `sudo ufw allow 'Nginx Full'`
1. (if exists) `sudo ufw delete allow 'Nginx HTTP'`
1. `sudo nginx -t`
1. `sudo systemctl restart nginx`
1. Visit [Qualys SSL Labs Report](https://www.ssllabs.com/ssltest/analyze.html?d=theline.design)
1. `sudo chown root:root ~/VPSSetup/letsencrypt-renew.sh`
1. `sudo chmod 700 ~/VPSSetup/letsencrypt-renew.sh`
1. `sudo cp ~/VPSSetup/letsencrypt-renew.sh /home/root/`
1. `echo "30 2 * * 1 root /bin/bash /home/root/letsencrypt-renew.sh >> /var/log/letsencrypt-renew.log 2>&1"`
1. Uncomment the SSL blocks in `/etc/nginx/sites-available/theline.design`
1. Comment the root statement in the http block
1. `sudo systemctl restart nginx`

## webhook
1. `su git && cd ~`
1. `ssh-keygen -t rsa -b 4096 -C "git@theline.design"'`
1. `git clone --bare https://github.com/fuzzybear3965/website.git website.git`
1. `su root`
1. `cp /home/john/VPSSetup/post-receive /home/git/website.git/hooks/`
1. `chown git:git /home/git/website.git/hooks/post-receive`
1. `exit`
