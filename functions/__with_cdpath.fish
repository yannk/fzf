function __with_cdpath
    if test -d "$argv"; or test -d "./$argv"
        echo "$argv"
        return 0
    end

    for dir in $CDPATH
        if test -d "$dir/$argv"
            echo "$dir/$argv"
            return 0
        end
    end
    echo "$argv"
end