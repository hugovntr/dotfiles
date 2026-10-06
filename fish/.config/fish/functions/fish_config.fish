# Shadow fish's built-in fish_config to skip the default-theme load that
# runs on every interactive startup (`fish_config theme choose default
# --no-override`, ~1ms). This config uses its own theme pipeline
# (bin/themes/set-theme.ts), so fish's theme system is not needed.
#
# To restore fish's built-in fish_config (webconfig UI): delete this file.
function fish_config --description "Skip fish's startup default-theme load"
    if test "$argv" = "theme choose default --no-override"
        return 0
    end
    echo "fish_config: stubbed by ~/.dotfiles/fish (skips the startup default-theme load)." >&2
    echo "To restore fish's built-in implementation: rm ~/.config/fish/functions/fish_config.fish" >&2
    return 1
end
