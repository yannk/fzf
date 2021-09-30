function rgf
  set RG_PREFIX "rg --column --line-number --no-heading --color=always --smart-case $argv[1..-2]"
  set INITIAL_QUERY "$argv[-1]"
  set -xg FZF_DEFAULT_COMMAND "$RG_PREFIX "(string escape -- "$INITIAL_QUERY")
  set -xg SHELL /bin/sh
  fzf --ansi \
    --disabled --query "$INITIAL_QUERY" \
    --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
    --bind "alt-enter:unbind(change,alt-enter)+change-prompt(2. fzf> )+enable-search+clear-query" \
    --prompt '1. ripgrep> ' \
    --delimiter : \
    --preview 'bat --color=always --highlight-line {2} {1}' \
    --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' | while read -l s
    set tokens (string split -m3 : -- $s)
    set select $select "$tokens[1]:$tokens[2]:$tokens[3]"
  end

  if not test -z "$select"
    echo "$EDITOR" $select
    "$EDITOR" $select
  end
end
