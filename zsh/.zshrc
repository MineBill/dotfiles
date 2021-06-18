### Zsh Settings
SAVEHIST=1000
HISTFILE=~/.zsh_history
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
eval "$(starship init zsh)"

### Aliases
alias l='ls -l'
alias ll='ls -al'
alias cls=clear
alias hg='cat ~/.zsh_history | grep'

### Exports
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export EDITOR="nvim"
export MANPAGER="nvim -c 'set ft=man' -"
export PATH=~/.local/bin/:$PATH

### Plugin Settings
ZVM_VI_INSERT_ESCAPE_BINDKEY=fd
ZVM_CURSOR_STYLE_ENABLED=false

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

### Plugins 
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
if [ -e /home/minebill/.nix-profile/etc/profile.d/nix.sh ]; then . /home/minebill/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
