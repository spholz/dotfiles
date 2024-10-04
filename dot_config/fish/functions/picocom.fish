function picocom
  echo -ne '\e[?2004l'
  command picocom $argv
end
