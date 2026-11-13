#!/bin/sh
#Simone Rizzi 213630

#controllo sul numero di parametri
if test $# -ne 3
then 
    echo "numero sbagliato di parametri"
    exit 1
fi
#___________________________________

#controllo dell'indirizzo
case "$2" in 
    /*);;
    *) echo "inserire un nome assoluto di cartella"
    exit 2
    ;;
esac
#_________________________________

#controllo se il terzo parametro è un intero
case "$3" in 
    *[!0-9]*) echo "il terzo parametro deve essere un intero"
    exit 3
    ;;
esac


stringa="$1"
dirSorg="$2"
num="$3"

PATH=$PATH:$(pwd)
export PATH

> /tmp/maxct.txt #crea file temporaneo
cercaFile_rec.sh "$stringa" "$dirSorg" "$num"

dirpazza="$dirSorg"

max=0
while read dir numero # analizza in un file |dir numero| ogni riga
do
    if test "$numero" -gt "$max" #se il numero è piu grande del max esso diventa il max
    then    
        max="$numero"
        dirpazza="$dir" #salva la dir in cui accade queesta situazione 
    fi
done < /tmp/maxct.txt  #serve a dire al while da che file leggere 

echo ""$dirpazza" "$max"" # stampa la dir con le istanze massime 

#rm /tmp/maxct.txt #elimina file temporaneo
