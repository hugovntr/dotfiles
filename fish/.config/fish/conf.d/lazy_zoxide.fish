function __zoxide_lazy_init
    functions -e __zoxide_lazy_init
    zoxide init --cmd cd fish | source
    commandline -f repaint
end

function cd --wraps=cd --description 'zoxide lazy loader'
    __zoxide_lazy_init
    cd $argv
end

function cdi --wraps=cdi --description 'zoxide interactive lazy loader'
    __zoxide_lazy_init
    cdi $argv
end
