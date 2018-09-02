# shopt -s expand_aliases
# to reload bash: bash --login

# variables {{{

export scratch='/Users/Aleksey/Dropbox/Studies/_CS/playground/scratch'
export dot='/users/aleksey/dropbox/settings'
export PROMPT_COMMAND='echo -ne "\033]0;$PWD\007"'
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home"

# }}}
# path {{{

export PATH="$dot/scripts:$PATH"
export PATH="/Users/Aleksey/anaconda3/bin:$PATH"

# }}}
# aliases {{{

# navigation
alias pd='popd'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'

# ls
alias s='ls -G'
alias s.='ls -a'
alias s..='ls -al'

alias d='ls -G'
alias d.='ls -a'
alias d..='ls -al'

# open
alias op='open -a'
alias otp='ds && open $topdownload'
alias ods='ds && open $topdownload'

# git
git config --global alias.hist "log --pretty=format:'%C(yellow)[%ad]%C(reset) %C(green)[%h]%C(reset) | %C(bold white)%s %C(reset) %C(green){{%an}}%C(reset) %C(bold red)%d%C(reset)' --graph --date=short"
alias gs='git status'
alias gc='git commit -m'
alias gca='git commit -am'
alias gr='git reset'
alias kraken='open -a Gitkraken --args -p "$(pwd)"'

# emacs
alias e='emacs -nw --debug-init'
alias nem='sudo nohup env HOME=~/dropbox/settings/emacs_clean emacs &'
alias se='sudo env HOME=~/dropbox/settings/emacs_clean emacs -nw'
alias sem='sudo env HOME=~/dropbox/settings/emacs_clean emacs'

# binaries
alias cal='gcal --starting-day=1 .+'
alias py='python3'
#alias vi='stty stop '' -ixoff ; vim'
alias vi=vim

# }}}
# functions {{{

# recent downloads
ds () {
    DOWNLOADS="$HOME/Downloads"
    cd $DOWNLOADS
    mdls -name kMDItemFSName -name kMDItemDateAdded $DOWNLOADS/* | \
                 sed 'N;s/\n//' | \
                 awk '{print $3 " " $4 " " substr($0,index($0,$7))}' | \
                 sort -r | \
                 cut -d'"' -f2 | \
                 awk 'NR < 11 { print }'
}

ds () {
    DOWNLOADS="$HOME/Downloads"
    cd $DOWNLOADS
    topdownload="$(mdls -name kMDItemFSName -name kMDItemDateAdded $DOWNLOADS/* | \
                 sed 'N;s/\n//' | \
                 awk '{print $3 " " $4 " " substr($0,index($0,$7))}' | \
                 sort -r | \
                 cut -d'"' -f2 | \
                 awk 'NR < 2 { print }')"
    mdls -name kMDItemFSName -name kMDItemDateAdded $DOWNLOADS/* | \
                 sed 'N;s/\n//' | \
                 awk '{print $3 " " $4 " " substr($0,index($0,$7))}' | \
                 sort -r | \
                 cut -d'"' -f2 | \
                 awk 'NR < 6 { print }'
}

# mkdir, cd into it
dir () {
  mkdir -pv "$*"
  cd "$*"
}

# fancy type
ty () {
   type -a $1
   type -a $1 | perl -lne 'print /(\/.*[ \)]?)/;' | xargs -n 1 ls -l
   type -a $1 | perl -lne 'print /(\/.*[ \)]?)/;' | xargs -n 1 readlink
}

# cd & list
ca () {
	cd "$*"
	la
}

# }}}
