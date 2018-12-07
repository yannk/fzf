function __fzf_find_fasd
    set -l commandline (__fzf_parse_commandline)
    set -l fzf_query $commandline[2]
    if set -q fzf_query
        set replace_first true
    end

    fasd -l $argv | eval (__fzfcmd) "-m $FZF_DEFAULT_OPTS --no-sort --query \"$fzf_query\"" | while read -l s
        set results $results $s
    end
    for result in $results
        if set -q replace_first
            set -e replace_first
            commandline -rt -- (string escape -n $result)
            commandline -it -- " "
        else
            commandline -it -- (string escape -n $result)
            commandline -it -- " "
        end
    end
    commandline -f repaint
end
