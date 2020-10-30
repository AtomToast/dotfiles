#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# export EDITOR="/usr/bin/nvim"
source ~/.profile
if [ -e /home/kjell/.nix-profile/etc/profile.d/nix.sh ]; then . /home/kjell/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
