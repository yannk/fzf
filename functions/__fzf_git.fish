function __fzf_is_in_git_repo
    git rev-parse HEAD >/dev/null 2>&1
end

function __fzf_gf
    __fzf_is_in_git_repo || return
    git -c color.status=always status --short |
        eval (__fzfcmd) -m --ansi --nth 2..,.. \
            --preview (string escape -n -- 'git diff --color=always -- {-1} | sed 1,4d; __fzf_universal_preview {-1}') |
        cut -c4- | sed 's/.* -> //'
end

function __fzf_gb
    __fzf_is_in_git_repo || return
    git branch -a --color=always | grep -v '/HEAD\s' | sort |
        eval (__fzfcmd) --ansi --multi --tac --preview-window right:70% \
            --preview (string escape -n -- 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(echo {} | sed s/^..// | cut -d" " -f1) | head -n 200') |
        sed 's/^..//' | cut -d' ' -f1 |
        sed 's#^remotes/origin/##'
    or sed 's#^remotes/##'
end

function __fzf_gt
    __fzf_is_in_git_repo || return
    git tag --sort -version:refname |
        eval (__fzfcmd) --multi --preview-window right:70% \
            --preview (string escape -n -- 'git show --color=always {} | head -n 200')
end

function __fzf_gh
    __fzf_is_in_git_repo || return
    git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
        eval (__fzfcmd) --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
            --header (string escape -n -- 'Press CTRL-S to toggle sort') \
            --preview (string escape -n -- 'echo {} | grep -o "[a-f0-9]\{7,\}" | xargs git show --color=always | head -n 200') |
        grep -o "[a-f0-9]\{7,\}"
end

function __fzf_gr
    __fzf_is_in_git_repo || return
    git remote -v | awk '{print $1 "\t" $2}' | uniq |
        eval (__fzfcmd) --tac \
            --preview (string escape -n -- 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -n 200') |
        cut -d\t -f1
end

function __fzf_git -d "Git with FZF"
    argparse --name=fzf-git h/hash r/remote t/tag b/branch f/file e/echo -- $argv
    or return

    set -l commandline (__fzf_parse_commandline)
    set -l fzf_query $commandline[2]
    if set -q fzf_query
        set replace_first true
    end

    begin
        if set -q _flag_hash
            __fzf_gh
        else if set -q _flag_remote
            __fzf_gr
        else if set -q _flag_tag
            __fzf_gt
        else if set -q _flag_branch
            __fzf_gb
        else if set -q _flag_file
            __fzf_gf
        end
    end | while read -l s
        set results $results $s
    end

    if set -q _flag_echo
        if test (count results) -eq 1
            echo -n "$results"
        else
            for result in $results
                echo -n " $result"
            end
        end
    else
        for result in $results
            if set -q replace_first
                set -e replace_first
                commandline -rt -- $result
                commandline -it -- " "
            else
                commandline -it -- $result
                commandline -it -- " "
            end
        end
    end

    commandline -f repaint
end

abbr -a fzg __fzf_git
abbr -a fzgh __fzf_gh
abbr -a fzgr __fzf_gr
abbr -a fzgt __fzf_gt
abbr -a fzgb __fzf_gb
abbr -a fzgf __fzf_gf
