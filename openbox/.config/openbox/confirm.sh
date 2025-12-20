#!/bin/bash

## Confirmation Script by adi1090x
## Displays a Yes/No menu using Rofi

rofi_cmd="rofi -dmenu -i -no-fixed-num-lines -p 'Are you sure?'"
options="yes\nno"

echo -e "$options" | $rofi_cmd
