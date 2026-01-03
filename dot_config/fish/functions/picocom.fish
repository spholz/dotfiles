function picocom
  tput BD # turn off bracketed paste mode
  command picocom -q $argv
end
