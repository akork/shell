echo "~/yd/cfg/sh/bash.sh loading"

export TERM=screen-256color

PS1=" \[\033[1;33m\][\W]\$ \[\033[0m\]" # default color: \[\033[0m\]"

if [ -n "$INSIDE_EMACS" ]; then
    PS1=" [\W]$ ";
fi

# trap '[[ -t 1 ]] && tput sgr0' DEBUG # reset terminal colors before command executing

LS_COLORS=$LS_COLORS:'di=0;35:' ; export LS_COLORS
export LSCOLORS=ExFxCxDxBxegedabagacad

# trap '/usr/bin/osascript $CONFIGPATH/AppleScript/terminal-quit.scpt' EXIT

#auto-closing Terminal app on last window
if [ "$TERM_PROGRAM" == "Apple_Terminal" ]; then  # && [ -x $CONFIGPATH/AppleScript/terminal-quit.scpt ]; then
    trap '/usr/bin/osascript $CONFIGPATH/AppleScript/terminal-quit.scpt' EXIT
fi

HISTIGNORE="[bf]g:ls:pwd:clear:[ ]*"
