function __fzf_kill -d "Kill processes"
    set -l pid (ps -ef | sed 1d | fzf -m | awk '{print $2}')

    if test (string length "$pid") -ne 0
        echo $pid | xargs kill -9
    end
end