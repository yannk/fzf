set -xg BAT_EXISTS (which bat ^/dev/null)

function __fzf_highlight_cmd -d "Highlight text"
    if test -n "$BAT_EXISTS"
        bat --color always $argv[1]
    else
        cat $argv[1]
    end
end