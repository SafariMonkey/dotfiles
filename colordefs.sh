#! /bin/bash

RESETALL="[0m"
RESET="[21;22;23;24;25;27;28m"

BOLD="[1m"
DIM="[2m"
ITALIC="[3m"
UNDERLINE="[4m"
BLINK="[5m"
REVERSE="[7m"
HIDE="[8m"

UNBOLD="[21m"
UNDIM="[22m"
UNITALIC="[23m"
UNUNDERLINE="[24m"
UNBLINK="[25m"
UNREVERSE="[27m"
UNHIDE="[28m"

DEFAULT="[39m"

BLACK="[30m"
RED="[31m"
GREEN="[32m"
YELLOW="[33m"
BLUE="[34m"
MAGENTA="[35m"
CYAN="[36m"
GREY="[37m"
DGREY="[90m"
LRED="[91m"
LGREEN="[92m"
LYELLOW="[93m"
LBLUE="[94m"
LMAGENTA="[95m"
LCYAN="[96m"
WHITE="[97m"

showcols() {
	for k in BLACK RED GREEN YELLOW BLUE MAGENTA CYAN GREY DGREY LRED LGREEN LYELLOW LBLUE LMAGENTA LCYAN WHITE; do
		echo "${!k}$k $BOLD(BOLD)$UNBOLD";
	done
}

BGDEFAULT="[49m"

BGBLACK="[40m"
BGRED="[41m"
BGGREEN="[42m"
BGYELLOW="[43m"
BGBLUE="[44m"
BGMAGENTA="[45m"
BGCYAN="[46m"
BGGREY="[47m"
BGDGREY="[100m"
BGLRED="[101m"
BGLGREEN="[102m"
BGLYELLOW="[103m"
BGLBLUE="[104m"
BGLMAGENTA="[105m"
BGLCYAN="[106m"
BGWHITE="[107m"
