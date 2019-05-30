#!/bin/bash

# Variables
export TERM=xterm-256color
IP=$(hostname -I)
HOSTNAME=$(hostname)
BOLD=$(tput bold)
REG=$(tput sgr0)
CYAN=$(tput setaf 6)
WEBMIN_USER=magento
WEBMIN_PASS=magento
WEBMIN_PORT=$(netstat -tulpn | grep "LISTEN" | grep "perl" | awk '{print $4}' | sed -e 's/.*://')
MAILHOG_PORT=$(netstat -tulpn | grep "LISTEN" | grep "mailhog" | awk '{print $4;exit;}' | sed -e 's/.*://')

# Print a horizontal rule
rule () {
    printf -v _hr "%*s" $(tput cols) && echo ${_hr// /${1--}}
}

# Print horizontal ruler with message
rulem ()  {
    # Fill line with ruler character ($2, default "-"), reset cursor, move 2 cols right, print message
    printf -v _hr "%*s" $(tput cols) && echo -en ${_hr// /${2--}} && echo -e "\r\033[2C$1"
}

# Intro
figlet BOOM.
printf "\n${BOLD}Welcome to the Kukla VM!${REG}\n\n"

# Hosts Entry, Mailhog, and Webmin
rulem "[ ${CYAN}Hosts Entry and Webmin${REG} ]"
printf '\n%23s : %s %s\t%s\n' "${BOLD}Host Entry" "${REG}${IP}" "${HOSTNAME}" "b2b.${HOSTNAME}"
printf '%23s : %s  \n' "${BOLD}Mailhog Inbox" "${REG}http://${HOSTNAME}:${MAILHOG_PORT}"
printf '%23s : %s  \n\t\t %7s : %s\n\t %15s : %s\n' "${BOLD}Webmin Console" "${REG}http://${HOSTNAME}:${WEBMIN_PORT}" "User" "${WEBMIN_USER}" "Password" "${WEBMIN_PASS}"
printf "\n"

# Useful Commands
rulem "[ ${CYAN}Useful Commands${REG} ]"
printf '\n%23s : %s' "${BOLD}set-url" "${REG}Set a new base url and hostname."
printf '\n%23s : %s' "${BOLD}clean" "${REG}Re-indexes and clears cache."
printf '\n%23s : %s' "${BOLD}cache" "${REG}Clears cache."
printf '\n%23s : %s' "${BOLD}reindex" "${REG}Reindexes all indexes."
printf '\n%23s : %s' "${BOLD}warm-cache" "${REG}Warms the Luma, Venia, and Custom store view caches."
printf '\n%23s : %s' "${BOLD}dev-mode" "${REG}Puts application into developer mode."
printf '\n%23s : %s' "${BOLD}prod-mode" "${REG}Puts application into production mode."
printf '\n%23s : %s' "${BOLD}process-catalogs" "${REG}Processes B2B Shared Catalogs (Runs \"clean\" and a single cron trigger)."
printf '\n%23s : %s' "${BOLD}staging" "${REG}Refreshes the Staging Dashboard (Runs \"clean\" and two cron triggers)."
printf '\n%23s : %s' "${BOLD}disable-cms-cache" "${REG}Disables the block_html, layout, and full_page caches."
printf '\n%23s : %s' "${BOLD}enable-cache" "${REG}Enables all caches."
printf '\n%23s : %s' "${BOLD}cron" "${REG}Runs a single cron trigger."
printf '\n%23s : %s' "${BOLD}upgrade" "${REG}Upgrade the codebase after adding a new module to your composer.json file."
printf "\n\n"

rule
