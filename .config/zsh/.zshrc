source ~/.config/zplug/init.zsh

if [ "$TERM" = "linux" ]; then
    # multiline prompt
    #PS1_viins="%B%F{red}%M%f%b:%F{cyan}%~%f"$'\n'"%B%F{green}>%f%b "
    #PS1_vicmd="%B%F{red}%M%f%b:%F{cyan}%~%f"$'\n'"%B%F{green}<%f%b "
    PS1_viins="%B%F{red}%M%f%b:%F{cyan}%~%f %B%F{green}>%f%b "
    PS1_vicmd="%B%F{red}%M%f%b:%F{cyan}%~%f %B%F{green}<%f%b "
    export RPS1='[%(?.%F{green}.%F{red})%?%f]'
    export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=5"
    # set cursor to non-blinking block
    echo -e "\e[?112c"

    # mode sensitive prompt
    function zle-line-init zle-keymap-select {
        PS1="${${KEYMAP/vicmd/$PS1_vicmd}/(main|viins)/$PS1_viins}"
        PS2="${${KEYMAP/vicmd/< }/(main|viins)/> }"
        zle reset-prompt
    }

    zle -N zle-line-init
    zle -N zle-keymap-select
    echo -en "\e]P0282828" #black
    echo -en "\e]P875715e" #darkgrey
    echo -en "\e]P1f92672" #darkred
    echo -en "\e]P9f92672" #red
    echo -en "\e]P2a6e22e" #darkgreen
    echo -en "\e]PAa6e22e" #green
    echo -en "\e]P3f4bf75" #brown
    echo -en "\e]PBf4bf75" #yellow
    echo -en "\e]P466d9ef" #darkblue
    echo -en "\e]PC66d9ef" #blue
    echo -en "\e]P5ae81ff" #darkmagenta
    echo -en "\e]PDae81ff" #magenta
    echo -en "\e]P6a1efe4" #darkcyan
    echo -en "\e]PEa1efe4" #cyan
    echo -en "\e]P7f8f8f2" #lightgrey
    echo -en "\e]PFf9f8f5" #white
    clear #for background artifacting
else
    zplug "romkatv/powerlevel10k", as:theme, depth:1
fi

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

# enable instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Then, source plugins and add commands to $PATH
zplug load

# Case and hypen insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'

# Selection menu for completions (press tab twice)
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Use vim keys for the completion menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

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

gln () {
        git --no-pager log --graph --pretty=format:"%C(auto)%h -%d %s %Cgreen(%cr) %Cblue<%an>%Creset" -5 "$@"
        printf "\n"
}

# aliases (duh)
alias ls="exa -F --group-directories-first --icons"
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
alias md="mkdir -p"
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -v'
alias flex='st -e htop&; st -e unimatrix -afs 96 &; ll'
alias flex++='st -e htop &; st -e unimatrix -afs 96 &;
              st -e nvim ~/git/st/st.h 2>/dev/null &;st &;ll'

export PATH="$HOME/.config/vifm/scripts:$PATH"
alias vifm="vifmrun"
alias f="vifm"
alias ff="vifm ."

alias -s pdf=zathura
alias -s zip="unzip -l"
alias -s rar="unrar l"
alias -s tar="tar tf"
alias -s tar.gz="echo "

alias zf='z -I'      # use fzf to select in multiple matches

# load powerlevel10k config
[[ -f ~/.config/zsh/.p10k.zsh ]] && source ~/.config/zsh/.p10k.zsh

# fix right side of prompt floating
ZLE_RPROMPT_INDENT=0

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
setopt inc_append_history

# enable z.lua enhanced matching
export _ZL_MATCH_MODE=1

# load tetris for the lulz
autoload -Uz tetriscurses

# set cursor depending on mode
MODE_CURSOR_VICMD="block"
MODE_CURSOR_VIINS="bar"
MODE_CURSOR_SEARCH="underline"

# Fix java applications
wmname LG3D

neofetch
