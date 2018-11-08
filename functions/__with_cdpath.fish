function __with_cdpath
    for dir in $CDPATH
        if test -d "$dir/$argv"
            echo "$dir/$argv"
            return 0
        end
    end
    echo ''
    return 1
end