#!/bin/bash

DEFAULT="\033[0m"
BOLD="\033[1m"
UNDERLINE="\033[4m"
BLACK="\033[30m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BBLUE="\033[1;34m"
BLUE="\033[0;34m"
PURPLE="\033[35m"
CYAN="\033[36m"
WHITE="\033[37m"

T_PATH=mtests
M_PATH=${T_PATH}/main
O_PATH=${T_PATH}/out
R_PATH=${T_PATH}/results

exec 2> /dev/null

result()
{
	rm -f ${O_PATH}/${1}${2}.out
	gcc -I./includes ${M_PATH}/${1}${2}.c -L./ -lftprintf -o ${O_PATH}/${1}${2}.out 2> /dev/null
	${O_PATH}/${1}${2}.out > ${R_PATH}/${1}${2}.txt
}

print_conv()
{
	if [ ${1} = "%" ]
	then
		printf "%%%${1}:\t"
	else
		printf "%%${1}:\t"
	fi
}

compile()
{
	result ${1} pf
	result ${1} ft
	rm -f ${R_PATH}/${1}.diff
	if [ -e ${O_PATH}/${1}ft.out ]
	then
		DIFF=$(diff ${R_PATH}/${1}pf.txt ${R_PATH}/${1}ft.txt)
		if [ "${DIFF}" != "" ]
		then
			print_conv ${1}
			printf "${RED}>>>>>>>>>> FAILURE <<<<<<<<<<\n${DEFAULT}"
			echo "${DIFF}" > ${R_PATH}/${1}.diff
		else
			print_conv ${1}
			printf "${GREEN}>>>>>>>>>> SUCCESS <<<<<<<<<<\n${DEFAULT}"
		fi
	else
		print_conv ${1}
		printf "${CYAN}>>>>>>>>>> _ERROR_ <<<<<<<<<<\n${DEFAULT}"
	fi
}

for ARG in ${@}
do
	if [ $# -eq 0 ]
	then
		make fclean && make
	elif [ ${ARG} = "%" ]
	then
		make
		compile %
	elif [ ${ARG} = "s" ]
	then
		make
		compile s
	elif [ ${ARG} = "S" ]
	then
		make
		compile su
	elif [ ${ARG} = "p" ]
	then
		make
		compile p
	elif [ ${ARG} = "d" ]
	then
		make
		compile d
	elif [ ${ARG} = "D" ]
	then
		make
		compile du
	elif [ ${ARG} = "i" ]
	then
		make
		compile i
	elif [ ${ARG} = "o" ]
	then
		make
		compile o
	elif [ ${ARG} = "O" ]
	then
		make
		compile ou
	elif [ ${ARG} = "u" ]
	then
		make
		compile u
	elif [ ${ARG} = "U" ]
	then
		make
		compile uu
	elif [ ${ARG} = "x" ]
	then
		make
		compile x
	elif [ ${ARG} = "X" ]
	then
		make
		compile xu
	elif [ ${ARG} = "c" ]
	then
		make
		compile c
	elif [ ${ARG} = "C" ]
	then
		make
		compile cu
	elif [ ${ARG} = "all" ]
	then
		make
		compile %
		compile s
		compile su
		compile p
		compile d
		compile du
		compile i
		compile o
		compile ou
		compile u
		compile uu
		compile x
		compile xu
		compile c
		compile cu
	elif [ ${ARG} = "clean" ]
	then
		make fclean
		rm -f *.out
		rm -f ${O_PATH}/*
		rm -f ${R_PATH}/*
	fi
done
