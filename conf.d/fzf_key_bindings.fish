if set -q FZF_LEGACY_KEYBINDINGS; and test "$FZF_LEGACY_KEYBINDINGS" -eq 1
    bind \ct '__fzf_find_file'
    bind \cr '__fzf_reverse_isearch'
    bind \ec '__fzf_cd'
    bind \eC '__fzf_cd --hidden'
    bind \cg '__fzf_find_file'
    bind \co '__fzf_find_file --editor'

    if bind -M insert >/dev/null 2>/dev/null
        bind -M insert \ct '__fzf_find_file'
        bind -M insert \cr '__fzf_reverse_isearch'
        bind -M insert \ec '__fzf_cd'
        bind -M insert \eC '__fzf_cd --hidden'
        bind -M insert \cg '__fzf_find_file'
        bind -M insert \co '__fzf_find_file --editor'
    end
else if set -q FZF_CUSTOM_KEYBINDINGS; and test "$FZF_CUSTOM_KEYBINDINGS" -eq 1
    bind \ei '__fzf_brew_install'
    bind \cr '__fzf_reverse_isearch'
    bind \ek '__fzf_kill'
    bind \eL '__fzf_locate'
    bind \e\; '__fzf_cd'
    bind \e: '__fzf_cd --hidden'
    bind \e\' '__fzf_find_file'
    bind \e\" '__fzf_find_file --hidden'
    bind \ee '__fzf_find_file --editor'
    bind \eE '__fzf_find_file --editor --hidden'
    bind \e\\ '__fzf_find_token'

    bind \cg\ch '__fzf_git --hash'
    bind \cg\cr '__fzf_git --remote'
    bind \cg\ct '__fzf_git --tag'
    bind \cg\cb '__fzf_git --branch'
    bind \cg\cf '__fzf_git --file'

    bind \ea 'eval git add (__fzf_git --file --echo)'
    bind \er 'git rebase (__fzf_git --remote --echo)'
    bind \ec 'git checkout (__fzf_git --branch --echo)'

    if bind -M insert >/dev/null 2>/dev/null
        bind -M insert \ea '__fzf_find_file'
        bind -M insert \cr '__fzf_reverse_isearch'
        bind -M insert \ec '__fzf_cd'
        bind -M insert \eC '__fzf_cd --hidden'
        bind -M insert \eo '__fzf_find_file'
        bind -M insert \ee '__fzf_find_file --editor'
        bind -M insert \e\\ '__fzf_find_token'
    end
else
    bind \cf '__fzf_find_file'
    bind \cr '__fzf_reverse_isearch'
    bind \eo '__fzf_cd'
    bind \eO '__fzf_cd --hidden'
    bind \cg '__fzf_find_file'
    bind \co '__fzf_find_file --editor'

    if bind -M insert >/dev/null 2>/dev/null
        bind -M insert \cf '__fzf_find_file'
        bind -M insert \cr '__fzf_reverse_isearch'
        bind -M insert \eo '__fzf_cd'
        bind -M insert \eO '__fzf_cd --hidden'
        bind -M insert \cg '__fzf_find_file'
        bind -M insert \co '__fzf_find_file --editor'
    end
end

if set -q FZF_COMPLETE
    bind \t '__fzf_complete'
end

function fzf_key_bindings_uninstall -e fzf_key_bindings_uninstall
    if set -q FZF_LEGACY_KEYBINDINGS; and test "$FZF_LEGACY_KEYBINDINGS" -eq 1
        bind --erase \ct '__fzf_find_file'
        bind --erase \cr '__fzf_reverse_isearch'
        bind --erase \ec '__fzf_cd'
        bind --erase \eC '__fzf_cd --hidden'
        bind --erase \cg '__fzf_find_file'
        bind --erase \co '__fzf_find_file --editor'

        if bind --erase -M insert >/dev/null 2>/dev/null
            bind --erase -M insert \ct '__fzf_find_file'
            bind --erase -M insert \cr '__fzf_reverse_isearch'
            bind --erase -M insert \ec '__fzf_cd'
            bind --erase -M insert \eC '__fzf_cd --hidden'
            bind --erase -M insert \cg '__fzf_find_file'
            bind --erase -M insert \co '__fzf_find_file --editor'
        end
    else if set -q FZF_LEGACY_KEYBINDINGS; and test "$FZF_CUSTOM_KEYBINDINGS" -eq 1
        bind --erase \ei '__fzf_brew_install'
        bind --erase \cr '__fzf_reverse_isearch'
        bind --erase \ek '__fzf_kill'
        bind --erase \eL '__fzf_locate'
        bind --erase \e\; '__fzf_cd'
        bind --erase \e: '__fzf_cd --hidden'
        bind --erase \e\' '__fzf_find_file'
        bind --erase \e\" '__fzf_find_file --hidden'
        bind --erase \ee '__fzf_find_file --editor'
        bind --erase \eE '__fzf_find_file --editor --hidden'
        bind --erase \e\\ '__fzf_find_token'

        if bind --erase -M insert >/dev/null 2>/dev/null
            bind --erase -M insert \ea '__fzf_find_file'
            bind --erase -M insert \cr '__fzf_reverse_isearch'
            bind --erase -M insert \ec '__fzf_cd'
            bind --erase -M insert \eC '__fzf_cd --hidden'
            bind --erase -M insert \eo '__fzf_find_file'
            bind --erase -M insert \ee '__fzf_find_file --editor'
            bind --erase -M insert \e\\ '__fzf_find_token'
        end
    else
        bind --erase \cf '__fzf_find_file'
        bind --erase \cr '__fzf_reverse_isearch'
        bind --erase \eo '__fzf_cd'
        bind --erase \eO '__fzf_cd --hidden'
        bind --erase \cg '__fzf_find_file'
        bind --erase \co '__fzf_find_file --editor'

        if bind --erase -M insert >/dev/null 2>/dev/null
            bind --erase -M insert \cf '__fzf_find_file'
            bind --erase -M insert \cr '__fzf_reverse_isearch'
            bind --erase -M insert \eo '__fzf_cd'
            bind --erase -M insert \eO '__fzf_cd --hidden'
            bind --erase -M insert \cg '__fzf_find_file'
            bind --erase -M insert \co '__fzf_find_file --editor'
        end
    end

    if set -q FZF_COMPLETE
        bind --erase \t '__fzf_complete'
    end
end
