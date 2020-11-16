function __fzf_expand
    string replace -r '^~/' "$HOME/" "$argv[1]"
end