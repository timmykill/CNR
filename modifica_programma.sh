#!/bin/bash

PROGRAMMA="$(pwd)"/Controllo_Stub_Automatico_2.1.2.ino #Sostituire con la directory del programma arduino da modificare
NEW_PROGRAMMA="$(pwd)"/"$(basename "$PROGRAMMA" .ino)_modificato.ino" #Nome e directory del nuovo programma
N_VARIABILI="3"		#Sostituire con il numero dei grep_point presenti nel programma

cp "$PROGRAMMA" "$NEW_PROGRAMMA"
for (( VARIABILE=1; VARIABILE<="$N_VARIABILI"; VARIABILE++ )); do
    	STRINGA=$(grep grep_point_$VARIABILE $PROGRAMMA)
	VALORE=$(echo "$STRINGA" | cut -d"=" -f2 | cut -d";" -f1)
	VALORE_NETTO=$(echo $VALORE | tr -d [:space:])
	NOME_VARIABILE=$(echo "$STRINGA" | tr -d [:space:] | cut -d"=" -f1)
	echo "attualmente il vaore di "$NOME_VARIABILE" e' "$VALORE_NETTO""
	echo "Modificarlo? (y=si, *=no)"
	read YN
	if [ $YN == "y" ]; then
		echo "Inserire il nuovo valore per "$NOME_VARIABILE""
		read NEW_VALORE
		NEW_STRINGA=$(echo $STRINGA | sed s/\="$VALORE"\;/\="$NEW_VALORE"\;/)
		#echo "$NEW_STRINGA"	#Debug
		#echo "$STRINGA"	#Debug
		sed -i s:"$STRINGA":"$NEW_STRINGA": "$NEW_PROGRAMMA"
	fi
done
