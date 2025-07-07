#!/bin/bash

function menu() {
    echo "1. Make a new file"
    echo "2. Edit SRT"
    echo "3. Exit"
    echo
    echo "Select option:"
    read option

    if [ "$option" -eq 1 ]; then
        echo "What do you want the file to be called?"
        read file
        if [[ "$file" != *.srt ]]; then
            file="$file.srt"
        fi
        touch "$file"
    elif [ "$option" -eq 2 ]; then
        echo "SRT Editor"
        sleep 2
        srt_maker
    elif [ "$option" -eq 3 ]; then
        exit 0    
    
    else
        echo "that isnt a option fool"
    fi

    clear
}

function srt_maker() {
    count=1
    echo "What file do you want to edit?"
    read filename
    if [ ! -f "$filename" ]; then
        echo "The file name you entered does not seem to exist. Exiting..."
    else
        echo "Editing '$filename'. Enter empty subtitle text to quit."
        if [ -s "$filename" ]; then
            count=$(grep -E '^[0-9]+$' "$filename" | tail -n 1)
            count=$((count + 1))
            echo "Existing file found. Continuing on line $count."
            echo "" >> "$filename"
        else
            count=1
        fi
        while true; do
            echo "Enter start time. (HH:MM:SS,mmm)"
            read start

            echo "Enter end time. (HH:MM:SS,mmm)"
            read end
            
            sleep 0.2

            echo "Enter subtitle text:"
            read text

            if [ -z "$text" ]; then
                echo "Exiting editor."
                break
            fi

            echo "$count" >> "$filename"
            echo "$start --> $end" >> "$filename"
            echo "$text" >> "$filename"
            echo "" >> "$filename"

            ((count++))
        done
    fi
}

clear
echo "SRT Maker"
sleep 2
clear
while true; do
    menu
done
