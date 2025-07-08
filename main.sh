#!/bin/bash
# I really like this script. Give feedback at simon@simpansoftware.cc if you are reading this.

function menu() {
    echo "1. Make a new file"
    echo "2. Edit SRT"
    echo "3. View SRT"
    echo "4. Exit"
    echo
    read -p "Select option: " option

    if [ "$option" -eq 1 ]; then
        read -p "What do you want the file to be called? " file
        if [[ "$file" != *.srt ]]; then
            file="$file.srt"
        fi
        touch "$file"
    elif [ "$option" -eq 2 ]; then
        echo "SRT Editor"
        sleep 2
        srt_maker
    elif [ "$option" -eq 3 ]; then
        read -p "What file do you want to view? " file
        if [[ "$file" != *.srt ]]; then
            file="$file.srt"
        fi
        if [ ! -f "$file" ]; then
            echo "The file name you entered does not seem to exist. Exiting..."
        else
            clear
            cat "$file"
            exit 0
        fi
    elif [ "$option" -eq 4 ]; then
        exit 0    
    else
        echo "that isnt a option fool"
    fi

    clear
}

function srt_maker() {
    count=1
    read -p "What file do you want to edit? " filename
    if [[ "$filename" != *.srt ]]; then
        filename="$filename.srt"
    fi
    if [ ! -f "$filename" ]; then
        echo "The file name you entered does not seem to exist. Exiting..."
    else
        echo "Editing '$filename'. Enter empty subtitle text to quit."
        if [ -s "$filename" ]; then
            count=$(grep -E '^[0-9]+$' "$filename" | tail -n 1)
            count=$((count + 1))
            echo "Existing file found. Continuing on line $count."
        else
            count=1
        fi
        while true; do
            echo
            read -p "Enter start time. (HH:MM:SS,mmm): " start
            echo
            read -p "Enter end time. (HH:MM:SS,mmm): " end
            echo
            sleep 0.2
            read -p "Enter subtitle text: " text
            echo

            if [ -z "$text" ]; then
                echo "Exiting editor."
                break
            fi

            echo "$count" >> "$filename"
            echo "$start --> $end" >> "$filename"
            echo "$text" >> "$filename"
            echo "" >> "$filename"

            ((count++))
            echo "Moving on onto the next line."
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
