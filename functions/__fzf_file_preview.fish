function __fzf_pretty_print -a filepath cmd
    if command_exists bat
        eval "$cmd" | bat --file-name "$filepath" --line-range :200 --paging never -f -l coffee
    else
        eval "$cmd"
    end
end

function __fzf_file_preview -a filepath -d "Preview file in side panel"
    set mime (file --brief --mime $filepath)
    set ftype (file --brief $filepath)

    if string match -q -- "image/*" "$mime" || string match -q -- "*/pdf;*" "$mime"
        if command_exists kitty
            kitty icat --clear --transfer-mode file
            timeout 10s kitty icat --place ( math "$COLUMNS / 2 - 4" )x"$FZF_PREVIEW_LINES"@( math "$COLUMNS / 2" )x0 --transfer-mode file --align right $filepath
        else if command_exists timg
            timg -E --frames=1 --loops=1 -g ( math "$COLUMNS / 2 - 4" )x"$FZF_PREVIEW_LINES" $filepath
        end
    else if string match -qr -- "archiv|compress" "$ftype"
        if string match -qr -- "\.tar" "$filepath"
            __fzf_pretty_print "$filepath" "tar -tvf $filepath"
        else
            __fzf_pretty_print "$filepath" "7z l -bso0 -bsp0 $filepath | egrep -v '^(Listing|Path|Type|Physical|\$)'"
        end
    else if string match -q -- "*binary" "$mime"
        if command_exists hexyl
            hexyl -n 512 --color always $filepath
        else
            xxd -l512 $filepath
        end
    else if string match -q -- "CSV *" "$mime" || string match -rq -- '\.[tc]sv$' $filepath
        tv $filepath
    else
        if command_exists bat
            bat --line-range :200 --paging never -f $filepath
        else
            head -n 200 $filepath
        end
    end
end
