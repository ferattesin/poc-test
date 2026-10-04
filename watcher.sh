#!/bin/bash
set -e
B_UID=1000
B_SIG="efb50993780079460b0cbed1363e2166a2de1d9f_1791076247_1592613498"
FAKE=/run/user/1002/hypr/fake_0
STATE=/run/omarchy/hyprland-reload-guard/fake_0

echo "waiting for $STATE ..."
while [ ! -e "$STATE" ]; do sleep 0.02; done

rm -f "$FAKE/.socket.sock"
ln -s "/run/user/$B_UID/hypr/$B_SIG/.socket.sock" "$FAKE/.socket.sock"
echo "swapped $FAKE/.socket.sock -> /run/user/$B_UID/hypr/$B_SIG/.socket.sock"
