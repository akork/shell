# to reload bash: bash --login
# login shell:
#       /etc/profile (evals path_helper)
#       ~/.bash_profile (or ~/.bash_login or ~/.profile) (loads ~/.bashrc) (miniconda code here)
# non-login shell:
#       /etc/bashrc
#       ~/.bashrc

if [[ ! -z "${SHELL_LOG}" ]]; then
	echo "~/yd/cfg/sh/sh.sh"
fi


# help

#ps -ef | grep 'jupyter' | grep -v grep | awk '{print $2}' | xargs kill -9

# variables {{{

export scratch='/Users/ak/Dropbox/Studies/_CS/playground/scratch'
export CF='/users/ak/yd/cfg/'
export D="$HOME/yd/"
export DT="$HOME/yd/trnt/"
export DD="$HOME/Downloads/"
export CS="$HOME/yd/cs/"

# export PROMPT_COMMAND='echo -ne "\033]0;$PWD\007"'
export JAVA_HOME="/Library/Java/JavaVirtualMachines/openjdk-12.0.1.jdk/Contents/Home"

# }}}
# path {{{

# /etc/paths
export PATH="$CF""scripts:$PATH"
#export PATH="/opt/local/bin:$PATH" # macports location

# }}}
# aliases {{{

#ls
eval `gdircolors ~/.dircolors`
alias i='gls -lBs --color=auto'
alias ii='gls -B --color=auto'
alias ia='gls -lABs --color=auto'
alias iaa='gls -lAs --color=auto'


# navigation
alias c='cd'
alias di='dirs -v | head -10'
alias dip='cd ~1'
alias di2='cd ~2'
alias di3='cd ~3'
alias di4='cd ~4'
alias di5='cd ~5'
alias di6='cd ~6'
alias pd='popd'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'

alias pse='ps -ef | grep'

# open
alias o='open'
alias oa='open -a'
alias code='open -a Visual\ Studio\ Code'
alias otp='dl && open $topdownload'
alias ods='dl && open $topdownload'
# alias topd='dl && open $topdownload'

# git
# git config --global alias.hist "log --pretty=format:'%C(yellow)[%ad]%C(reset) %C(green)[%h]%C(reset) | %C(bold white)%s %C(reset) %C(green){{%an}}%C(reset) %C(bold red)%d%C(reset)' --graph --date=short"
alias s='git status'
alias hist='git hist'
alias gs='git status'
alias gc='git commit -m'
alias gca='git commit -am'
alias gr='git reset'
alias kraken='open -a Gitkraken --args -p "$(pwd)"'

# emacs
alias ee='emacs -nw --debug-init'
alias em='emacs &!'
alias ema='env HOME=/Users/ak/.emacs-vanilla emacs -nw'
alias emac='env HOME=/Users/ak/.emacs-vanilla emacs &!'
alias emacsd='emacs --daemon'
alias ec='emacsclient -c'
alias et='emacsclient -t'
alias e.='emacsclient -t .'

#transmission
alias tr=transmission-remote
alias trla='transmission-remote -l'
alias trl='transmission-remote -l | perl $CF/scripts/trl.pl'
alias trdf='transmission-daemon --foreground'
alias trd='transmission-daemon'

#apps
alias vi=vim
alias py='python3'
alias jn='jupyter notebook'
alias cal='gcal --starting-day=1 .+'

#alias g++='ASAN_OPTIONS=detect_leaks=1 && /usr/local/Cellar/llvm/9.0.0/bin/clang++ -isystem /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include'

# mkdir -p ~/.emacs.d/eshell
# alias | sed 's/^alias //' | sed -E "s/^([^=]+)='(.+)'$/\1=\2/" | sed "s/'\\\\''/'/g" | sed "s/'\\\\$/'/;" | sed -E 's/^([^=]+)=(.+)$/alias \1 \2/' >~/.emacs.d/eshell/alias

# }}}
# functions {{{

# transmission:
tri () {
    transmission-remote -t $1 -i
}

trad () {
	transmission-remote -t $1 -rad
}

