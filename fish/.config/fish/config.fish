# vim:ft=fish
alias ls=exa                                                                   
alias l='ls -l'                                                                
alias ll='ls -al'                                                              

alias cat='bat -n --theme OneHalfDark'
                                                                               
alias vim=nvim                                                                 
alias vi=nvim                                                                  
alias v=nvim                                                                   
                                                                               
alias cls=clear                                                                
                                                                               
alias d='cd ~/git/dotfiles'

alias gs='git status'

export EDITOR="nvim"
export MANPAGER="nvim -c 'set ft=man'"
export FZF_DEFAULT_COMMAND="rg --files"

export PATH="$HOME/.emacs.d/bin/:$PATH"
export PATH="$HOME/.local/bin/:$PATH"
export PATH="$HOME/.cargo/bin/:$PATH"
export PATH="$HOME/.nimble/bin:$PATH"
export PATH="$HOME/code/scripts:$PATH"

set fish_greeting (echo Welcome)
set fish_key_bindings fish_user_key_bindings
set -g TERM xterm-256color

starship init fish | source
