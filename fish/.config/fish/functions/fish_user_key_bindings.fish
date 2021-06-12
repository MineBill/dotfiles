# vim:ft=fish
function fish_user_key_bindings
    fish_vi_key_bindings
    bind -M insert -m default fd backward-char force-repaint
end
