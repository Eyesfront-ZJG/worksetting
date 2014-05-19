# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd beep extendedglob notify HIST_IGNORE_DUPS
bindkey -v
# End of lines configured by zsh-newuser-install
#PROMPT='%{ [01;36m%}%n%{[01;34m%}@%{[01;35m%}%M %{[01;33m%}%D %T %{[01;32m%}%/
#%{[01;31m%}>>%{[m%}'
RPROMPT='%B%F{yellow}%T%f %F{blue}%(?..%? )%(1j.[%j&] .)%f%F{cyan}%n%f %F{red}%f%b'
PROMPT='%B%F{green}%/%f@%F{magenta}%M%f %F{white}%#%f%b '
eval $(dircolors -b)
# The following lines were added by compinstall

zstyle ':completion:*' auto-description 'Specify: %d'
zstyle ':completion:*' completer _expand _complete
#zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' expand suffix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format '%B%F{green}--- Completing %d ---%f%b'
zstyle ':completion:*' ignore-parents parent pwd directory
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'm:{a-z}={A-Z}'
zstyle ':completion:*' preserve-prefix '//[^/]##/'
#zstyle :compinstall filename '/home/hsys/.zshrc'

autoload -Uz compinit
compinit -i
# End of lines added by compinstall

#bindkey "\e[3~" delete-char
bindkey "\e[7~" beginning-of-line
bindkey "\e[8~" end-of-line
bindkey "\e[3~" delete-char
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-search-forward
bindkey '^[[C' forward-char
bindkey '^[[D' backward-char
bindkey '^K' forward-word
bindkey '^J' backward-word
bindkey "^H" kill-line
bindkey "^[d" delete-word

alias ls="ls --color=auto --show-control-chars"
alias less="less -r"
alias rm="rm -v"
alias ll="ls -alh"
alias l="ls -lh"
alias cp="cp -vi"
#alias grep="grep -nH --color=auto"
alias grep="grep --color=auto"
alias mv="mv -iv"
alias ping="ping -n"
alias tmux="tmux -2 -u"
alias rsync="rsync -avzP"
alias ssh="autossh"
alias gdf="git difftool"
alias gck="git checkout"
alias psauxg="ps aux | grep -v grep | grep"

#export CFLAGS=' -O2 -march=native -mtune=native -pipe '
#export CPPFLAGS=' -O2 -march=native -mtune=native -pipe '
export EDITOR=vim
export PATH=$PATH:/sbin:/usr/sbin

mesg n

stty -ixon

[ -s "/home/cyclops/.nvm/nvm.sh" ] && . "/home/cyclops/.nvm/nvm.sh" # This loads nvm



alias ..='cd ..'
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'
alias cd/='cd /'

alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias d='dirs -v | head -10'

# source /home/cyclops/work/workenv/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#setopt extended_glob
 TOKENS_FOLLOWED_BY_COMMANDS=('|' '||' ';' '&' '&&' 'sudo' 'do' 'time' 'strace')

    recolor-cmd() {
        region_highlight=()
        colorize=true
        start_pos=0
        for arg in ${(z)BUFFER}; do
            ((start_pos+=${#BUFFER[$start_pos+1,-1]}-${#${BUFFER[$start_pos+1,-1]## #}}))
            ((end_pos=$start_pos+${#arg}))
            if $colorize; then
                colorize=false
                res=$(LC_ALL=C builtin type $arg 2>/dev/null)
                case $res in
                    *'reserved word'*)   style="fg=magenta,bold";;
                    *'alias for'*)       style="fg=cyan,bold";;
                    *'shell builtin'*)   style="fg=yellow,bold";;
                    *'shell function'*)  style='fg=green,bold';;
                    *"$arg is"*)
                        [[ $arg = 'sudo' ]] && style="fg=red,bold" || style="fg=blue,bold";;
                    *)                   style='none,bold';;
                    esac
                    region_highlight+=("$start_pos $end_pos $style")

            fi
            [[ ${${TOKENS_FOLLOWED_BY_COMMANDS[(r)${arg//|/\|}]}:+yes} = 'yes' ]] && colorize=true
            start_pos=$end_pos
        done
    }
    check-cmd-self-insert() { zle .self-insert && recolor-cmd }
    check-cmd-backward-delete-char() { zle .backward-delete-char && recolor-cmd }

    zle -N self-insert check-cmd-self-insert
    zle -N backward-delete-char check-cmd-backward-delete-char
