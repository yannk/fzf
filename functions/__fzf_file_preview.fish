set -xg BAT_EXISTS (which bat 2>/dev/null)
set -xg HEXYL_EXISTS (which hexyl 2>/dev/null)

function __fzf_file_preview -d "Preview file in side panel"
    if test (count $argv) -eq 0
        echo "if file --mime {} | grep -iq directory; then "(__fzf_dir_preview)" {}; elif file --mime {} | grep -iq binary; then if which hexyl 2>/dev/null; then hexyl -n 512 --color always {}; else xxd -l512 {}; fi; elif which bat 2>/dev/null; then bat --line-range :200 --paging never --color always {}; else head -n 30 {}; fi"
    else
        if string match -q -- "*binary" (file --mime $argv[1])
            if test -n "$HEXYL_EXISTS"
                hexyl -n 512 --color always $argv[1]
            else
                xxd -l512 $argv[1]
            end
        else
            if test -n "$BAT_EXISTS"
                bat --line-range :200 --paging never --color always $argv[1]
            else
                head -n 30 $argv[1]
            end
        end
    end
end