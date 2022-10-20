function __fzf_locate -d "Find files using locate"
    set -l commandline (__fzf_parse_commandline)
    set -l dir $commandline[1]
    set -l fzf_query $commandline[2]

    if not string match -q -- '.' $dir
        set replace_first true
    end
    if string match -q -- '.' $dir
        set dir (pwd)
    end

    set -l preview_cmd
    if set -q FZF_ENABLE_OPEN_PREVIEW
        set preview_cmd "--preview='$FZF_PREVIEW_FILE_CMD'"
    end
    test -n "$FZF_TMUX_HEIGHT"; or set FZF_TMUX_HEIGHT 60%
    set -lx FZF_LOCATE_OPTS "--height $FZF_TMUX_HEIGHT --reverse $FZF_LOCATE_OPTS"

    locate $dir | eval (__fzfcmd) "-m $FZF_DEFAULT_OPTS $FZF_LOCATE_OPTS $preview_cmd --query \"$fzf_query\"" | while read -l s
        set results $results $s
    end
    for result in $results
        if set -q replace_first
            set -e replace_first
            commandline -rt -- (string escape -n -- $result)
            commandline -it -- " "
        else
            commandline -it -- (string escape -n -- $result)
            commandline -it -- " "
        end
    end
    commandline -f repaint
end
