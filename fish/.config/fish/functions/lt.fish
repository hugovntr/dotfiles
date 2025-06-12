function lt
  set --local depth 1
  if test (count $argv) -ge 1
    set --local depth $argv[1]
  end
  if command -q eza
    eza --tree -L $depth --git --icons --group --group-directories-first --color=always --color-scale=size --color-scale-mode=gradient --sort=modified
  else
    tree -L $depth
  end
end
