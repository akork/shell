export TERM=screen-256color

PS1=" \[\033[1;33m\][\W]\$ \[\033[1;33m\]" # default color: \[\033[0m\]"
trap '[[ -t 1 ]] && tput sgr0' DEBUG # reset terminal colors before command executing

LS_COLORS=$LS_COLORS:'di=0;35:' ; export LS_COLORS
export LSCOLORS=ExFxCxDxBxegedabagacad


rd () { # recent downloads
    DOWNLOADS="$HOME/Downloads"
    #cd $DOWNLOADS
    mdls -name kMDItemFSName -name kMDItemDateAdded $DOWNLOADS/* | \
                 sed 'N;s/\n//' | \
                 awk '{print $3 " " $4 " " substr($0,index($0,$7))}' | \
                 sort -r | \
                 cut -d'"' -f2 | \
                 awk 'NR < 11 { print }'
}

# mkdir, cd into it
dir () {
  mkdir -pv "$*"
  cd "$*"
}

# type
ty () {
   type -a $1
   type -a $1 | perl -lne 'print /(\/.*[ \)]?)/;' | xargs -n 1 ls -l
   type -a $1 | perl -lne 'print /(\/.*[ \)]?)/;' | xargs -n 1 readlink
}

ca () {
	cd "$*"
	la
}

npro () {
  mkdir ./$1
  cd ./$1
  mkdir src build
	cp -r 
  touch ./src/CMakeLists.txt .dir-locals.el .lvimrc.vim
  echo "let g:runcmd = \"$PWD/$1\"" > .lvimrc.vim
  echo "((c++-mode (helm-make-build-dir . \"$PWD/$1\")))" > .dir-locals.el
  cp -r ~/Dropbox/Studies/_CS/LaTeX/report_template/ ./report/
}

tex () {
	cp -r ~/Dropbox/Studies/_CS/LaTeX/report_template/ ./report/
}

# trap '/usr/bin/osascript $CONFIGPATH/AppleScript/terminal-quit.scpt' EXIT

#auto-closing Terminal app on last window
if [ "$TERM_PROGRAM" == "Apple_Terminal" ]; then  # && [ -x $CONFIGPATH/AppleScript/terminal-quit.scpt ]; then
    trap '/usr/bin/osascript $CONFIGPATH/AppleScript/terminal-quit.scpt' EXIT
fi

git config --global alias.hist "log --pretty=format:'%C(yellow)[%ad]%C(reset) %C(green)[%h]%C(reset) | %C(bold white)%s %C(reset) %C(green){{%an}}%C(reset) %C(bold red)%d%C(reset)' --graph --date=short"

HISTIGNORE="[bf]g:ls:pwd:clear:[ ]*"
