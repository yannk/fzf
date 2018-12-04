function __fzf_highlight_cmd -d "Highlight text"
    if which bat >/dev/null ^/dev/null
        bat --color always $argv[1]
    else
        cat $argv[1]
    end
end