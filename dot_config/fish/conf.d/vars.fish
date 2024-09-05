# no fish greeting
set -g fish_greeting

# tide
set -g tide_context_hostname_parts 3
set -g tide_left_prompt_items context nix_shell pwd git newline character
set -g tide_right_prompt_items status cmd_duration jobs
set -g tide_prompt_add_newline_before true
set -g tide_prompt_icon_connection ' '
set -g tide_pwd_icon 
set -g tide_pwd_icon_home 
set -g tide_cmd_duration_icon 
set -g tide_git_icon 
set -g tide_left_prompt_separator_diff_color 
set -g tide_left_prompt_separator_same_color 
set -g tide_left_prompt_suffix 
set -g tide_right_prompt_prefix 
set -g tide_right_prompt_separator_diff_color 
set -g tide_right_prompt_separator_same_color 
set -g tide_left_prompt_prefix
set -g tide_right_prompt_suffix
set -g tide_prompt_pad_items true

# tide colors
set -g tide_prompt_color_frame_and_connection 6C6C6C
set -g tide_cmd_duration_bg_color 1C1C1C
set -g tide_context_bg_color 1C1C1C
set -g tide_git_bg_color 1C1C1C
set -g tide_git_bg_color_unstable 1C1C1C
set -g tide_git_bg_color_urgent 1C1C1C
set -g tide_jobs_bg_color 1C1C1C
set -g tide_pwd_bg_color 1C1C1C
set -g tide_python_bg_color 1C1C1C
set -g tide_status_bg_color 1C1C1C
set -g tide_status_bg_color_failure 1C1C1C
set -g tide_vi_mode_bg_color_default 1C1C1C
set -g tide_vi_mode_bg_color_insert 1C1C1C
set -g tide_vi_mode_bg_color_replace 1C1C1C
set -g tide_vi_mode_bg_color_visual 1C1C1C

# enable vi mode
set -g fish_key_bindings fish_vi_key_bindings

# use beam cursor in insert mode
set -g fish_cursor_default block
set -g fish_cursor_insert line
set -g fish_cursor_replace underscore
set -g fish_cursor_replace_one underscore
set -g fish_cursor_visual block
