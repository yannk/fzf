function __fzf_cd -d "Change directory"
    set -l commandline (__fzf_parse_commandline)
    set -l dir $commandline[1]
    set -l fzf_query $commandline[2]

    # Fish shell version >= v2.7, use argparse
    if type -q argparse
        set -l options  "h/hidden"
        argparse $options -- $argv
    else # Fallback for fish shell version < 2.7
        if contains -- --hidden $argv; or contains -- -h $argv
            set _flag_hidden "yes"
        end
    end

    set -l COMMAND

    set -q FZF_CD_COMMAND
    or which fd >/dev/null ^/dev/null
    and set -l FZF_CD_COMMAND "command fd . --type d \$dir"
    or set -l FZF_CD_COMMAND "
    command find -L \$dir -mindepth 1 \\( -path \$dir'*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' \\) -prune \
    -o -type d -print 2> /dev/null | sed 's@^\./@@'"

    set -q FZF_CD_WITH_HIDDEN_COMMAND
    or set -l FZF_CD_WITH_HIDDEN_COMMAND "
    command find -L \$dir \
    \\( -path '*/\\.git*' -o -fstype 'dev' -o -fstype 'proc' \\) -prune \
    -o -type d -print 2> /dev/null | sed 1d | cut -b3-"

    if set -q _flag_hidden
        set COMMAND $FZF_CD_WITH_HIDDEN_COMMAND
    else
        set COMMAND $FZF_CD_COMMAND
    end

    set -l preview_cmd
    if set -q FZF_ENABLE_OPEN_PREVIEW
        set preview_cmd "--preview-window=right:wrap --preview='$FZF_PREVIEW_DIR_CMD {}'"
    end


    eval "$COMMAND | "(__fzfcmd)" $preview_cmd +m $FZF_DEFAULT_OPTS $FZF_CD_OPTS --query \"$fzf_query\"" | read -l select

    if not test -z "$select"
        builtin cd "$select"

        # Remove last token from commandline.
        commandline -t ""
    end

    commandline -f repaint
end
