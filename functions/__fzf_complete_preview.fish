function __fzf_complete_preview -d 'generate preview for completion widget.
    argv[1] is the currently selected candidate in fzf
    argv[2] is a string containing the rest of the output produced by `complete -Ccmd`
    '

    if test "$argv[2]" = "Redefine variable"
        # show environment variables current value
        set -l evar (echo $argv[1] | cut -d= -f1)
        echo $argv[1]$$evar
    end

    if set -q __COMPLETE_PREVIEW
        set cmd (string replace -a '{2}' "$argv[2]" (string replace -a '{1}' "$argv[1]" $__COMPLETE_PREVIEW))
        if set -q __COMPLETE_PREVIEW_CACHE_FOR
            set cmd "varcache '$cmd' '$cmd' '$__COMPLETE_PREVIEW_CACHE_FOR' compressed"
        end
        echo $cmd
        eval $cmd
        return
    end

    # list directories on preview
    set -l dir (__with_cdpath (__fzf_expand "$argv"))
    if test -d $dir
        echo $argv
        __fzf_dir_preview (string escape -- $dir)
        return
    end

    set -l dir (__with_cdpath (__fzf_expand "$argv[1]"))
    if test -d $dir
        echo $argv[1]
        __fzf_dir_preview (string escape -- (string replace './' '' -- $dir))
        echo $argv[2]
        return
    end

    # show ten lines of non-binary files preview
    set -l file (__fzf_expand "$argv[1]")
    if test -f "$file"
        and grep -qI . "$file"
        echo $file
        __fzf_file_preview (string escape -- $file)
        echo $argv[2]
        return
    end

    set -l file (__fzf_expand "$argv")
    if test -f "$file"
        and grep -qI . "$file"
        echo $file
        __fzf_file_preview (string escape -- $file)
        return
    end

    # if fish knows about it, let it show info
    if type -q "$argv[1]" 2>/dev/null
        echo $argv[1]
        type -a "$argv[1]" | awk '!x[$0]++'
        echo $argv[2]
        return
    end

    if type -q "$argv" 2>/dev/null
        echo $argv
        type -a "$argv" | awk '!x[$0]++'
        return
    end
end
