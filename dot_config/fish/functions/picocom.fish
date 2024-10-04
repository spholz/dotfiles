function picocom
  echo -ne '\e[?2004l' # turn off bracketed paste mode
  command picocom $argv
end
