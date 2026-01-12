# automatically update ohmyzsh
DISABLE_UPDATE_PROMPT=true
# Print duration of command if it took more than 10 seconds
REPORTTIME=10
HIST_STAMPS="yyyy-mm-dd"
HISTSIZE=10000000
SAVEHIST=10000000
# disable magic widgets such as URL escaping when pasting
DISABLE_MAGIC_FUNCTIONS=true
# Don't beep when there are no matches for a command.
setopt NO_BEEP
# Don't beep when using the up and down arrow keys to navigate through the command history and there are no more commands to navigate to.
setopt NO_HIST_BEEP
# Don't beep when using the Tab key to list possible completions and there are no more completions to list.
setopt NO_LIST_BEEP
# Don't print an error message when a command doesn't match any files.
setopt NO_NOMATCH
# Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY
# Write to the history file immediately, not when the shell exits.
setopt EXTENDED_HISTORY
# Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_ALL_DUPS
# Do not record an event starting with a space.
setopt HIST_IGNORE_SPACE
# Do not execute immediately upon history expansion.
setopt HIST_VERIFY
# Append to history file (Default)
setopt APPEND_HISTORY
# Remove superfluous blanks from each command line being added to the history.
setopt HIST_REDUCE_BLANKS

# Treat special directories (like .. and ~) as if they were normal files.
zstyle ':completion:*' special-dirs true
# Make the completion system case-insensitive when matching files and directories.
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
