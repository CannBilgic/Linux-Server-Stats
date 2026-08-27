#!/bin/bash

# ==============================
# Colors
# ==============================
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
CYAN="\033[36m"
BOLD="\033[1m"
RESET="\033[0m"

clear

# ==============================
# Header
# ==============================
printf "${CYAN}${BOLD}"
printf "╔══════════════════════════════════════════════════════╗\n"
printf "║              LINUX SYSTEM HEALTH CHECK               ║\n"
printf "╚══════════════════════════════════════════════════════╝\n"
printf "${RESET}"

printf "\n%-20s : %s\n" "Hostname" "$(hostname)"
printf "%-20s : %s\n" "Date" "$(date '+%Y-%m-%d %H:%M:%S')"

# ==============================
# System
# ==============================
printf "\n${CYAN}${BOLD}[ SYSTEM INFORMATION ]${RESET}\n"
printf '%s\n' '------------------------------------------------------'

OS=$(cat /etc/rocky-release)
UPTIME=$(uptime -p)

printf "%-20s : %s\n" "Operating System" "$OS"
printf "%-20s : %s\n" "Uptime" "$UPTIME"

# ==============================
# CPU
# ==============================
printf "\n${CYAN}${BOLD}[ CPU ]${RESET}\n"
printf '%s\n' '------------------------------------------------------'

CPU=$(top -bn1 | awk '/Cpu\(s\)/ {print 100-$8}')

printf "%-20s : ${GREEN}%s%%${RESET}\n" "Total CPU Usage" "$CPU"

# ==============================
# Memory
# ==============================
printf "\n${CYAN}${BOLD}[ MEMORY ]${RESET}\n"
printf '%s\n' '------------------------------------------------------'

free -m | awk '/Mem:/ {
    printf "%-20s : %s MB\n", "Used Memory", $3
    printf "%-20s : %s MB\n", "Free Memory", $4
    printf "%-20s : %s MB\n", "Available Memory", $7
}'

# ==============================
# Disk
# ==============================
printf "\n${CYAN}${BOLD}[ DISK ]${RESET}\n"
printf '%s\n' '------------------------------------------------------'

df -h --total | awk '/total/ {
    printf "%-20s : %s\n", "Total Disk Size", $2
    printf "%-20s : %s\n", "Used Disk", $3
    printf "%-20s : %s\n", "Available Disk", $4
    printf "%-20s : %s\n", "Disk Usage", $5
}'

# ==============================
# Top CPU Processes
# ==============================
printf "\n${CYAN}${BOLD}[ TOP 5 CPU PROCESSES ]${RESET}\n"
printf '%s\n' '------------------------------------------------------'

ps -eo pid,user,comm,%cpu,%mem --sort=-%cpu | head -n 6

# ==============================
# Top Memory Processes
# ==============================
printf "\n${CYAN}${BOLD}[ TOP 5 MEMORY PROCESSES ]${RESET}\n"
printf '%s\n' '------------------------------------------------------'

ps -eo pid,user,comm,%cpu,%mem --sort=-%mem | head -n 6

# ==============================
# Footer
# ==============================
printf "\n${GREEN}${BOLD}"
printf "✔ Health check completed successfully.\n"
printf "${RESET}\n"
