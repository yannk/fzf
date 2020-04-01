function __fzf_find_dir -d "Change directory"
    set -l commandline (__fzf_parse_commandline)
    set -l dir $commandline[1]
    set -l fzf_query $commandline[2]

    # Fish shell version >= v2.7, use argparse
    set -l options "e/editor" "p/preview=?" "h/hidden"
    argparse $options -- $argv

    set -l COMMAND

    if not set -q FZF_CD_COMMAND
        if which fd >/dev/null 2>/dev/null
            set FZF_CD_COMMAND "command fd . --type d \$dir"
        else
            set FZF_CD_COMMAND "
                command find -L \$dir -mindepth 1 \\( -path \$dir'*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' \\) -prune \
                -o -type d -print 2> /dev/null | sed 's@^\./@@'"
        end
    end

    if not set -q FZF_CD_WITH_HIDDEN_COMMAND
        set FZF_CD_WITH_HIDDEN_COMMAND "
            command find -L \$dir \
            \\( -path '*/\\.git*' -o -fstype 'dev' -o -fstype 'proc' \\) -prune \
            -o -type d -print 2> /dev/null | sed 1d | cut -b3-"
    end

    if set -q _flag_hidden
        set COMMAND $FZF_CD_WITH_HIDDEN_COMMAND
    else
        set COMMAND $FZF_CD_COMMAND
    end

    set -l preview_cmd
    if set -q FZF_ENABLE_OPEN_PREVIEW
        set preview_cmd "--preview-window=right:wrap --preview='$FZF_PREVIEW_DIR_CMD {}'"
    end

    test -n "$FZF_TMUX_HEIGHT"; or set FZF_TMUX_HEIGHT 40%

    set -lx FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT --reverse $FZF_DEFAULT_OPTS $FZF_CD_OPTS"

    eval "$COMMAND | "(__fzfcmd)" $preview_cmd +m $FZF_DEFAULT_OPTS $FZF_CD_OPTS --query \"$fzf_query\"" | while read -l s
        set select $select $s
    end

    set -l open_status 0
    if not test -z "$select"
        if set -q _flag_editor
            commandline "$open_cmd \"$select\""
            and commandline -f execute
            set open_status $status
        else
            for result in $select
                if set -q replace_first
                    set -e replace_first
                    commandline -rt -- (string escape -n -- $result)
                    commandline -it -- " "
                else
                    commandline -it -- (string escape -n -- $result)
                    commandline -it -- " "
                end
            end
        end
    end

    commandline -f repaint
    return $open_status
end
