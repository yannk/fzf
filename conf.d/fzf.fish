set -q FZF_TMUX_HEIGHT; or set -U FZF_TMUX_HEIGHT "40%"
set -q FZF_DEFAULT_OPTS; or set -U FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT"
set -q FZF_LEGACY_KEYBINDINGS; or set -U FZF_LEGACY_KEYBINDINGS 0
set -q FZF_CUSTOM_KEYBINDINGS; or set -U FZF_CUSTOM_KEYBINDINGS 1
set -q FZF_COMPLETE; or set -U FZF_COMPLETE 3
set -q FZF_ENABLE_OPEN_PREVIEW; or set -U FZF_ENABLE_OPEN_PREVIEW 1
set -q FZF_ENABLE_PREVIEW; or set -U FZF_ENABLE_PREVIEW 1
set -q FZF_PREVIEW_FILE_CMD
or which bat >/dev/null ^/dev/null
and set -U FZF_PREVIEW_FILE_CMD "bat --line-range :30 --paging never"
or set -U FZF_PREVIEW_FILE_CMD "head -n 30"

set -q FZF_PREVIEW_DIR_CMD
or which exa >/dev/null ^/dev/null
and set -U FZF_PREVIEW_DIR_CMD "exa -l"
or set -U FZF_PREVIEW_DIR_CMD "ls -l"

function fzf_uninstall -e fzf_uninstall
  # Erase env vars and __fzf functions here.
end
