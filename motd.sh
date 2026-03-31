#!/bin/bash
# ==========================================
# Atyro Cloud Premium MOTD Installer (v2 Ultra)
# ==========================================

set -e

echo "🔧 Installing Atyro Cloud Premium MOTD..."

# ================================
# Disable ALL default MOTD scripts
# ================================
echo "⚙ Disabling old MOTD scripts..."
sudo chmod -x /etc/update-motd.d/* 2>/dev/null || true

# ==========================================
# Create Premium MOTD Script
# ==========================================
cat << 'EOF' > /etc/update-motd.d/00-atyrocloud
#!/bin/bash

# ===== Colors =====
GREEN="\e[38;5;82m"
CYAN="\e[38;5;51m"
BLUE="\e[38;5;39m"
MAGENTA="\e[38;5;213m"
YELLOW="\e[38;5;220m"
GRAY="\e[38;5;245m"
RESET="\e[0m"

# ===== Fast System Info =====
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

echo ""

# ===== Atyro Cloud Logo =====
echo -e "${MAGENTA}"
cat << "LOGO"
 █████╗ ████████╗██╗   ██╗██████╗  ██████╗      ██████╗██╗      ██████╗ ██╗   ██╗██████╗ 
██╔══██╗╚══██╔══╝╚██╗ ██╔╝██╔══██╗██╔═══██╗    ██╔════╝██║     ██╔═══██╗██║   ██║██╔══██╗
███████║   ██║    ╚████╔╝ ██████╔╝██║   ██║    ██║     ██║     ██║   ██║██║   ██║██║  ██║
██╔══██║   ██║     ╚██╔╝  ██╔══██╗██║   ██║    ██║     ██║     ██║   ██║██║   ██║██║  ██║
██║  ██║   ██║      ██║   ██║  ██║╚██████╔╝    ╚██████╗███████╗╚██████╔╝╚██████╔╝██████╔╝
╚═╝  ╚═╝   ╚═╝      ╚═╝   ╚═╝  ╚═╝ ╚═════╝      ╚═════╝╚══════╝ ╚═════╝  ╚═════╝ ╚═════╝
LOGO
echo -e "${RESET}"

# ===== Header =====
echo -e "${GREEN}🚀 Welcome to Atyro Cloud Datacenter${RESET}"
echo -e "${BLUE}High Performance • Secure • Reliable Infrastructure${RESET}"
echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"

# ===== System Stats =====
printf "${CYAN}%-18s${RESET} %s\n" "Hostname:" "$HOSTNAME"
printf "${CYAN}%-18s${RESET} %s\n" "Operating System:" "$OS"
printf "${CYAN}%-18s${RESET} %s\n" "Kernel:" "$KERNEL"
printf "${CYAN}%-18s${RESET} %s\n" "Uptime:" "$UPTIME"
printf "${CYAN}%-18s${RESET} %s\n" "CPU Load:" "$LOAD"
printf "${CYAN}%-18s${RESET} %sMB / %sMB (${YELLOW}%s%%${RESET})\n" \
"Memory:" "$MEM_USED" "$MEM_TOTAL" "$MEM_PERC"
printf "${CYAN}%-18s${RESET} %s\n" "Disk Usage:" "$DISK"
printf "${CYAN}%-18s${RESET} %s\n" "Processes:" "$PROCS"
printf "${CYAN}%-18s${RESET} %s\n" "Users Online:" "$USERS"
printf "${CYAN}%-18s${RESET} %s\n" "IP Address:" "$IP"

echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"

# ===== Footer =====
echo -e "${GREEN}Support:${RESET}  support@atyrocloud.com"
echo -e "${GREEN}Discord:${RESET}  https://discord.gg/G3rFVwtw35"
echo -e "${GREEN}Website:${RESET}  https://atyro.cloud"
echo -e "${MAGENTA}Quality Wise — No Compromise 💎${RESET}"
echo ""
EOF

chmod +x /etc/update-motd.d/00-atyrocloud

echo "✅ Atyro Cloud Premium MOTD Installed Successfully!"
echo "➡ Logout or reconnect SSH to see the new MOTD."
