if test "$FZF_LEGACY_KEYBINDINGS" -eq 1
    bind \ct '__fzf_find_file'
    bind \cr '__fzf_reverse_isearch'
    bind \ec '__fzf_cd'
    bind \eC '__fzf_cd --hidden'
    bind \cg '__fzf_open'
    bind \co '__fzf_open --editor'

    if bind -M insert >/dev/null 2>/dev/null
        bind -M insert \ct '__fzf_find_file'
        bind -M insert \cr '__fzf_reverse_isearch'
        bind -M insert \ec '__fzf_cd'
        bind -M insert \eC '__fzf_cd --hidden'
        bind -M insert \cg '__fzf_open'
        bind -M insert \co '__fzf_open --editor'
    end
else if test "$FZF_CUSTOM_KEYBINDINGS" -eq 1
    bind \ei '__fzf_brew_install'
    # bind \ea '__fzf_find_file'
    bind \cr '__fzf_reverse_isearch'
    bind \ek '__fzf_kill'
    bind \eL '__fzf_locate'
    bind \ec '__fzf_cd'
    bind \eC '__fzf_cd --hidden'
    bind \ea '__fzf_open'
    bind \eA '__fzf_open --hidden'
    bind \ee '__fzf_open --editor'
    bind \eE '__fzf_open --editor --hidden'
    bind \e\\ '__fzf_find_token'
    bind \ep '__fzf_find_fasd -f'
    bind \eP '__fzf_find_fasd -d'

    if bind -M insert >/dev/null 2>/dev/null
        bind -M insert \ea '__fzf_find_file'
        bind -M insert \cr '__fzf_reverse_isearch'
        bind -M insert \ec '__fzf_cd'
        bind -M insert \eC '__fzf_cd --hidden'
        bind -M insert \eo '__fzf_open'
        bind -M insert \ee '__fzf_open --editor'
        bind -M insert \e\\ '__fzf_find_token'
        bind -M insert \eF '__fzf_find_fasd -f'
        bind -M insert \eD '__fzf_find_fasd -d'
    end
else
    bind \cf '__fzf_find_file'
    bind \cr '__fzf_reverse_isearch'
    bind \eo '__fzf_cd'
    bind \eO '__fzf_cd --hidden'
    bind \cg '__fzf_open'
    bind \co '__fzf_open --editor'

    if bind -M insert >/dev/null 2>/dev/null
        bind -M insert \cf '__fzf_find_file'
        bind -M insert \cr '__fzf_reverse_isearch'
        bind -M insert \eo '__fzf_cd'
        bind -M insert \eO '__fzf_cd --hidden'
        bind -M insert \cg '__fzf_open'
        bind -M insert \co '__fzf_open --editor'
    end
end

if set -q FZF_COMPLETE
    bind \t '__fzf_complete'
end

function fzf_key_bindings_uninstall -e fzf_key_bindings_uninstall
  # Erase key bindings here.
end
