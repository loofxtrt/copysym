#!/bin/bash

# script que acha todos os ícones válidos pra serem trocados por versões de outras cores
# e cria symlinks das cores diferentes no lugar dos originais

COLOR=$1
ICON_PACK=~/.local/share/icons/copycat

FLAVOR="$ICON_PACK/reserved/folder-flavors/$COLOR"
PLACES="$ICON_PACK/places/scalable"

cd "$PLACES"

if [ ! -e "$FLAVOR" ]; then
    echo Flavor does not exists: "$FLAVOR"
    exit 1 # sai com código de erro
fi

echo Found flavor "$FLAVOR"

for icon in "$PLACES"/*.svg; do
    i_name="${icon##*/}" # nome puro do ícone

    for substitute in "$FLAVOR"/*.svg; do
        s_name="${substitute##*/}" # nome puro do substituto

        # substituir o original por um symlink se for o mesmo nome, indicando que é válido
        # se um arquivo não for válido, significa que ele não tem uma variação disponível
        if [[ "$s_name" == "$i_name" ]]; then
            ln -sf "../../reserved/folder-flavors/$COLOR/$s_name" "$icon"
            echo Changed "$s_name" to "$i_name"
        else
            echo Skipping "$s_name" since it doesn\'t have the same name as "$i_name"
        fi
    done
done