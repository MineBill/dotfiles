function aliases {
    alias ls=exa                                                                   
    alias l='ls -l'                                                                
    alias ll='ls -al'                                                              

    alias cat='bat -n --theme OneHalfDark'
                                                                                   
    alias vim=nvim                                                                 
    alias vi=nvim                                                                  
    alias v=nvim                                                                   
                                                                                   
    alias cls=clear                                                                
                                                                                   
    alias vv='vim ~/.config/nvim/init.vim'                                         
    alias va='vim ~/.config/alacritty/alacritty.yml'                               
    alias vp='vim ~/.config/polybar/config.ini'                                    
    alias vk='vim ~/.config/kitty/kitty.conf'                                      
    alias v3='vim ~/.config/i3/config'                                             
    alias vb='vim ~/.bashrc'                                                       
    alias vz='vim ~/.zshrc'                                                        
    alias vh='vim ~/.xmonad/xmonad.hs'
    alias vba='vim ~/.bash_aliases'                                                
    alias vza='vim ~/.zsh_aliases'                                                 
                                                                                   
    alias d='cd ~/.dotfiles'

    alias gs='git status'

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

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
#source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

export PATH=~/.emacs.d/bin/:$PATH
export FZF_DEFAULT_COMMAND="rg --files"
export EDITOR="nvim"

# === Vim Mode ===
VIM_MODE_VICMD_KEY='fd'
source "$HOME/dev/git/zsh-vim-mode/zsh-vim-mode.plugin.zsh"
MODE_INDICATOR_VIINS='%F{15}<%F{8}INSERT<%f'
MODE_INDICATOR_VICMD='%F{10}<%F{2}NORMAL<%f'
MODE_INDICATOR_REPLACE='%F{9}<%F{1}REPLACE<%f'
MODE_INDICATOR_SEARCH='%F{13}<%F{5}SEARCH<%f'
MODE_INDICATOR_VISUAL='%F{12}<%F{4}VISUAL<%f'
MODE_INDICATOR_VLINE='%F{12}<%F{4}V-LINE<%f'

# === Start starship
eval $(starship init zsh)

figlet -t -f small "Welcome, minebill" | lolcat
