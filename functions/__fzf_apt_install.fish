function __fzf_apt_install -d "Install apt packages"
    set -l commandline (__fzf_parse_commandline)
    set -l fzf_query $commandline[2]

    set -l preview_cmd
    if set -q FZF_ENABLE_PREVIEW
        set preview_cmd '--preview=\'apt-cache show {1}\''
    end

    varcache APT_CACHE_SEARCH 'apt-cache search .' '12 hours' compressed | eval (__fzfcmd) "-m $FZF_DEFAULT_OPTS $preview_cmd --query \"$fzf_query\"" | while read -l s
        set select $select (echo $s | cut -d' ' -f1)
    end

    if test (count $select) -gt 0
        commandline "sudo apt-get install $select"
        and commandline -f execute
        set open_status $status
    end
    commandline -f repaint
    return $open_status
end