# fancy transmission-remote list
trss () {
	trl | awk 'NR<2 {printf "%-4s %+4s %+8s %+2s %-8s %+5s %-8s %s\n", $1, $2, $3, "B", $4, $6, $08, substr($0, index($0, $09))}
		  	   NR>1 {printf "%-4s %+4s %+8s %+2s %-8s %+5s %-8s %s\n", $1, $2, $3, $4, $5, $7, $9, substr($0, index($0, $10))}'
}

# recent downloads

# each file in the tree and its timeAdded:
mdl () {
	find . -type f | gsed 's/^\(.*\)$/printf "\\"\1\\"  "; mdls -name kMDItemDateAdded "\1"/e'
}

trdir () {
    topdownload="$(cd $tdir && mdls -name kMDItemFSName -name kMDItemDateAdded $tdir/* | \
                 sed 'N;s/\n//' | \
                 awk '{print $3 " " $4 " " substr($0,index($0,$7))}' | \
                 sort -r | \
                 cut -d'"' -f2 | \
                 awk 'NR < 2 { print }')"
    mdls -name kMDItemFSName -name kMDItemDateAdded $tdir/* | \
        sed 'N;s/\n//' | \
	awk '{print $3 " " $4 " " substr($0,index($0,$7))}' | \
	sort -r | \
	cut -d'"' -f2 | \
	awk 'NR < 6 { print }'
}

topd () {
    # topdownload="$(cd $dl && mdls -name kMDItemFSName -name kMDItemDateAdded $dl/* | \
    #              sed 'N;s/\n//' | \
    #              awk '{print $3 " " $4 " " substr($0,index($0,$7))}' | \
    #              sort -r | \
    #              cut -d'"' -f2 | \
    #              awk 'NR < 2 { print }')"
    mdls -name kMDItemFSName -name kMDItemDateAdded $DD/* | \
        sed 'N;s/\n//' | \
		awk '{print $3 " " $4 " " substr($0,index($0,$7))}' | \
		sort -r | \
		cut -d'"' -f2 | \
		awk 'NR < 6 { print }'
}

topt () {
    # topdownload="$(cd $dl && mdls -name kMDItemFSName -name kMDItemDateAdded $dl/* | \
    #              sed 'N;s/\n//' | \
    #              awk '{print $3 " " $4 " " substr($0,index($0,$7))}' | \
    #              sort -r | \
    #              cut -d'"' -f2 | \
    #              awk 'NR < 2 { print }')"
    mdls -name kMDItemFSName -name kMDItemDateAdded $DT/* | \
        sed 'N;s/\n//' | \
		awk '{print $3 " " $4 " " substr($0,index($0,$7))}' | \
		sort -r | \
		cut -d'"' -f2 | \
		awk 'NR < 6 { print }'
}


recent () {
    date +'%Y-%m-%d %T';
    # mdls -name kMDItemFSName -name kMDItemContentCreationDate -name kMDItemContentType * .* | \
	mdls -name kMDItemFSName -name kMDItemDateAdded -name kMDItemContentType * .* | \
	paste - - - | \
	perl -ln  -e '
		 $date_col = 5;
		 $time_col = 6;
	     /"(.+,?)".*"(.+?)"/;
	     $type = $1;
	     $name = $2;
	     @s = split;
	     if ($s[$date_col] ne "(null)") {
	     	if ($type eq "public.folder") {
			   $type = "folder";
	     	} else {
			   $type = "------";
	     	}
	        print $type, " ", $s[$date_col], " ", $s[$time_col], " ", $name;
	     }
    ' | \
	sort -k2,3 -r | less
}

# fancy type
ty () {
   type -a $1
   type -a $1 | perl -lne 'print /(\/.*[ \)]?)/;' | xargs -n 1 ls -l
   type -a $1 | perl -lne 'print /(\/.*[ \)]?)/;' | xargs -n 1 readlink
}

tp () {
	type -a $1 | tp.py
}

# jupyter lab
jl () {
	if [[ $# -eq 0 ]]; then
		jupyterdir=""
	else
		jupyterdir=$1
	fi
	py -m jupyter lab $jupyterdir --browser safari
}

# }}}
