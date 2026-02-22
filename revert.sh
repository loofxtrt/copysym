#!/bin/bash

# script pra reverter o sistema de flavors por um fixo

# ICON_PACK=~/.local/share/icons/copycat
ICON_PACK=$SEAGATE/recursos/copycat/copycat

RESERVED_RELATIVE="reserved/folders"
RESERVED_FULL="$ICON_PACK/reserved/folders"
PLACES="$ICON_PACK/places/scalable"

cd "$PLACES"

for icon in "$PLACES"/*.svg; do
    i_name="${icon##*/}" # nome puro do ícone
    substitute="$RESERVED_FULL/$i_name"

    # substituir o original por um symlink se for o mesmo nome, indicando que é válido
    # se um arquivo não for válido, significa que ele não tem uma variação disponível
    if [[ -e "$substitute" ]]; then
        ln -sf "../../$RESERVED_RELATIVE/$i_name" "$icon"
        echo Changed "$i_name"
    else
        echo Skipping "$i_name"
    fi
done