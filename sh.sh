# to reload bash: bash --login
# login shell:
#       /etc/profile (evals path_helper)
#       ~/.bash_profile (or ~/.bash_login or ~/.profile) (loads ~/.bashrc)
# non-login shell:
#       /etc/bashrc
#       ~/.bashrc

echo "~/yd/cfg/sh/sh.sh loading"

# variables {{{

export scratch='/Users/ak/Dropbox/Studies/_CS/playground/scratch'
export dot='/users/ak/dropbox/settings'
export dl='/users/ak/downloads'
# export PROMPT_COMMAND='echo -ne "\033]0;$PWD\007"'
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home"

# }}}
# path {{{

# /etc/paths
export PATH="$dot/scripts:$PATH"
export PATH="/Users/ak/anaconda3/bin:$PATH"
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

alias d='ls -l'
alias d.='ls -la'

# open
alias o='open'
alias op='open -a'
alias otp='dl && open $topdownload'
alias ods='dl && open $topdownload'
alias topd='dl && open $topdownload'

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
alias ema='env HOME=/Users/ak/.emacs-vanilla emacs -nw'
alias emac='env HOME=/Users/ak/.emacs-vanilla emacs &!'
alias emacsd='emacs --daemon'
alias ec='emacsclient -c'
alias et='emacsclient -t'
alias e.='emacsclient -t .'

# binaries
alias cal='gcal --starting-day=1 .+'
alias py='python3'
#alias vi='stty stop '' -ixoff ; vim'
alias vi=vim
alias tr=transmission-remote
alias trl='transmission-remote -l'
# alias tri='transmission-remote -t '
alias trdf='transmission-daemon --foreground'
alias trd='transmission-daemon'

alias | sed 's/^alias //' | sed -E "s/^([^=]+)='(.+?)'$/\1=\2/" | sed "s/'\\\\''/'/g" | sed "s/'\\\\$/'/;" | sed -E 's/^([^=]+)=(.+)$/alias \1 \2/' >~/.emacs.d/eshell/alias

# }}}
# functions {{{

# transmission:
tri () {
    transmission-remote -t $1 -i
}

# recent downloads

# each file in the tree and its timeAdded:
mdl () {
	find . -type f | gsed 's/^\(.*\)$/printf "\\"\1\\"  "; mdls -name kMDItemDateAdded "\1"/e'
}

dl () {
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

recent () {
    date +'%Y-%m-%d %T';
    mdls -name kMDItemFSName -name kMDItemContentCreationDate -name kMDItemContentType * .* | \
	paste - - - | \
	perl -ln  -e '
	     /"(.+?)".*"(.+?)"/;
	     $type = $1;
	     $name = $2;
	     @s = split;
	     if ($s[2] ne "(null)") {
	     	if ($type eq "public.folder") {
	           print "folder ", $s[2], " ", $s[3], " ", $name;
	     	} else {
	          print "------ ", $s[2], " ", $s[3], " ", $name;
	     	}
	     }
    ' | \
	sort -k2,3 -r | less
}

ds () {
    cd $dl
    recent
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
