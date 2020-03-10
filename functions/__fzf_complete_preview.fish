function __fzf_complete_preview -d 'generate preview for completion widget.
    argv[1] is the currently selected candidate in fzf
    argv[2] is a string containing the rest of the output produced by `complete -Ccmd`
    '

    if test "$argv[2]" = "Redefine variable"
        # show environment variables current value
        set -l evar (echo $argv[1] | cut -d= -f1)
        echo $argv[1]$$evar
    end

    # list directories on preview
    set -l dir (__with_cdpath "$argv")
    if test -d $dir
        echo $argv
        __fzf_dir_preview (string escape -- $dir)
        return
    end

    set -l dir (__with_cdpath "$argv[1]")
    if test -d $dir
        echo $argv[1]
        __fzf_dir_preview (string escape -- $dir)
        echo $argv[2]
        return
    end

    # show ten lines of non-binary files preview
    if test -f "$argv[1]"
        and grep -qI . "$argv[1]"
        echo $argv[1]
        __fzf_file_preview (string escape -- $argv[1])
        echo $argv[2]
        return
    end

    if test -f "$argv"
        and grep -qI . "$argv"
        echo $argv
        __fzf_file_preview (string escape -- $argv)
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
