### Added by Zinit's installer
if [[ ! -f $HOME/.config/zsh/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.config/zsh/.zinit" && command chmod g-rwX "$HOME/.config/zsh/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.config/zsh/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.config/zsh/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk


if [ "$TERM" = "linux" ] || [ "$TERM" = "dvtm-256color" ] || [ "$TERM" = "dvtm" ] || [ "$TERM" = "fbpad-256" ]; then
    export NCURSES_NO_UTF8_ACS=1
    # multiline prompt
    #PS1_viins="%B%F{red}%M%f%b:%F{cyan}%~%f"$'\n'"%B%F{green}>%f%b "
    #PS1_vicmd="%B%F{red}%M%f%b:%F{cyan}%~%f"$'\n'"%B%F{green}<%f%b "
    PS1_viins="%B%F{red}%M%f%b:%F{cyan}%~%f %B%F{green}>%f%b "
    PS1_vicmd="%B%F{red}%M%f%b:%F{cyan}%~%f %B%F{green}<%f%b "
    export RPS1='[%(?.%F{green}.%F{red})%?%f]'
    # export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=5"
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
    echo -en "\e]P1e73c50" #darkred
    echo -en "\e]P2a6e22e" #darkgreen
    echo -en "\e]P3e6db74" #brown
    echo -en "\e]P466d9ef" #darkblue
    echo -en "\e]P5ae81ff" #darkmagenta
    echo -en "\e]P6a1efe4" #darkcyan
    echo -en "\e]P7e8e8e3" #lightgrey
    echo -en "\e]P864645e" #darkgrey
    echo -en "\e]P9f92772" #red
    echo -en "\e]PA9ec400" #green
    echo -en "\e]PBe7c547" #yellow
    echo -en "\e]PC7aa6da" #blue
    echo -en "\e]PDb77ee0" #magenta
    echo -en "\e]PE54ced6" #cyan
    echo -en "\e]PFffffff" #white
    clear #for background artifacting
else
    zinit light romkatv/powerlevel10k
fi

zinit light "AtomToast/zsh-vim-mode"

zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

zinit light "zdharma/fast-syntax-highlighting"

zinit light "skywind3000/z.lua"

zinit snippet 'https://github.com/robbyrussell/oh-my-zsh/raw/master/plugins/git/git.plugin.zsh'

zinit ice blockf
zinit load zsh-users/zsh-completions

# enable instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Turn stderror red (uses stderred)
# export LD_PRELOAD=/usr/lib/libstderred.so

# Case and hypen insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'

# Selection menu for completions (press tab twice)
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)
setopt completeinword
setopt alwaystoend
setopt nolistambiguous

# Use vim keys for the completion menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# Don't kill background jobs when exiting
setopt nohup

# Don't overwrite existing files with >
setopt noclobber

# Don't remove slashes, I think it might break autocompletions sometimes
setopt noautoremoveslash

# disable ' do you wish to see all x possibilities'
LISTMAX=9999999

# Disable ctrl+s freezing the terminal
setopt noflowcontrol

# shortcut to insert doas
insert_doas() { zle beginning-of-line; zle -U "doas " }
zle -N insert-doas insert_doas
bindkey '^s'    insert-doas

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
alias sudo="doas"
alias vim="nvim"
alias vi="nvim"
alias v="nvim"
alias sv="doedit"
alias i="devour sxiv"
alias p="devour zathura"
alias m="devour mpv"
alias d="doas"
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
alias rm='rm -vI'
alias tb='nc termbin.com 9999'
alias flex='st -e htop&; st -e unimatrix -afs 96 &; ll'
alias flex++='st -e htop &; st -e unimatrix -afs 96 &;
              st -e nvim ~/git/suckless/st/st.h 2>/dev/null &;
              st & 2>/dev/null;sleep 1 && xdotool key super+i;ll'
alias tsurf='tabbed -c surf -e & disown'

alias vifm="vifmrun"
alias f="vifm"
alias ff="vifm ."

alias -s pdf=zathura
alias -s zip="unzip -l"
alias -s rar="unrar l"
alias -s tar="tar tf"
alias -s tar.gz="echo "

alias -g G="| grep"

alias zf='z -I'      # use fzf to select in multiple matches

# load powerlevel10k config
[[ -f ~/.config/zsh/.p10k.zsh ]] && source ~/.config/zsh/.p10k.zsh

# fix right side of prompt floating
ZLE_RPROMPT_INDENT=0

# enable autocd so I can navigate directories without cd (especially useful with ..)
setopt AUTO_CD

# set short keytimeout for quick mode switching
KEYTIMEOUT=1

# setting up zsh history file
export HISTFILE="$ZDOTDIR/.zsh_history"
export SAVEHIST=10000
export HISTSIZE=50000
setopt hist_expire_dups_first
setopt appendhistory
setopt inc_append_history
setopt share_history
setopt hist_ignore_space
setopt hist_reduce_blanks

# enable z.lua enhanced matching
export _ZL_MATCH_MODE=1

# load tetris for the lulz
autoload -Uz tetriscurses

[ ! "$TERM" = "fbpad-256" ] && \
    # set cursor depending on mode \
    MODE_CURSOR_VICMD="block" \
    MODE_CURSOR_VIINS="bar" \
    MODE_CURSOR_SEARCH="underline"

# some bling for le terminal
export PF_INFO="ascii title os host wm editor shell uptime"
[ ! "$TERM" = "linux" ] && wmname dwm
pfetch

# Fix java applications
[ ! "$TERM" = "linux" ] && wmname LG3D
