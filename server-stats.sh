#!/bin/bash

echo "========== Server Performance Stats =========="
echo ""

# OS Version
echo ">> OS Version:"
cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"'
echo ""

# Uptime
echo ">> Uptime:"
uptime -p
echo ""

# Load Average
echo ">> Load Average (1, 5, 15 min):"
uptime | awk -F'load average: ' '{ print $2 }'
echo ""

# Logged in users
echo ">> Logged in users:"
who | wc -l
echo ""

# CPU Usage
echo ">> Total CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print "Used: " 100 - $8 "% | Idle: " $8 "%"}'
echo ""

# Memory Usage
echo ">> Memory Usage:"
free -h | awk 'NR==2{printf "Used: %s / %s (%.2f%%)\n", $3, $2, $3*100/$2 }'
echo ""

# Disk Usage
echo ">> Disk Usage:"
df -h --total | grep 'total' | awk '{printf "Used: %s / %s (%s)\n", $3, $2, $5}'
echo ""

# Top 5 processes by CPU
echo ">> Top 5 Processes by CPU Usage:"
ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6
echo ""

# Top 5 processes by Memory
echo ">> Top 5 Processes by Memory Usage:"
ps -eo pid,ppid,cmd,%mem --sort=-%mem | head -n 6
echo ""

# (Optional) Failed login attempts
if command -v lastb &> /dev/null; then
    echo ">> Recent Failed Login Attempts:"
    lastb -n 5
    echo ""
else
    echo ">> Failed Login Stats:"
    echo "Command 'lastb' not found. Skipping failed login attempts section."
    echo ""
fi

echo "========== End of Report =========="

