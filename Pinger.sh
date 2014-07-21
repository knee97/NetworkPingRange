#!/bin/bash
#Name: Network-Komplettping
#Author: Nils Kneemeyer
#Task: Pingt das gesamte Netzwerk von 192.168.1. min bis max
 
Prg="[Network Pinger]: "
 
clear
 
echo $Prg "Network-Komplettping durchfuehren? [j/n]"
read aw
if [ $aw -ne "j" ]
then echo $Prg "Auf Wiedersehen"
exit
fi
 
clear
 
echo $Prg"Networkping wird ausgefuehrt..."
echo
echo $Prg"Bitte stellen sie die Adress-Range ein"
echo "  Beginnen bei:"; read min
 
echo "  Beenden bei:"; read max
var=$min
typeset -i var
ipb=192.168.1.
n=0
typeset -i n
 
echo $ipb
echo $Prg"Das wird etwas dauern. Bei Bedarf holen sie sich jetzt ihren Kaffee!"
echo
echo `date` >> History.list
while [ $var -le $max ]
    do ipn=$ipb$var
    echo $ipn
    r=`ping -c 1 $ipn|grep "packet loss" |awk '{print $4}'`
    let var=1+$var
    #echo $r
    if [ $r == 1 ]
        then echo "  ist online."
        echo "    $ip" >> History.list
        array[$n]=$ipn
        let n=1+$n
    fi
     
    if [ $r == 0 ]
        then echo "  ist nicht erreichbar."
    fi
done
 
clear
echo "##Auswertung##"
echo "_______________"
echo "Rechner online:"
echo "---------------"
echo ${#array[*]}
echo
 
typeset -i dspl
let dspl=0
 
echo "+--------------------+ "
echo "|Derzeit erreichbar: | "
echo "+--------------------+ "
while [ $dspl -lt ${#array[*]} ]
    do echo "|   " ${array[$dspl]} "  |"
    dspl=1+$dspl
done
 
echo "+--------------------+ "
 
echo
echo
echo "">> History.list
echo "">> History.list
echo $Prg "Programm beendet."
