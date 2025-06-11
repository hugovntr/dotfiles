function fish_user_key_bindings
    fish_vi_key_bindings

    # Mode maps: default, insert, visual, and default/command
    bind -M visual 'y' yank_selection_and_copy
    bind -M visual 'x' delete_selection_and_copy
    bind -M visual 'd' delete_selection_and_copy
    bind -M visual 'c' change_selection_and_copy
    bind -M visual 's' substitute_selection_and_copy
    bind -M visual 'p' replace_selection_from_clipboard

    bind -M default 'p' put_after_clipboard
    bind -M default 'P' put_before_clipboard
    bind -M default 'S' substitute_whole_line_and_copy
    bind -M default 'C' change_to_eol_and_copy
    bind -M default 'yy' fish_clipboard_copy

    # Optional movement remaps (custom layout)
    bind -M default 'm' forward-char
    bind -M default 'j' backward-char
    bind -M default 'l' down-or-search
    bind -M default 'k' up-or-search

    # Custom insert escape
    # bind -M insert -m insert 'k' kl_escape
    bind -M insert -m default k,l cancel repaint-mode
    set -g fish_sequence_key_delay_ms 200
end

function yank_selection_and_copy
    commandline -s | fish_clipboard_copy
    # fish_clipboard_copy
    # commandline -r (commandline -b)""
    # commandline -f repaint
end

function delete_selection_and_copy
    fish_clipboard_copy
    commandline -f delete-selection
end

function change_selection_and_copy
    fish_clipboard_copy
    commandline -f change-selection
end

function substitute_selection_and_copy
    fish_clipboard_copy
    commandline -f kill-selection
    commandline -f beginning-of-line
end

function replace_selection_from_clipboard
    commandline -f kill-selection
    pbpaste | commandline -i
end

function put_after_clipboard
    # set cursor_pos (commandline -C)
    # commandline -C (math $cursor_pos + 2)
    fish_clipboard_paste
end

function put_before_clipboard
    fish_clipboard_paste
end

function substitute_whole_line_and_copy
    fish_clipboard_copy
    commandline -f beginning-of-line
    commandline -f kill-whole-line
end

function change_to_eol_and_copy
    fish_clipboard_copy
    commandline -f kill-line
end
