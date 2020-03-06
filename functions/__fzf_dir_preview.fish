set -xg LSD_EXISTS (which lsd 2>/dev/null)

function __fzf_dir_preview -d "Preview directory in side panel"
    if test -n "$LSD_EXISTS"
        if test (count $argv) -eq 0
            echo 'lsd -l --color always'
        else
            lsd -l --color always $argv[1]
        end
    else
        if test (count $argv) -eq 0
            echo 'ls -l'
        else
            ls -l $argv[1]
        end
    end
end