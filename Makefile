init:
	echo "source ~/yd/cfg/sh/sh.sh" > ~/.zshenv

ansi-light:
	cat dircolors/dircolors.ansi-light > ~/.dircolors

256:
	cat dircolors/dircolors.256dark > ~/.dircolors

ansi-dark:
	cat dircolors/dircolors.ansi-dark > ~/.dircolors

ansi-universal:
	cat dircolors/dircolors.ansi-universal > ~/.dircolors

eval:
	eval `gdircolors ~/.dircolors`

