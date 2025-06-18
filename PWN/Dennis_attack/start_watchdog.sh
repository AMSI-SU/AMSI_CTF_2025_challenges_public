#!/bin/sh

# challengers can restart the challenge with connecting to the port 4005
pkill ncat
sleep 1
ncat -l 4005 -k -c "echo \"Restarting challenge instance... Wait for ~15 secondes.\" && ./start.sh 2>/dev/null 1>/dev/null && echo \"Challenge restarted !\""
# echo "Watchdog running."
