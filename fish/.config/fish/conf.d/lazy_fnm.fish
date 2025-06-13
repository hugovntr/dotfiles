function __fnm_lazy_init
    functions -e fnm node npm
    fnm env --use-on-cd --shell fish | source
    functions -e __fnm_lazy_init
    commandline -f repaint
end

function node --wraps=node --description 'fnm: node lazy loader'
    __fnm_lazy_init
    command node $argv
end

function npm --wraps=npm --description 'fnm: npm lazy loader'
    __fnm_lazy_init
    command npm $argv
end

function fnm --wraps=fnm --description 'fnm lazy loader'
    __fnm_lazy_init
    command fnm $argv
end
