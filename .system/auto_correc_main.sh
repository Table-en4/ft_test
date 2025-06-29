# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    auto_correc_main.sh                                :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jcluzet <jcluzet@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/06/20 02:26:11 by jcluzet           #+#    #+#              #
#    Updated: 2025/06/19 11:28:14 by molapoug         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FILE="../../rendu/$2/$1"
MAIN='main.c'

timeout=1

if [ -e .system/grading/traceback ];then
    rm .system/grading/traceback;
fi

cd .system/grading || exit
gcc -o source "$1" $MAIN
./source "${@:3}" | cat -e > sourcexam       #TESTING
rm source
{
gcc -o final "$FILE" $MAIN
}  2>.dev
{
./final "${@:3}" | cat -e > finalexam &       #TESTING
PID=$!
}  &>/dev/null

# loop 1 second for 20 sec
for i in {1..2}
do
    sleep 0
    # if PID is not running, then exit
    # if i is 5, 10, 15, 19 then echo "waiting..."
    if [ "$i" -eq 1 ] || [ "$i" -eq 1 ] || [ "$i" -eq 1 ] || [ "$i" -eq 1 ]; then
        echo "waiting..."
    fi
    if ! ps -p $PID > /dev/null
    then
        timeout=0
        break
    fi
done

DIFF=$(diff sourcexam finalexam)
#if diff is not empty, then there is a difference, or if timeout is 1
if [ "$DIFF" != "" ] || [ $timeout -eq 1 ]
then
        echo "----------------8<-------------[ START TEST " >> traceback
        printf "        💻 TEST\n./a.out " >> traceback
        # print all the arguments, begin by the 3rd
        for i in "${@:3}"
        do
            printf "\"%s\" " "$i" >> traceback
        done
        printf "        🔎 YOUR OUTPUT:\n" >> traceback
        cat finalexam >> traceback
        if [ $timeout -eq 1 ]
        then
        printf "   ❌ TIMEOUT\n" >> traceback
		elif [ -e final ]
		then
        printf "        🗝 EXPECTED OUTPUT:\n" >> traceback
		cat sourcexam >> traceback
		else 
        printf "\n";
        cat .dev >> traceback
        rm .dev
		printf "\n        ❌ COMPILATION ERROR\n" >> traceback
		fi
        echo "----------------8<------------- END TEST ]" >> traceback
fi
{
rm final
rm finalexam
rm sourcexam
} &>/dev/null
cd ../..
