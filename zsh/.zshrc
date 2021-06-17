function aliases {
    alias l='ls -l'
    alias ll='ls -al'
    alias cls=clear
    alias hg='cat ~/.zsh_history | grep'
}
aliases

export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

SAVEHIST=1000
HISTFILE=~/.zsh_history

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source 

# export PATH=~/.emacs.d/bin/:$PATH
# export PATH=~/.cargo/bin/:$PATH
# export PATH=~/.nimble/bin:$PATH
# export FZF_DEFAULT_COMMAND="rg --files"
export EDITOR="nvim"
export MANPAGER="nvim -c 'set ft=man' -"
export PATH=~/.local/bin/:$PATH

# === Vim Mode ===
# VIM_MODE_VICMD_KEY='fd'
# source "$HOME/git/zsh-vim-mode/zsh-vim-mode.plugin.zsh"
# MODE_INDICATOR_VIINS='%F{15}<%F{8}INSERT<%f'
# MODE_INDICATOR_VICMD='%F{10}<%F{2}NORMAL<%f'
# MODE_INDICATOR_REPLACE='%F{9}<%F{1}REPLACE<%f'
# MODE_INDICATOR_SEARCH='%F{13}<%F{5}SEARCH<%f'
# MODE_INDICATOR_VISUAL='%F{12}<%F{4}VISUAL<%f'
# MODE_INDICATOR_VLINE='%F{12}<%F{4}V-LINE<%f'

# === Start starship
 eval $(starship init zsh)
