#!/usr/bin/env bash

cava -p ~/.config/cava/config_waybar | sed -u \
    -e 's/;//g' \
    -e 's/0/ /g' \
    -e 's/1/▂/g' \
    -e 's/2/▃/g' \
    -e 's/3/▄/g' \
    -e 's/4/▅/g' \
    -e 's/5/▆/g' \
    -e 's/6/▇/g' \
    -e 's/7/█/g'
