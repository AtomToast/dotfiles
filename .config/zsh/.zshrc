source ~/.config/zplug/init.zsh

zplug "romkatv/powerlevel10k", as:theme, depth:1

zplug "AtomToast/zsh-vim-mode"

zplug "zsh-users/zsh-autosuggestions"

zplug "zdharma/fast-syntax-highlighting"

zplug "skywind3000/z.lua"

zplug "plugins/git",   from:oh-my-zsh


# Install plugins if there are plugins that have not been installed
if ! zplug check; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# seems to not like my fix for mode sensitive cursors at the bottom
# # enable instant prompt
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Then, source plugins and add commands to $PATH
zplug load

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'

# ex - archive extractor
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# aliases (duh)
alias ls="exa -F"
alias lt="ls --tree --level=2"
alias lg="ls --grid"
alias ll="ls -lahF --git"
alias llt="ll --tree --level=2"
alias llg="ll --grid"
alias cat="bat"
alias grep="rg"
alias vim="nvim"
alias vi="nvim"
alias v="nvim"
alias sv="sudoedit"
alias i="sxiv"
alias p="zathura"
alias vcfg="nvim ~/.config/nvim/init.vim"
alias zcfg="nvim ~/.config/zsh/.zshrc"
alias :q="exit"
alias pfzf="fzf --preview=\"bat {} --color=always\""
alias netris="ssh netris.rocketnine.space"
alias netron="ssh sshtron.zachlatta.com"
alias diff="diff --color=always"
alias l="sudo updatedb && locate"
alias cp='cp -i'
alias mv='mv -i'
alias flex='st -e htop&; st -e unimatrix -afs 96 &; ll'
alias flex++='st -e htop &; st -e unimatrix -afs 96 &;
              st -e nvim ~/git/st/st.h 2>/dev/null &;st &;ll'

export PATH="$HOME/.config/vifm/scripts:$PATH"
alias vifm="vifmrun"
alias f="vifm"

alias -s pdf=zathura
alias -s zip="unzip -l"
alias -s rar="unrar l"
alias -s tar="tar tf"
alias -s tar.gz="echo "

# load powerlevel10k config
[[ -f ~/.config/zsh/.p10k.zsh ]] && source ~/.config/zsh/.p10k.zsh


# enable autocd so I can navigate directories without cd (especially useful with ..)
setopt AUTO_CD

# set short keytimeout for quick mode switching
KEYTIMEOUT=1

# add ~/bin to path
export PATH="$HOME/bin:$PATH"

# set manpager to bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# setting up zsh history file
export HISTFILE="$ZDOTDIR/.zsh_history"
export SAVEHIST=10000
export HISTSIZE=50000
setopt hist_expire_dups_first

# load tetris for the lulz
autoload -Uz tetriscurses



# set cursor depending on mode
MODE_CURSOR_VICMD="block"
MODE_CURSOR_VIINS="bar"
MODE_CURSOR_SEARCH="underline"

# Fix java applications
wmname LG3D

neofetch
