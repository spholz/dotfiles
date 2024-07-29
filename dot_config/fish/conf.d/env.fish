set -gx BROWSER firefox
set -gx EDITOR nvim
set -gx MANPAGER 'nvim +Man!'

# don't keep journalctl output on screeen after exiting the pager
set -gx SYSTEMD_LESS 'FRSMK'

# make less able to display more files
set -gx LESSOPEN '|/usr/bin/lesspipe.sh %s'

# disable less history file
set -gx LESSHISTFILE -

# needed for maliit-keyboard
set -gx QT_QUICK_CONTROLS_STYLE org.kde.desktop
