function __fzf_find_file -d "Open files and directories."
    function __fzf_find_file_get_open_cmd -d "Find appropriate open command."
        if type -q xdg-open
            echo "xdg-open"
        else if type -q open
            echo "open"
        end
    end

    set -l commandline (__fzf_parse_commandline)
    set -l dir $commandline[1]
    set -l fzf_query $commandline[2]

    if not string match -q '.' $dir
        set replace_first true
    end

    # Fish shell version >= v2.7, use argparse
    set -l options "e/editor" "p/preview=?" "h/hidden"
    argparse $options -- $argv

    set -l preview_cmd
    if set -q FZF_ENABLE_OPEN_PREVIEW
        set preview_cmd "--preview-window=right:wrap --preview='fish -c \"__fzf_complete_preview {}\"'"
    end

    if which fd >/dev/null ^/dev/null
        set FZF_OPEN_COMMAND "command fd . --type f \$dir"
    else if which rg >/dev/null ^/dev/null
        set FZF_OPEN_COMMAND "command rg --files \$dir"
    else
        set FZF_OPEN_COMMAND "command find \$dir"
    end

    if which fd >/dev/null ^/dev/null
        set FZF_OPEN_WITH_HIDDEN_COMMAND "command fd . -H --no-ignore-vcs --type f \$dir"
    else
        set FZF_OPEN_WITH_HIDDEN_COMMAND "
            command find -L \$dir -mindepth 1 \\( -path \$dir'*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' \\) -prune \
            -o -type f -print \
            -o -type d -print \
            -o -type l -print 2> /dev/null | sed 's@^\./@@'"
    end

    if set -q _flag_hidden
        set COMMAND $FZF_OPEN_WITH_HIDDEN_COMMAND
    else
        set COMMAND $FZF_OPEN_COMMAND
    end

    eval "$COMMAND | "(__fzfcmd) $preview_cmd "-m $FZF_DEFAULT_OPTS $FZF_OPEN_OPTS --query \"$fzf_query\"" | while read -l s
        set select $select $s
    end

    # set how to open
    set -l open_cmd
    if set -q _flag_editor
        set open_cmd "$EDITOR"
    else
        set open_cmd (__fzf_find_file_get_open_cmd)
        if test -z "$open_cmd"
            echo "Couldn't find appropriate open command to use. Do you have 'xdg-open' or 'open' installed?"
            and return 1
        end
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
                    commandline -rt -- (string escape -n $result)
                    commandline -it -- " "
                else
                    commandline -it -- (string escape -n $result)
                    commandline -it -- " "
                end
            end
        end
    end

    commandline -f repaint
    return $open_status
end
