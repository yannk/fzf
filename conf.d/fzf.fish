set -q FZF_SHELL
or set -U FZF_SHELL fish

set -q FZF_TMUX_HEIGHT
or set -U FZF_TMUX_HEIGHT "60%"

set -q FZF_DEFAULT_OPTS
or set -U FZF_DEFAULT_OPTS
 "--height $FZF_TMUX_HEIGHT -i"

set -q FZF_LEGACY_KEYBINDINGS
or set -U FZF_LEGACY_KEYBINDINGS 0

set -q FZF_CUSTOM_KEYBINDINGS
or set -U FZF_CUSTOM_KEYBINDINGS 1

set -q FZF_COMPLETE
or set -U FZF_COMPLETE 3

set -q FZF_ENABLE_OPEN_PREVIEW
or set -U FZF_ENABLE_OPEN_PREVIEW 1

set -q FZF_ENABLE_PREVIEW
or set -U FZF_ENABLE_PREVIEW 1

set -q FZF_PREVIEW_UNIVERSAL_CMD
or set -U FZF_PREVIEW_UNIVERSAL_CMD 'fish -c "__fzf_universal_preview {}"'

set -q FZF_PREVIEW_FILE_CMD
or set -U FZF_PREVIEW_FILE_CMD 'fish -c "__fzf_file_preview {}"'

set -q FZF_PREVIEW_DIR_CMD
or set -U FZF_PREVIEW_DIR_CMD 'fish -c "__fzf_dir_preview {}"'

function fzf_uninstall -e fzf_uninstall
    set -e FZF_TMUX_HEIGHT
    set -e FZF_DEFAULT_OPTS
    set -e FZF_LEGACY_KEYBINDINGS
    set -e FZF_CUSTOM_KEYBINDINGS
    set -e FZF_COMPLETE
    set -e FZF_ENABLE_OPEN_PREVIEW
    set -e FZF_ENABLE_PREVIEW
    set -e FZF_PREVIEW_FILE_CMD
    set -e FZF_PREVIEW_DIR_CMD
end
