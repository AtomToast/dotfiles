# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private scripts if it exists
if [ -d "$HOME/.local/bin/scripts" ] ; then
    PATH="$HOME/.local/bin/scripts:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# add cargo to PATH
export PATH="$HOME/.cargo/bin:$PATH"

# add vifm scripts to path
export PATH="$HOME/.config/vifm/scripts:$PATH"

# add ~/bin to path
export PATH="$HOME/bin:$PATH"

# set default programs
export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="firefox"
export READER="zathura"
export FILEMANAGER="vifmrun"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# set desktop theme configuration options
export GTK_USE_PORTAL=1
export QT_QPA_PLATFORMTHEME="qt5ct"

# set various default and config file paths
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export _ZL_DATA="$XDG_CACHE_HOME/.z"
export INPUTRC="$XDG_CONFIG_HOME/inputrc"
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch-config"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"

export TDESKTOP_DISABLE_TRAY_COUNTER=1
export SUDO_ASKPASS="$HOME/bin/dmenupass"

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx > /dev/null 2>&1
fi
