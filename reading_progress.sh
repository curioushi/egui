#!/bin/bash
if [[ -e "reading_list.md" ]]; then
    total=$(cat reading_list.md | grep '^- \['    | cut -d ']' -f 2 | xargs cloc | grep '^[A-Za-z: ]\+[0-9]\+\ \+[0-9]\+\ \+[0-9]\+\ \+[0-9]\+' | tail -n 1 | awk '{print $5}')

    read=$( cat reading_list.md | grep '^- \[x\]' | cut -d ']' -f 2)
    if [[ -z "$read" ]]; then
        read=0
    else
        read=$( cat reading_list.md | grep '^- \[x\]' | cut -d ']' -f 2 | xargs cloc | grep '^[A-Za-z: ]\+[0-9]\+\ \+[0-9]\+\ \+[0-9]\+\ \+[0-9]\+' | tail -n 1 | awk '{print $5}')
    fi

    ratio=$(echo "scale=2; 100 * $read / $total" | bc)
    echo $read / $total \( $ratio% \)
else
    echo "reading_list.md" not found
fi

