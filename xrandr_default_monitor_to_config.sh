#!/bin/bash

MONITOR=$(xrandr --listactivemonitors | awk 'NR==2{print $4}')
sed -i 's/exec_always xrandr/#exec_always xrandr/' $1
echo "exec_always xrandr --output ${MONITOR} --primary" >> $1
echo "Now edit i3wm config"
