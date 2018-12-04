function __fzf_dir_preview -d "Preview directory in side panel"
    if which exa >/dev/null ^/dev/null
        exa -l --color always $argv[1]
    else
        ls -l $argv[1]
    end
end