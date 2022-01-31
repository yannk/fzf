function __fzfcmd
    test -n "$FZF_TMUX"; or set FZF_TMUX 0
    test -n "$FZF_TMUX_HEIGHT"; or set FZF_TMUX_HEIGHT 60%
    test -n "$FZF_SHELL"; or set FZF_SHELL dash
    if [ $FZF_TMUX -eq 1 ]
        echo "env SHELL=$FZF_SHELL fzf-tmux -d$FZF_TMUX_HEIGHT"
    else
        echo "env SHELL=$FZF_SHELL fzf --height $FZF_TMUX_HEIGHT --reverse"
    end
end
