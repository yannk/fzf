set -q FZF_TMUX_HEIGHT; or set -U FZF_TMUX_HEIGHT "40%"
set -q FZF_DEFAULT_OPTS; or set -U FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT"
set -q FZF_LEGACY_KEYBINDINGS; or set -U FZF_LEGACY_KEYBINDINGS 0
set -q FZF_CUSTOM_KEYBINDINGS; or set -U FZF_CUSTOM_KEYBINDINGS 1
set -q FZF_COMPLETE; or set -U FZF_COMPLETE 3
set -q FZF_ENABLE_OPEN_PREVIEW; or set -U FZF_ENABLE_OPEN_PREVIEW 1
set -q FZF_ENABLE_PREVIEW; or set -U FZF_ENABLE_PREVIEW 1
set -q FZF_PREVIEW_FILE_CMD
or set -U FZF_PREVIEW_FILE_CMD '__fzf_file_preview'

set -q FZF_HIGHLIGHT_CMD
or set -U FZF_HIGHLIGHT_CMD '__fzf_highlight_cmd'

set -q FZF_PREVIEW_DIR_CMD
or set -U FZF_PREVIEW_DIR_CMD "__fzf_dir_preview"

function fzf_uninstall -e fzf_uninstall
  # Erase env vars and __fzf functions here.
end