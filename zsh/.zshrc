function aliases {
    alias ls=exa                                                                   
    alias l='ls -l'                                                                
    alias ll='ls -al'                                                              
                                                                                   
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
    alias vba='vim ~/.bash_aliases'                                                
    alias vza='vim ~/.zsh_aliases'                                                 
                                                                                   
    alias d='cd ~/.dotfiles'

    alias gs='git status'
}
aliases


SAVEHIST=1000
HISTFILE=~/.zsh_history

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

echo -ne '\e[5 q' # Make cursor an I-Beam

#PS1="%{%F{yellow%}%}%n%{%F{green%}%}:%{%F{blue%}%}%1~%{%f%}%{%F{red%}%}[]%{%f%}"$'\n'"%{%F{green%}%}%{%f%} "
#PS1="%F{yellow}%n%F{green}:%F{blue}%1~%f%F{red}[]%f"$'\n'"%F{green}%f "
PS1="%F{yellow}%n%F{green}:%F{blue}%1~%f%F{red}[]%f"$'\n'"%F{green}:: %f"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

export PATH=”~/.emacs.d/bin:$PATH”
