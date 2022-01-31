function __fzf_universal_preview -d "Preview file in side panel"
    if test -d "$argv"
        __fzf_dir_preview $argv
    else if test -f "$argv"
        __fzf_file_preview $argv
    end
end
