# Add to path
path+=('/home/salahdin/.local/bin')

# Enable colors and change prompt:
autoload -U colors && colors
setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' stagedstr 'M' 
zstyle ':vcs_info:*' unstagedstr 'M' 
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' actionformats '%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats \
	'%F{5} %F{2}%b%F{5} %F{2}%c%F{3}%u%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
zstyle ':vcs_info:*' enable git 
+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
  [[ $(git ls-files --other --directory --exclude-standard | sed q | wc -l | tr -d ' ') == 1 ]] ; then
  hook_com[unstaged]+='%F{1}??%f'
fi
}
precmd () { vcs_info }

if test "$USER" = "root"
then
	PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[black]%}% \$vcs_info_msg_0_%{$fg[red]%}]%{$reset_color%}#%b "
else 
	PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[black]%}% \$vcs_info_msg_0_%{$fg[red]%}]%{$reset_color%}$%b "
fi

# Automatically cd into typed directory.
setopt autocd

# history
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/zsh/zsh_history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

## Case insensitivity
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
setopt nocaseglob

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Fix backspace
bindkey "^?" backward-delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^x' edit-command-line

# Keybinds
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# Load aliases if existent.
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

[ -f "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh" ] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
[ -f "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
