if [[ -f ~/.zsh_aliases ]]; then
. ~/.zsh_aliases
fi

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
