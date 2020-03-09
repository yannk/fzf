function __fzf_brew_install -d "Install brew packages"
    set -l commandline (__fzf_parse_commandline)
    set -l fzf_query $commandline[2]

    set -l preview_cmd
    if set -q FZF_ENABLE_PREVIEW
        set preview_cmd "--preview-window=right:wrap --preview='brew info {}'"
    end

    varcache BREW_SEARCH 'brew search' '12 hours' compressed | eval (__fzfcmd) $preview_cmd "-m $FZF_DEFAULT_OPTS --query \"$fzf_query\"" | while read -l s
        set select $select $s
    end

    if test (count $select) -gt 0
        commandline "brew install $select"
        and commandline -f execute
        set open_status $status
    end
    commandline -f repaint
    return $open_status
end