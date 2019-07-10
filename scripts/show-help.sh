#!/bin/bash

# Variables
BOLD=$(tput bold)
REG=$(tput sgr0)
CYAN=$(tput setaf 6)

# Print a horizontal rule
rule () {
    printf -v _hr "%*s" $(tput cols) && echo ${_hr// /${1--}}
}

# Print horizontal ruler with message
rulem ()  {
    # Fill line with ruler character ($2, default "-"), reset cursor, move 2 cols right, print message
    printf -v _hr "%*s" $(tput cols) && echo -en ${_hr// /${2--}} && echo -e "\r\033[2C$1"
}

# Useful Commands
rulem "[ ${CYAN}Command List${REG} ]"
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
printf '\n%23s : %s' "${BOLD}cloud-login" "${REG}Logs into the Cloud CLI in the VM.  May need to do this twice."
printf '\n%23s : %s' "${BOLD}add-key" "${REG}Adds SSH keys to the SSH agent."
printf '\n%23s : %s' "${BOLD}configure-proxy" "${REG}Configures a proxy connection to download module updates."
printf '\n%23s : %s' "${BOLD}add-modules" "${REG}Triggers module updates which have been added to the composer.json file."
printf '\n%23s : %s' "${BOLD}upgrade" "${REG}Upgrade the codebase after adding a new module to your composer.json file."
printf '\n%23s : %s' "${BOLD}start-web" "${REG}Starts/Re-starts the web server."
printf "\n\n