#!/bin/bash

MONITOR=$(xrandr --listactivemonitors | awk 'NR==2{print $4}')
mkdir -p ~/.screenlayout
echo "#!/bin/bash" > ~/.screenlayout/default_monitor.sh
echo "xrandr --output ${MONITOR} --primary" >> ~/.screenlayout/default_monitor.sh
