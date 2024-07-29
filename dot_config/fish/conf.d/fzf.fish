set -l fzf_common_command 'command fd --hidden --follow --exclude .git --color=always'

set -gx FZF_DEFAULT_COMMAND "$fzf_common_command --strip-cwd-prefix --type file"
set -gx FZF_DEFAULT_OPTS '--ansi'

set -g FZF_ALT_C_COMMAND "$fzf_common_command --strip-cwd-prefix --type dir"

# make CTRL-T list all files in 'test' when doing 'ls test<CTRL-T>'
set -g FZF_CTRL_T_COMMAND "$fzf_common_command . \$dir --type file 2> /dev/null | sed -E 's#^(\x1b\[[0-9;]+m)\./#\1#'"

fzf --fish | source
