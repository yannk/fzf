if set -q FZF_LEGACY_KEYBINDINGS; and test "$FZF_LEGACY_KEYBINDINGS" -eq 1
    bind \ct __fzf_find_file
    bind \cr __fzf_reverse_isearch
    bind \ec __fzf_find_dir
    bind \eC '__fzf_find_dir --hidden'
    bind \cg __fzf_find_file
    bind \co '__fzf_find_file --editor'

    if bind -M insert >/dev/null 2>/dev/null
        bind -M insert \ct __fzf_find_file
        bind -M insert \cr __fzf_reverse_isearch
        bind -M insert \ec __fzf_find_dir
        bind -M insert \eC '__fzf_find_dir --hidden'
        bind -M insert \cg __fzf_find_file
        bind -M insert \co '__fzf_find_file --editor'
    end
else if set -q FZF_CUSTOM_KEYBINDINGS; and test "$FZF_CUSTOM_KEYBINDINGS" -eq 1
    bind \ei __fzf_brew_install
    bind \eI __fzf_apt_install
    bind \cr __fzf_reverse_isearch
    bind \ek __fzf_kill
    bind \eL __fzf_locate
    bind \e\; __fzf_find_dir
    bind \e\? '__fzf_find_dir --cd'
    bind \e: '__fzf_find_dir --hidden'
    bind \e\' __fzf_find_file
    bind \e\" '__fzf_find_file --hidden'
    bind \ee '__fzf_find_file --editor'
    bind \eE '__fzf_find_file --editor --hidden'
    bind \e\\ __fzf_find_token

    bind \cg\ch '__fzf_git --hash'
    bind \cg\cr '__fzf_git --remote'
    bind \cg\ct '__fzf_git --tag'
    bind \cg\cb '__fzf_git --branch'
    bind \cg\cf '__fzf_git --file'

    bind \ea 'eval git add (__fzf_git --file --echo)'
    bind \er 'git rebase (__fzf_git --remote --echo)'
    bind \eb 'git check
out (__fzf_git --branch --echo)'

    if bind -M insert >/dev/null 2>/dev/null
        bind -M insert \ei __fzf_brew_install
        bind -M insert \eI __fzf_apt_install
        bind -M insert \cr __fzf_reverse_isearch
        bind -M insert \ek __fzf_kill
        bind -M insert \eL __fzf_locate
        bind -M insert \e\; __fzf_find_dir
        bind -M insert \e\? '__fzf_find_dir --cd'
        bind -M insert \e: '__fzf_find_dir --hidden'
        bind -M insert \e\' __fzf_find_file
        bind -M insert \e\" '__fzf_find_file --hidden'
        bind -M insert \ee '__fzf_find_file --editor'
        bind -M insert \eE '__fzf_find_file --editor --hidden'
        bind -M insert \e\\ __fzf_find_token
    end
else
    bind \cf __fzf_find_file
    bind \cr __fzf_reverse_isearch
    bind \eo __fzf_find_dir
    bind \eO '__fzf_find_dir --hidden'
    bind \cg __fzf_find_file
    bind \co '__fzf_find_file --editor'

    if bind -M insert >/dev/null 2>/dev/null
        bind -M insert \cf __fzf_find_file
        bind -M insert \cr __fzf_reverse_isearch
        bind -M insert \eo __fzf_find_dir
        bind -M insert \eO '__fzf_find_dir --hidden'
        bind -M insert \cg __fzf_find_file
        bind -M insert \co '__fzf_find_file --editor'
    end
end

if set -q FZF_COMPLETE
    bind \t __fzf_complete
end

function fzf_key_bindings_uninstall -e fzf_key_bindings_uninstall
    if set -q FZF_LEGACY_KEYBINDINGS; and test "$FZF_LEGACY_KEYBINDINGS" -eq 1
        bind --erase \ct
        bind --erase \cr
        bind --erase \ec
        bind --erase \eC
        bind --erase \cg
        bind --erase \co

        if bind --erase -M insert >/dev/null 2>/dev/null
            bind --erase -M insert \ct
            bind --erase -M insert \cr
            bind --erase -M insert \ec
            bind --erase -M insert \eC
            bind --erase -M insert \cg
            bind --erase -M insert \co
        end
    else if set -q FZF_LEGACY_KEYBINDINGS; and test "$FZF_CUSTOM_KEYBINDINGS" -eq 1
        bind --erase \ei
        bind --erase \eI
        bind --erase \cr
        bind --erase \ek
        bind --erase \eL
        bind --erase \e\;
        bind --erase \e:
        bind --erase \e\'
        bind --erase \e\"
        bind --erase \ee
        bind --erase \eE
        bind --erase \e\\

        if bind --erase -M insert >/dev/null 2>/dev/null
            bind --erase -M insert \ea
            bind --erase -M insert \cr
            bind --erase -M insert \ec
            bind --erase -M insert \eC
            bind --erase -M insert \eo
            bind --erase -M insert \ee
            bind --erase -M insert \e\\
        end
    else
        bind --erase \cf
        bind --erase \cr
        bind --erase \eo
        bind --erase \eO
        bind --erase \cg
        bind --erase \co

        if bind --erase -M insert >/dev/null 2>/dev/null
            bind --erase -M insert \cf
            bind --erase -M insert \cr
            bind --erase -M insert \eo
            bind --erase -M insert \eO
            bind --erase -M insert \cg
            bind --erase -M insert \co
        end
    end

    if set -q FZF_COMPLETE
        bind --erase \t
    end
end
