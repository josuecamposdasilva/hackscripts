#!/bin/bash

# Script para adiqurir, filtrar e mostrar / guardar o conteudo das postagens 
# do pastebin.com.

# Verifica se foi passado algum argumento.
# Se nao, mostra uma mensagem de uso na saida padrao e encerra o script.

if [ "$1" == "" ] ; then
	echo
	echo "Uso: $0 texto_filtro num_result"
	echo
	echo "texto_filtro: palavra ou frase (delimitada por aspas) a ser"
	echo "usada como filtro."
	echo
	echo "num_result: numero minimo de buscas a serem realizadas"
	echo
	exit
fi

frase="$( echo "$2" | grep "[a-zA-Z]" )"

if [[ "$2" == "" || "$frase" != "" ]] ; then
	echo
	echo "Uso: $0 texto_filtro num_result"
	echo
	echo "texto_filtro: palavra ou frase (delimitada por aspas) a ser"
	echo "usada como filtro."
	echo
	echo "num_result: numero minimo de buscas a serem realizadas"
	echo
	exit
fi

# Cria os arquivos temporarios 'templinks' e 'templinks_use'.

touch templinks templinks_use

# Cria os diretorios para armazenar os resultados.

mkdir -p $HOME/.pastebin/$(date --iso-8601)/$1/

# Faz um loop de acordo com o argumento sinalizado na inicializacao do script.
# Adquire as URL's das postagens mais recentes.
# Salva o resultado em uma variavel.
# Verifica as URL's da variavel com as contidas no arquivo 'templinks' e 
# salva todas as que nao estao presentes no arquivo, ignorando as que ja 
# estao.

max_result=0

while [ $max_result -lt $2 ] ; do
	
	links="$( curl -s "https://pastebin.com/archive" | grep "i_p0" | cut -d"=" -f5 | cut -d'"' -f2 | tr -d "/" )"

	for l in $links ; do
		r="$( grep "$l" templinks )"
		if [ "$r" == "" ] ; then 
			echo "$l" >> templinks 
		fi
	done

# Ve as diferencas entre o arquivo "templinks" e "templinks_use" e coloca
# o resultado na variavel "templ".


templ="$( diff templinks templinks_use | cut -d" " -f2 | grep "$( cat templinks )" )"

# Le os argumentos da variavel "templ" e os coloca em loop.
# Mostra na saida padrao as URL's que contem o 'texto_filtro'.
# Grava no arquivo padrao o conteudo da URL em questao.

	for a in $( echo "$templ" ) ; do
		r2="$( curl -s https://pastebin.com/raw/$a | grep "$1" )"
		if [ "$r2" != "" ] ; then
			echo "https://pastebin.com/raw/$a"
			echo "$(curl -s https://pastebin.com/raw/$a)" >> $HOME/.pastebin/$(date --iso-8601)/$1/$a
		fi
	done

	echo "$templ" | tr " " "\n" >> templinks_use

	max_result=$(( $max_result+1 ))

	sleep 5

done

rm templinks templinks_use

exit
