function __fzf_tokenize_history
    set -l cmd (commandline)
    set -l cmdl (rg '^- cmd: ([^\\\]{5,200})$' -r '$1' --no-line-number ~/.local/share/fish/fish_history)
    commandline -- $cmdl
    echo -n '' > /tmp/.tokens
    commandline -o | while read -l r
        if string match -qr '[a-zA-Z0-9]{3,}' -- "$r"
            echo $r >> /tmp/.tokens
        end
    end
    commandline -- $cmd
    awk '!x[$0]++' /tmp/.tokens
end
