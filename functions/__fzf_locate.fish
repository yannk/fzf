function __fzf_locate -d "Find files using locate"
    set -l commandline (__fzf_parse_commandline)
    set -l dir $commandline[1]
    set -l fzf_query $commandline[2]

    if string match $dir '.'
        set dir (pwd)
    end

    locate $dir | eval (__fzfcmd) "-m $FZF_DEFAULT_OPTS --query \"$fzf_query\"" | while read -l s; set results $results $s; end
    for result in $results
      commandline -it -- (string escape -n $result)
      commandline -it -- " "
    end
    commandline -f repaint
end