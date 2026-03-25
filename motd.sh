#!/bin/bash
# ==========================================
# HyperCloud Classic MOTD (Blue/White/Black)
# ==========================================

# ===== Colors =====
BLUE="\e[38;5;39m"
WHITE="\e[38;5;15m"
BLACK="\e[48;5;0m"
RESET="\e[0m"

# ===== System Info =====
HOSTNAME=$(hostname)
OS=$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')
KERNEL=$(uname -r)
UPTIME=$(uptime -p | sed 's/up //')
LOAD=$(awk '{print $1}' /proc/loadavg)

MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_PERC=$((MEM_USED * 100 / MEM_TOTAL))

DISK=$(df -h / | awk 'NR==2 {print $3 " / " $2 " (" $5 ")"}')
IP=$(hostname -I | awk '{print $1}')
USERS=$(who | wc -l)
PROCS=$(ps -e --no-headers | wc -l)

# ===== MOTD Display =====
echo ""
# --- HyperCloud ASCII Banner ---
echo -e "${BLUE}"
cat << "BANNER"
██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗  ██████╗██╗      ██████╗ ██╗   ██╗██████╗ 
██║  ██║╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗██╔════╝██║     ██╔═══██╗██║   ██║██╔══██╗
███████║ ╚████╔╝ ██████╔╝█████╗  ██████╔╝██║     ██║     ██║   ██║██║   ██║██║  ██║
██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══╝  ██╔══██╗██║     ██║     ██║   ██║██║   ██║██║  ██║
██║  ██║   ██║   ██║     ███████╗██║  ██║╚██████╗███████╗╚██████╔╝╚██████╔╝██████╔╝
╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚══════╝╚═╝  ╚═╝ ╚═════╝╚══════╝ ╚═════╝  ╚═════╝ ╚═════╝
BANNER
echo -e "${RESET}"
echo ""

echo -e "${BLUE}🚀 Welcome to HyperCloud${RESET}"
echo -e "${WHITE}System: $OS | Kernel: $KERNEL | Uptime: $UPTIME${RESET}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"

# --- System Stats ---
printf "${WHITE}%-20s %s\n${RESET}" "Load:" "$LOAD"
printf "${WHITE}%-20s %sMB / %sMB (%s%%)\n${RESET}" "Memory usage:" "$MEM_USED" "$MEM_TOTAL" "$MEM_PERC"
printf "${WHITE}%-20s %s\n${RESET}" "Disk Usage:" "$DISK"
printf "${WHITE}%-20s %s\n${RESET}" "Processes:" "$PROCS"
printf "${WHITE}%-20s %s\n${RESET}" "Users logged in:" "$USERS"
printf "${WHITE}%-20s %s\n${RESET}" "IPv4 Address:" "$IP"

echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"

# --- Links & Tips ---
echo -e "${BLUE}  * Documentation:  https://help.ubuntu.com${RESET}"
echo -e "${BLUE}  * Support:        https://ubuntu.com/pro${RESET}"
echo -e "${BLUE}  * Tip: Secure Kubernetes at the edge!${RESET}"
echo -e "${WHITE}Learn more: https://ubuntu.com/engage/secure-kubernetes-at-the-edge${RESET}"
echo ""

# --- Optional upgrade info ---
if command -v apt >/dev/null 2>&1; then
    UPDATES=$(apt list --upgradable 2>/dev/null | grep -v Listing | wc -l)
    if [ "$UPDATES" -gt 0 ]; then
        echo -e "${WHITE}⚠  $UPDATES packages can be updated. Run 'apt list --upgradable'.${RESET}"
    fi
fi

# --- Optional restart notice ---
if [ -f /var/run/reboot-required ]; then
    echo -e "${WHITE}*** System restart may be required ***${RESET}"
fi

echo -e "${MAGENTA}*** System restart may be required ***${RESET}"
echo "Steps to Install: "
echo "- sudo chmod -x /etc/update-motd.d/*"
echo "- sudo nano /etc/update-motd.d/00-custom-motd  # Paste the script"
echo "- sudo chmod +x /etc/update-motd.d/00-custom-motd"
echo "Then Logout and Login to see the changes!"
