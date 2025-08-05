# if status is-interactive
  # Check if we're in interactive shell
  # Initialize starship
  set -gx STARSHIP_CONFIG $XDG_CONFIG_HOME/starship/fish.toml
  function starship_transient_prompt_func
    starship module character
  end
  function starship_transient_rprompt_func
    starship module time
  end
  function __starship_lazy_init --on-event fish_prompt
    starship init fish | source
    emit starship_ready
    enable_transience
  end

  function fish_prompt
    if not set -q __starship_initialized
      set -g __starship_initialized 1
      emit fish_prompt
      return
    end

    # Only run Starship if it's initialized
    if functions -q starship_prompt
      starship_prompt
    else
      echo -n '> '
    end
  end
# end
