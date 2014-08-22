# This tmux statusbar config was created by tmuxline.vim
# on Thu, 14 Aug 2014

set -g status-bg 'colour232'
set -g message-command-fg 'colour202'
set -g status-justify 'right'
set -g status-left-length '100'
set -g status 'on'
set -g pane-active-border-fg 'colour232'
set -g message-bg 'colour232'
set -g status-right-length '100'
set -g status-right-attr 'none'
set -g message-fg 'colour202'
set -g message-command-bg 'colour232'
set -g status-attr 'none'
set -g status-utf8 'on'
set -g pane-border-fg 'colour232'
set -g status-left-attr 'none'
setw -g window-status-fg 'colour7'
setw -g window-status-attr 'none'
setw -g window-status-activity-bg 'colour232'
setw -g window-status-activity-attr 'underscore'
setw -g window-status-activity-fg 'colour7'
setw -g window-status-separator ''
setw -g window-status-bg 'colour232'
set -g status-left '#[fg=colour45,bg=colour232] #S #[fg=colour232,bg=colour232,nobold,nounderscore,noitalics]#[fg=colour202,bg=colour232] #I:#P  #F #[fg=colour232,bg=colour232,nobold,nounderscore,noitalics]#[fg=colour7,bg=colour232] #h #[fg=colour232,bg=colour232,nobold,nounderscore,noitalics]'
set -g status-right '#[fg=colour232,bg=colour232,nobold,nounderscore,noitalics]#[fg=colour7,bg=colour232] #($HOME/.tmux/ip-address) #[fg=colour232,bg=colour232,nobold,nounderscore,noitalics]#[fg=colour202,bg=colour232] %H:%M %d-%b-%y '
setw -g window-status-format '#[fg=colour232,bg=colour232,nobold,nounderscore,noitalics]#[default] #I  #W #[fg=colour232,bg=colour232,nobold,nounderscore,noitalics]'
setw -g window-status-current-format '#[fg=colour232,bg=colour232,nobold,nounderscore,noitalics]#[fg=colour202,bg=colour232] #I  #W #[fg=colour232,bg=colour232,nobold,nounderscore,noitalics]'
