#!/bin/bash
echo "=== Hyprland process ==="
ps aux | grep -i hyprland | grep -v grep

echo "=== exec_cmd test ==="
hyprctl eval 'hl.dsp.exec_cmd("touch /tmp/simple_test")'
sleep 2
ls -la /tmp/simple_test 2>&1

echo "=== process fork check ==="
(hyprctl eval 'hl.dsp.exec_cmd("touch /tmp/watch_test")' &
sleep 0.3
ps -ef | grep -i touch | grep -v grep)
sleep 2
ls -la /tmp/watch_test 2>&1
