function d
  if test (count $argv) -gt 0
    dirs $argv
  else
    dirh | tac | head -n 10
  end
end
