# recent downloads
dl () {
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
