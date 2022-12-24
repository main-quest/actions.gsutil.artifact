#!/bin/bash

set -e

d="$1"

# Check for asterisks in path, as per https://stackoverflow.com/a/1193682
echo "Making sure the destination dirs exist"
if echo x"$d" | grep '*' > /dev/null; then
    echo "Destination contains asterisks. Not proceeding with folder auto-creation, just to be safe. If the folder doesn't exist, make sure you create it beforehand"
else
    # Double brackets to allow * as regex
    if [[ $d == */ ]]; then
        echo "Destination ends with '/' - creating folder if doesn't exist"
        mkdir -p "$d"
    else
        if [[ $d == *. ]]; then
            echo "Destination ends with dots. Not proceeding with folder auto-creation, just to be safe. If the folder doesn't exist, make sure you create it beforehand"
        else
            pd=$(dirname "$d")
            if [[ $pd == *. ]]; then
                echo "Destination parent dir ends with dots. Not proceeding with folder auto-creation, just to be safe. If the folder doesn't exist, make sure you create it beforehand"
            else
                echo "Creating parent folder of destination if doesn't exist"
                mkdir -p "$pd"
            fi
        fi
    fi
fi
