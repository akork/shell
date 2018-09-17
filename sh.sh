# shopt -s expand_aliases
# to reload bash: bash --login

# variables {{{

export scratch='/Users/Aleksey/Dropbox/Studies/_CS/playground/scratch'
export dot='/users/aleksey/dropbox/settings'
export dl='/users/aleksey/downloads'
export PROMPT_COMMAND='echo -ne "\033]0;$PWD\007"'
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home"

# }}}
# path {{{

export PATH="$dot/scripts:$PATH"
export PATH="/Users/Aleksey/anaconda3/bin:$PATH"
export PATH="/opt/local/bin:$PATH" # macports location

# }}}
# aliases {{{

# navigation
alias pd='popd'
alias dp='popd'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'

# ls
alias s='ls -G'
alias s.='ls -aG'
alias s..='ls -alG'

alias d='ls'
alias d.='ls -a'
alias d..='ls -al'

# open
alias o='open'
alias op='open -a'
alias otp='ds && open $topdownload'
alias ods='ds && open $topdownload'
alias topd='ds && open $topdownload'

# git
git config --global alias.hist "log --pretty=format:'%C(yellow)[%ad]%C(reset) %C(green)[%h]%C(reset) | %C(bold white)%s %C(reset) %C(green){{%an}}%C(reset) %C(bold red)%d%C(reset)' --graph --date=short"
alias gs='git status'
alias gc='git commit -m'
alias gca='git commit -am'
alias gr='git reset'
alias kraken='open -a Gitkraken --args -p "$(pwd)"'

# emacs
alias e='emacs -nw --debug-init'
alias em='emacs &!'
alias ema='env HOME=/Users/Aleksey/.emacs-vanilla emacs -nw'
alias emac='env HOME=/Users/Aleksey/.emacs-vanilla emacs &!'

# binaries
alias cal='gcal --starting-day=1 .+'
alias py='python3'
#alias vi='stty stop '' -ixoff ; vim'
alias vi=vim
alias tr=transmission-remote
alias trl='transmission-remote -l'
alias trt='transmission-remote -t'

# }}}
# functions {{{

# recent downloads

# each file in the tree and its timeAdded:
mdl () {
	find . -type f | gsed 's/^\(.*\)$/printf "\\"\1\\"  "; mdls -name kMDItemDateAdded "\1"/e'
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

rec () {
    date +'%Y-%m-%d %T';
    mdls -name kMDItemFSName -name kMDItemDateAdded * | \
	paste - - | \
	perl -ln  -e '
	     use Shell; /"(.+?)"/;
	     $name = $1;
	     @s = split;
	     print $s[2], " ", $s[3], " ", $name
    ' | \
	sort -r
}

ds () {
    cd $dl
    rec
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
