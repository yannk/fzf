function __fzf_file_preview -d "Preview file in side panel"
    if string match -q "*binary" (file --mime {})
        if which bat >/dev/null ^/dev/null
            bat --line-range :30 --paging never --color always $argv[1]
        else
            head -n 30 $argv[1]
        end
    end
end