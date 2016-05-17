# OPTIONS: http://zsh.sourceforge.net/Doc/Release/Options.html

# Directories
setopt auto_pushd             # Make cd push the old directory onto the directory stack
setopt pushd_ignore_dups      # Don’t push multiple copies of the same directory onto the directory stack

# Globbing
setopt extended_glob          # Treat the '#', '~' and '^' characters as part of patterns

# Scripts and Functions
setopt multios                # Perform implicit tees or cats when multiple redirections are attempted

# Prompting
setopt prompt_subst           # Allow param expansion, command substitution within prompts

# Completion
unsetopt menu_complete        # Do not autoselect the first completion entry
setopt auto_menu              # Show completion menu on succesive tab press
setopt always_to_end          # Move to end of completion when performed
setopt complete_in_word
setopt always_to_end

# History
setopt append_history         # Always append, do not replace history
setopt extended_history
setopt hist_expire_dups_first # Expire duplicate entries first
setopt hist_ignore_dups       # Ignore duplication of previous event
setopt hist_ignore_space      # Do not write history for commands that start with a space
setopt hist_verify            # Require completion confirmation before execution
setopt share_history          # Save history immediately
