function ssh --description 'alias ssh=kitten ssh'
  if test $TERM = "xterm-kitty"
    command kitten ssh $argv;
  else
    command ssh $argv;
  end
end
