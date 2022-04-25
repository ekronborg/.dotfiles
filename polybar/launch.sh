#!/bin/bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

# Launch Polybar and write to log files
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar primary 2>&1 | tee -a /tmp/polybar1.log & disown
polybar secondary 2>&1 | tee -a /tmp/polybar2.log & disown

echo "Polybar launched..."
