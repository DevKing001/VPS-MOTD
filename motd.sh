#!/bin/bash
# ==========================================
# Custom MOTD Script (Ubuntu + HyperCloud Mix)
# ==========================================

# ===== Colors =====
GREEN="\e[38;5;82m"
CYAN="\e[38;5;51m"
BLUE="\e[38;5;39m"
MAGENTA="\e[38;5;213m"
YELLOW="\e[38;5;220m"
GRAY="\e[38;5;245m"
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
echo -e "${BLUE}██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗  ██████╗██╗      ██████╗ ██╗   ██╗██████╗ "
echo -e "██║  ██║╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗██╔════╝██║     ██╔═══██╗██║   ██║██╔══██╗"
echo -e "███████║ ╚████╔╝ ██████╔╝█████╗  ██████╔╝██║     ██║     ██║   ██║██║   ██║██║  ██║"
echo -e "██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══╝  ██╔══██╗██║     ██║     ██║   ██║██║   ██║██║  ██║"
echo -e "██║  ██║   ██║   ██║     ███████╗██║  ██║╚██████╗███████╗╚██████╔╝╚██████╔╝██████╔╝"
echo -e "╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚══════╝╚═╝  ╚═╝ ╚═════╝╚══════╝ ╚═════╝  ╚═════╝ ╚═════╝ ${RESET}"
echo ""

echo -e "${GREEN}🚀 Welcome to $HOSTNAME${RESET}"
echo -e "${CYAN}System: $OS | Kernel: $KERNEL | Uptime: $UPTIME${RESET}"
echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"

printf "${CYAN}%-18s${RESET} %s\n" "Load:" "$LOAD"
printf "${CYAN}%-18s${RESET} %sMB / %sMB (${YELLOW}%s%%${RESET})\n" "Memory:" "$MEM_USED" "$MEM_TOTAL" "$MEM_PERC"
printf "${CYAN}%-18s${RESET} %s\n" "Disk Usage:" "$DISK"
printf "${CYAN}%-18s${RESET} %s\n" "Processes:" "$PROCS"
printf "${CYAN}%-18s${RESET} %s\n" "Users Online:" "$USERS"
printf "${CYAN}%-18s${RESET} %s\n" "IP Address:" "$IP"

echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${GREEN}Documentation:${RESET} https://help.ubuntu.com"
echo -e "${GREEN}Support:${RESET}       https://ubuntu.com/pro"
echo -e "${MAGENTA}Tip: Secure Kubernetes at the edge!${RESET}"
echo -e "      Learn more: https://ubuntu.com/engage/secure-kubernetes-at-the-edge"
echo ""

# Optional upgrade info (requires apt-update run recently)
if command -v apt >/dev/null 2>&1; then
    UPDATES=$(apt list --upgradable 2>/dev/null | grep -v Listing | wc -l)
    if [ "$UPDATES" -gt 0 ]; then
        echo -e "${YELLOW}⚠ $UPDATES packages can be updated. Run 'apt list --upgradable'.${RESET}"
    fi
fi

echo -e "${MAGENTA}*** System restart may be required ***${RESET}"
echo "Steps to Install: "
echo "- sudo chmod -x /etc/update-motd.d/*"
echo "- sudo nano /etc/update-motd.d/00-custom-motd  # Paste the script"
echo "- sudo chmod +x /etc/update-motd.d/00-custom-motd"
echo "Then Logout and Login to see the changes!"
