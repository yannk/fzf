function __fzf_reverse_isearch --description "Search command history. Replace the command line with the selected command."
    # history merge incorporates history changes from other fish sessions
    builtin history merge

    set command_with_ts (
        # Reference https://devhints.io/strftime to understand strftime format symbols
        builtin history --null --show-time="%m-%d %H:%M:%S │ " |
        eval (__fzfcmd) (string escape -- --read0 \
            --tiebreak=index \
            --query=(commandline) \
            # preview current command using fish_ident in a window at the bottom 3 lines tall
            --preview="echo {4..} | fish_indent --ansi" \
            --preview-window="bottom:10:wrap" \
            $fzf_history_opts) |
        string collect
    )

    if test $status -eq 0
        set command_selected (string split --max 1 " │ " $command_with_ts)[2]
        commandline --replace -- $command_selected
    end

    commandline --function repaint
end
