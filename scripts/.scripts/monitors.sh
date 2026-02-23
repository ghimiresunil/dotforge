#!/bin/sh
# monitor setups
LAPTOP_DISPLAY="eDP-1"
MAIN_DISPLAY="DP-2"

# dual setup: laptop on left, external on right
dual_setup() {
    xrandr --output $LAPTOP_DISPLAY --mode 2048x1152 --rate 60 --pos 0x0 --rotate normal --primary \
           --output $MAIN_DISPLAY --mode 1920x1080 --rate 100 --right-of $LAPTOP_DISPLAY
}

# laptop only
laptop_setup() {
    xrandr --output $LAPTOP_DISPLAY --mode 2048x1152 --rate 60 --pos 0x0 --rotate normal --primary \
           --output $MAIN_DISPLAY --off
}

# external only
main_setup() {
    xrandr --output $MAIN_DISPLAY --mode 1920x1080 --rate 100 --pos 0x0 --rotate normal --primary \
           --output $LAPTOP_DISPLAY --off
}

extend_displays() {
    # Detect connected external monitor (not the laptop display)
    EXTERNAL_DISPLAY=$(xrandr --query | grep " connected" | grep -v "^$LAPTOP_DISPLAY" | awk '{print $1}' | head -n1)

    if [ -z "$EXTERNAL_DISPLAY" ]; then
        notify-send "Monitor Setup" "No external monitor detected."
        return
    fi

    # Get preferred resolution of external monitor
    PREFERRED_MODE=$(xrandr | awk -v monitor="$EXTERNAL_DISPLAY" '
        $0 ~ monitor {found=1}
        found && /\*/ {print $1; exit}
    ')

    xrandr --output "$LAPTOP_DISPLAY" --auto --primary --pos 0x0 \
           --output "$EXTERNAL_DISPLAY" --mode "$PREFERRED_MODE" --right-of "$LAPTOP_DISPLAY"

    notify-send "Monitor Setup" "Dual setup enabled: $EXTERNAL_DISPLAY"
}

all_options() {
    OPTIONS=""
    OPTIONS="${OPTIONS}1. Extend (Auto Detect External)\n"
    OPTIONS="${OPTIONS}2. Dual (Laptop + DP-2)\n"
    OPTIONS="${OPTIONS}3. Laptop Only\n"
    OPTIONS="${OPTIONS}4. External Only (DP-2)\n"
    OPTIONS="${OPTIONS}5. Quit\n"
}

options_menu() {
    unset OPTIONS
    all_options

    case "$(printf "$OPTIONS" | rofi -dmenu -i -p 'Display Setup:')" in
        '1. Extend (Auto Detect External)') extend_displays ;;
        '2. Dual (Laptop + DP-2)') dual_setup ;;
        '3. Laptop Only') laptop_setup ;;
        '4. External Only (DP-2)') main_setup ;;
        '5. Quit') exit 0 ;;
        *) exit 0 ;;
    esac
}


options_menu

# Relaunch polybar after changing monitors
bash ~/.config/polybar/launch.sh > /dev/null 2>&1
feh --bg-scale ~/.config/backgrounds/pacman.png
