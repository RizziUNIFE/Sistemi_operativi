#!/bin/sh
#Simone Rizzi 213630

stringa="$1"
dirSorg="$2"
num="$3"
somma=0
cd "$dirSorg" || exit 15 #in caso fallisca il cd si interrompeil programma

for i in * #itera tutti i file in dirSorg
do 
    if test -d "$i" #in caso trovi una directory si richiama da solo dando la directory come dirSorg
    then
        cercaFile_rec.sh "$stringa" "$PWD/$i" "$num" 
    fi
    if test -f "$i" -a -r "$i" #se è un file AND(-a) leggibile (-r)
    then
        case "$i" in 
        *.txt) #se il file è un txt 
        if test "$(grep -F -c -- "$stringa" "$i")" -ge "$num" 
        #con grep cerca in quante righe si trova il termine nel file 
        #il -F serve a trattare le righe come testo, -c serve per contare solo le righe in cui accade 
        # -- serve per chiudere il grep 
                then 
                somma=$(expr "$somma" + 1) #aggiungi uno alla somma 
                fi
        esac
    fi
done
echo "$dirSorg" "$somma" >> /tmp/maxct.txt #metti nel file temporaneo la directory e il numero di istanze trovate 
