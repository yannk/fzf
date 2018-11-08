function __fzf_locate -d "Find files using locate"
    set -l commandline (__fzf_parse_commandline)
    set -l dir $commandline[1]
    set -l fzf_query $commandline[2]

    if string match -q '.' $dir
        set replace_first true
        set dir (pwd)
    end

    locate $dir | eval (__fzfcmd) "-m $FZF_DEFAULT_OPTS --query \"$fzf_query\"" | while read -l s; set results $results $s; end
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