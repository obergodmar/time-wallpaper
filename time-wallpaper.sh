#!/bin/bash

DAWN="/home/obergodmar/Pictures/Wallpapers/MacOS/dawn.jpg";
MORNING="/home/obergodmar/Pictures/Wallpapers/MacOS/morning.jpg";
MIDDAY="/home/obergodmar/Pictures/Wallpapers/MacOS/midday.jpg";
AFTERNOON="/home/obergodmar/Pictures/Wallpapers/MacOS/afternoon.jpg";
DUSK="/home/obergodmar/Pictures/Wallpapers/MacOS/dusk.jpg";
EVENING="/home/obergodmar/Pictures/Wallpapers/MacOS/evening.jpg";
MIDNIGHT="/home/obergodmar/Pictures/Wallpapers/MacOS/midnight.jpg";
NIGHT="/home/obergodmar/Pictures/Wallpapers/MacOS/night.jpg";

QUIET="0"

printUsage() {
    echo -e "Usage: $0 [option]\nOptions:\n\t-h\t\toutput usage information\n\t-q\t\tquiet mode";
}

while [ -n "$1" ]
do
    case "$1" in
        -q) let "QUIET += 1";;
        -h) printUsage; exit 0;;
        *) printUsage; exit 1;;
    esac
    shift
done

changeWallpaper () {
    /usr/bin/dbus-send \
        --session \
        --dest=org.kde.plasmashell \
        --type=method_call /PlasmaShell org.kde.PlasmaShell.evaluateScript \
            "string:var Desktops = desktops();                                                                                                                       
            for (i=0;i<Desktops.length;i++) {
                    d = Desktops[i];
                    d.wallpaperPlugin = 'org.kde.image';
                    d.currentConfigGroup = Array('Wallpaper',
                                                'org.kde.image',
                                                'General');
                    d.writeConfig('Image', 'file://$1');
            }";
}

timeNow () {
    if [ "$QUIET" == "0" ]; then
        clear;
        echo "Press <CTRL+C> to exit.";
        echo -ne "Time: $(dateconv --zone "Europe/Moscow" now -f "%T") is $1";
    fi
}

if which datetest > /dev/null; then
    if [ "$QUIET" == "0" ]; then
        echo "dateutils is installed. Continue...";
    fi
else
    echo "dateutils is NOT installed. Aborted...";
    exit 1;
fi

if [ "$XDG_SESSION_DESKTOP" == "KDE" ]; then
    if [ "$QUIET" == "0" ]; then
        echo "KDE is your Desktop Environment. Continue...";
    fi
else
    echo "KDE is NOT your Desktop Environment. Aborted...";
    exit 1;
fi

sleep 1;

while :
do
    if datetest time --gt '03:00:00' && datetest time --lt '06:00:00'; then
        timeNow "dawn";
        changeWallpaper "$DAWN";
    elif datetest time --gt '06:00:00' && datetest time --lt '09:00:00'; then
        timeNow "morning";
        changeWallpaper "$MORNING";
    elif datetest time --gt '09:00:00' && datetest time --lt '12:00:00'; then
        timeNow "midday";
        changeWallpaper "$MIDDAY";
    elif datetest time --gt '12:00:00' && datetest time --lt '15:00:00'; then
        timeNow "afternoon";
        changeWallpaper "$AFTERNOON";
    elif datetest time --gt '15:00:00' && datetest time --lt '18:00:00'; then
        timeNow "dusk";
        changeWallpaper "$DUSK";
    elif datetest time --gt '18:00:00' && datetest time --lt '21:00:00'; then
        timeNow "evening";
        changeWallpaper "$EVENING";
    elif datetest time --gt '21:00:00' && datetest time --lt '00:00:00'; then
        timeNow "midnight";
        changeWallpaper "$MIDNIGHT";
    elif datetest time --gt '00:00:00' && datetest time --lt '03:00:00'; then
        timeNow "night";
        changeWallpaper "$NIGHT";
    fi
    sleep 1
done
