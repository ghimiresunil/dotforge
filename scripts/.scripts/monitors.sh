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

all_options() {
    OPTIONS=""
    OPTIONS="${OPTIONS}1. Dual (Laptop + DP-2)\n"
    OPTIONS="${OPTIONS}2. Laptop Only\n"
    OPTIONS="${OPTIONS}3. External Only (DP-2)\n"
    OPTIONS="${OPTIONS}4. Quit\n"
}

options_menu() {
    unset OPTIONS
    all_options

    case "$(printf "$OPTIONS" | rofi -dmenu -i -p 'Display Setup:')" in
        '1. Dual (Laptop + DP-2)') dual_setup ;;
        '2. Laptop Only') laptop_setup ;;
        '3. External Only (DP-2)') main_setup ;;
        '4. Quit') exit 0 ;;
        *) exit 0 ;;
    esac
}

options_menu

# Relaunch polybar after changing monitors
bash ~/.config/polybar/launch.sh > /dev/null 2>&1
feh --bg-scale ~/.config/backgrounds/pacman.png
