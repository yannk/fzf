function __fzf_dir_preview -d "Preview directory in side panel"
    if command_exists lsd
        lsd --group-dirs first -l --color always $argv[1]
    else
        ls -l $argv[1]
    end
end
