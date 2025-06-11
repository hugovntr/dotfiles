function cdn
    set -l index $argv[1]
    if test -n "$index"
        set -l path (dirh | tac | awk -v idx="$index)" '$1 == idx {print $2}')
        if test -n "$path"
            cd $path
        end
    end
end
