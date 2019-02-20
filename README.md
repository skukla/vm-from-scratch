# Magento Demo VM From Scratch
The following guide covers how to set up a virtual machine running Ubuntu 18.04 via VMWare Fusion.

<!-- MarkdownTOC autolink="true" autoanchor="true" markdown_preview="github" -->

- [What We'll Need](#what-well-need)
	- [Software](#software)
	- [VM Set Up](#vm-set-up)
	- [Solution Components](#solution-components)
	- [Helpful Additions](#helpful-additions)
- [Installing VMWare Fusion](#installing-vmware-fusion)
- [Creating the VM](#creating-the-vm)
	- [Initial Setup](#initial-setup)
	- [Installing Ubuntu](#installing-ubuntu)
	- [Accessing via SSH](#accessing-via-ssh)
	- [Setting the Hostname](#setting-the-hostname)
		- [Adding the Magento QA Server to the Hosts File](#adding-the-magento-qa-server-to-the-hosts-file)
	- [Uninstalling Cloud-Init](#uninstalling-cloud-init)
	- [Applying Package Updates](#applying-package-updates)
	- [Adding the SSH Key](#adding-the-ssh-key)
	- [Installing Helpful Additional Programs](#installing-helpful-additional-programs)
	- [Setting the MoTD](#setting-the-motd)
- [Solution Components Installation](#solution-components-installation)
	- [PHP](#php)
		- [Installing PHP with the `ondrej/php` Repository](#installing-php-with-the-ondrejphp-repository)
		- [Uninstalling the Apache Web Server](#uninstalling-the-apache-web-server)
		- [Configuring PHP CLI and PHP-FPM](#configuring-php-cli-and-php-fpm)
	- [Nginx](#nginx)
		- [Installing Nginx](#installing-nginx)
		- [Configuring the Web Server User](#configuring-the-web-server-user)
		- [Configuring Nginx with PHP-FPM](#configuring-nginx-with-php-fpm)
		- [Create The Web Root](#create-the-web-root)
		- [Configure Magento Virtual Host](#configure-magento-virtual-host)
	- [Composer](#composer)
	- [VM CLI](#vm-cli)
	- [MariaDB](#mariadb)
		- [Adding A Database and A Database User](#adding-a-database-and-a-database-user)
		- [Database Tuning](#database-tuning)
	- [Varnish](#varnish)
	- [Redis](#redis)
	- [Elasticsearch](#elasticsearch)
		- [Install Java With The JDK](#install-java-with-the-jdk)
		- [Installing Elasticsearch 5.6.x](#installing-elasticsearch-56x)
		- [Configuring Elasticsearch](#configuring-elasticsearch)
		- [Elasticsearch Plugins](#elasticsearch-plugins)
	- [RabbitMQ](#rabbitmq)
		- [Install Erlang/OTP](#install-erlangotp)
		- [Install RabbitMQ](#install-rabbitmq)
		- [Configuring RabbitMQ To Respect Hostname Change](#configuring-rabbitmq-to-respect-hostname-change)
		- [Install RabbitMQ Management Dashboard](#install-rabbitmq-management-dashboard)
	- [Managing the VM with Webmin](#managing-the-vm-with-webmin)
		- [Installing and Configuring Webmin](#installing-and-configuring-webmin)
			- [Configuring the Webmin Port](#configuring-the-webmin-port)
			- [Remove SSL Mode](#remove-ssl-mode)
	- [Handling Email with Mailhog](#handling-email-with-mailhog)
		- [Installing the Go Programming Language](#installing-the-go-programming-language)
		- [Downloading and Configuring Mailhog](#downloading-and-configuring-mailhog)
		- [Creating the Mailhog Service](#creating-the-mailhog-service)
- [Magento](#magento)
	- [Downloading The Codebase With Git and Composer](#downloading-the-codebase-with-git-and-composer)
	- [Installing The Magento Application](#installing-the-magento-application)
	- [Installing Cron Tasks](#installing-cron-tasks)
	- [Configuring Magento and Varnish](#configuring-magento-and-varnish)
	- [Configuring Magento For Multisite Operation](#configuring-magento-for-multisite-operation)
	- [How Magento Multisite Operation Works](#how-magento-multisite-operation-works)
- [Using the VM](#using-the-vm)
- [Demo Environments](#demo-environments)
- [The Hybrid VM](#the-hybrid-vm)
	- [Preparation](#preparation)
	- [Downloading the Code](#downloading-the-code)
	- [Customizing the Codebase](#customizing-the-codebase)
	- [Downloading and Applying Patches](#downloading-and-applying-patches)
	- [Installing the Codebase](#installing-the-codebase)
- [Demo Case Setup](#demo-case-setup)
	- [Autofill Setup](#autofill-setup)
	- [Business Operations Setup](#business-operations-setup)
		- [Update the Root Category, Website, and Store Names](#update-the-root-category-website-and-store-names)
		- [Set the Store Information and Shipping Origin](#set-the-store-information-and-shipping-origin)
		- [Set UPS as the Shipping Method](#set-ups-as-the-shipping-method)
		- [Configure Braintree as Authorize Only](#configure-braintree-as-authorize-only)
		- [YouTube API Key](#youtube-api-key)
		- [Enable RMA](#enable-rma)
		- [Password Policy](#password-policy)
		- [Enable Instant Purchase](#enable-instant-purchase)
		- [Remove Welcome Message](#remove-welcome-message)
		- [Update Site Meta Info](#update-site-meta-info)
		- [Configure Reward Points](#configure-reward-points)
		- [Configure Related Products Display](#configure-related-products-display)
	- [General Content Updates](#general-content-updates)
		- [Luma Home Page \(US\)](#luma-home-page-us)
			- [Page Setup](#page-setup)
			- [Page Builder Content](#page-builder-content)
		- [Luma Home Page \(DE\)](#luma-home-page-de)
			- [Page Setup](#page-setup-1)
			- [Page Builder Content](#page-builder-content-1)
		- [Venia Home Page](#venia-home-page)
			- [Page Setup](#page-setup-2)
	- [Attribute Set Updates](#attribute-set-updates)
		- [Short Description and Description Arrangement](#short-description-and-description-arrangement)
		- [Sale and New Attributes](#sale-and-new-attributes)
	- [Customer Configuration](#customer-configuration)
		- [Redirect to My Account](#redirect-to-my-account)
		- [Set Up Saved Cards](#set-up-saved-cards)
	- [Set Up A Custom Brand](#set-up-a-custom-brand)
		- [Custom Catalog, Store, and Store View](#custom-catalog-store-and-store-view)
		- [Custom Attribute Set](#custom-attribute-set)
		- [Custom Home Page](#custom-home-page)
		- [Custom Site Map](#custom-site-map)
		- [Custom Theme Skin via SC Theme Customizer](#custom-theme-skin-via-sc-theme-customizer)
	- [Products](#products)
		- [Re-arrange Gear > Bags Category](#re-arrange-gear--bags-category)
		- [Re-arrange the Womens > Hoodies and Sweatshirts Category](#re-arrange-the-womens--hoodies-and-sweatshirts-category)
		- [Add Running As An Attribute to Select Products](#add-running-as-an-attribute-to-select-products)
		- [Add Stock for Mailed Gift Card](#add-stock-for-mailed-gift-card)
		- [Remove Manual Up-sells from Cronus Yoga Pant](#remove-manual-up-sells-from-cronus-yoga-pant)
	- [Marketing](#marketing)
		- [Featured Products on Home Page](#featured-products-on-home-page)
		- [Sale Category](#sale-category)
		- [Customer Segments](#customer-segments)
			- [Luma Guest Customers](#luma-guest-customers)
			- [Luma Registered Customers](#luma-registered-customers)
			- [LUMA Rewards](#luma-rewards)
				- [Bronze Tier](#bronze-tier)
				- [Silver Tier](#silver-tier)
				- [Gold Tier](#gold-tier)
				- [Platinum Tier](#platinum-tier)
			- [Purchase History](#purchase-history)
				- [Apparel Purchased in the Last Week](#apparel-purchased-in-the-last-week)
				- [Men Who Have Viewed Pants](#men-who-have-viewed-pants)
				- [VIP Customers](#vip-customers)
				- [Female Repeat Customers \(Neve Studio Dance Jacket\)](#female-repeat-customers-neve-studio-dance-jacket)
			- [Customer Preference](#customer-preference)
				- [Runners](#runners)
			- [Shopping Cart](#shopping-cart)
				- [Free Shipping Threshold \($75 - $99\)](#free-shipping-threshold-75---99)
		- [Related Products Rules](#related-products-rules)
			- [Remove Unwanted Rules and Configure Global Result Numbers](#remove-unwanted-rules-and-configure-global-result-numbers)
			- [Women’s Hoodies to Women's Pants \(Related Products\)](#womens-hoodies-to-womens-pants-related-products)
			- [Men's Pants to Men's Hoodies \(Segmented\) \(Related Products\)](#mens-pants-to-mens-hoodies-segmented-related-products)
			- [Watch Upsells](#watch-upsells)
			- [Venia Up-sells](#venia-up-sells)
			- [Bags to Hoodies and Fitness Equipment \(Cross-sells\)](#bags-to-hoodies-and-fitness-equipment-cross-sells)
		- [Promotions \(Cart Price Rules\)](#promotions-cart-price-rules)
			- [Deactivate Unwanted Rules](#deactivate-unwanted-rules)
			- [Free Shipping](#free-shipping)
		- [Targeted Content \(Dynamic Blocks\)](#targeted-content-dynamic-blocks)
			- [Featured Products \(Guest Customers\)](#featured-products-guest-customers)
			- [Featured Products \(Runners\)](#featured-products-runners)
			- [Featured Products \(Women Who Purchased NSDJ\)](#featured-products-women-who-purchased-nsdj)
			- [Featured Products \(VIP\)](#featured-products-vip)
			- [Free Shipping Advertisement](#free-shipping-advertisement)
			- [Free Shipping Applied Message](#free-shipping-applied-message)
			- [Rewards Program Advertisements](#rewards-program-advertisements)
		- [Staging and Preview Campaigns](#staging-and-preview-campaigns)
			- [Valentine's Day](#valentines-day)
			- [Summer Sale Lead-in](#summer-sale-lead-in)
			- [Fourth of July Sale](#fourth-of-july-sale)
			- [Summer Sale Lead-out](#summer-sale-lead-out)
			- [Black Friday Lead-in](#black-friday-lead-in)
			- [Black Friday Sale](#black-friday-sale)
			- [Holiday Campaign](#holiday-campaign)
	- [Content with Page Builder](#content-with-page-builder)
		- [Gear Category Landing Page](#gear-category-landing-page)
	- [Grid Views](#grid-views)
		- [Product Grids](#product-grids)
			- [Women's Hoodies](#womens-hoodies)
			- [On Sale](#on-sale)
			- [Featured Products](#featured-products)
		- [CMS Pages Grid](#cms-pages-grid)
		- [Customers Grid](#customers-grid)
		- [Staging and Preview Grid](#staging-and-preview-grid)
	- [Cache Warmer \(Site Map\)](#cache-warmer-site-map)
	- [B2B Demo Cases](#b2b-demo-cases)
		- [Configuration](#configuration)
			- [Enable B2B Modules](#enable-b2b-modules)
			- [Payment on Account](#payment-on-account)
		- [Customers](#customers)
		- [Sales Representative Role and User](#sales-representative-role-and-user)
		- [Companies](#companies)
			- [Terra Outfitters](#terra-outfitters)
			- [Emily's Exercise Emporium](#emilys-exercise-emporium)
		- [Buyer Users](#buyer-users)
		- [Buyer Teams](#buyer-teams)
		- [Buyer Roles and Permissions](#buyer-roles-and-permissions)
		- [B2B Autofill](#b2b-autofill)
		- [Catalogs](#catalogs)
	- [Fixes](#fixes)
		- [Pickup In Store Quantity is Mis-Aligned](#pickup-in-store-quantity-is-mis-aligned)
		- [Pickup In Store Extension Breaks B2B Checkout](#pickup-in-store-extension-breaks-b2b-checkout)
		- [Image Gallery Uses Prepend Instead of Replace](#image-gallery-uses-prepend-instead-of-replace)
		- [Hide the Venia Lookbook Category](#hide-the-venia-lookbook-category)
		- [Fix the Venia Tops Category](#fix-the-venia-tops-category)
		- [Email "From" Doesn't Show Properly](#email-from-doesnt-show-properly)

<!-- /MarkdownTOC -->

<a id="what-well-need"></a>
## What We'll Need

<a id="software"></a>
### Software
All we'll need to use this solution is *VMWare Fusion*.  This is provided by Adobe via the *App Catalog*.

<a id="vm-set-up"></a>
### VM Set Up
The following are the settings for the machine in VMWare:
 1. ***Hard Disk:***
	 1. *File Name:* Virtual Disk.vmdk
	 2. *Disk Size:* 16 GB
	 3. *Bus Type (Advanced):* SCSI
	 4. *Split Into Multiple Files (Advanced):* Yes 
2. ***Processors and Memory:***
	1. *Processors:* 2 processor cores
	2. *Memory:* 4096 MB (4GB) 
3. ***Network Adapter:***
	1. *Internet Sharing:* Share with my Mac (Mac OS) 

<a id="solution-components"></a>
### Solution Components
The VM consists of the following elements:
 1. ***Operating System:*** Ubuntu Server 18.04 LTS
 2. ***Web Server:*** Nginx
 3. ***PHP Version:*** 7.2
 4. ***Database:*** MariaDB
 5. ***Sessions:*** Redis
 6. ***Cache*** Varnish?
 7. ***Search:*** Elasticsearch 5.x
 8. ***Message Queue:*** RabbitMQ (optional)
 9. ***Package Manager:*** Composer
 10. ***Version Control:*** Git (included with Ubuntu)
 11. ***CLI Tools:*** Kukla VM CLI (via Github) 
 12. ***Fileshare Server:***  Samba and Avahi
 13. ***Web-based Admin:*** Webmin

<a id="helpful-additions"></a>
### Helpful Additions
The VM will also consist of the following packages/programs to aid in command line tasks and machine usage:
 1. `zip` (Zip utility)
 2. `unzip` (Unzip utility)
 3. `ag` (Super fast in-file search - similar to `grep`)
 4. `figlet` (Converts text to ascii art - used in our custom MoTD)

<a id="installing-vmware-fusion"></a>
## Installing VMWare Fusion
To Install VMWare Fusion: 
1. Click on the App Catalog icon in the bottom right hand corner of your dock
2. Search for VMWare
3. Click on VMWare Fusion in the results
4. Click on Install and wait for a bit -- there is no progress indicator
5. After some time, check your Applications folder to see if VMWare Fusion has been installed
6. Once it has been installed, launch it, choose `Check for Updates` from the `VMWare Fusion` Apple menu
7. Install any updates found

<a id="creating-the-vm"></a>
## Creating the VM
<a id="initial-setup"></a>
### Initial Setup
1. Before anything else, our VM will need an operating system.  As we've chosen to use Ubuntu, we'll download the OS disk image from the [Ubuntu website](https://www.ubuntu.com/download/server).

2. Once the operating system disk image is downloaded, we'll load it into VMWare Fusion and begin creating our virtual machine:

	1. With VMWare Fusion open, double-click on *Install from disc or image*.
	2. Drag and drop the downloaded disc image where indicated and then click *Continue*.
	3. De-select *Use Easy Install* and then click *Continue*.
	4. Choose *UEFI* but leave *UEFI Secure Boot* de-selected.
	5. Before finishing, we'll customize some machine settings.  Click the *Customize Settings* button to do so.
	6. As each new VM you create will require an actual file to be created on your hard drive, you'll now be prompted to save the file into a *Virtual Machines* directory.  VMWare creates this directory for you in your your home folder when it's installed.  Choose a name for the file and save it.
	7. Use the Settings dialog window which appears now to configure the machine to the settings above in [VM Set Up](#vm-set-up)
	8. When done, close the settings dialog and start the VM.

<a id="installing-ubuntu"></a>
### Installing Ubuntu
3. When the VM starts, it will automatically boot into the .iso image you used to create it.  Choose *Install Ubuntu* and then use the following settings:

	1. *Preferred Language:* English
	2. *Keyboard Layout(s):* English
	3. *Install alone or on the Cloud:* Install Ubuntu
	4. *Configure Network Interface:* From DHCP (choose *Done*)
	5. *Proxy Address:* None (choose "Done")
	6. *Mirror Address:* `http://archive.ubuntu.com/ubuntu` (choose *Done*)
	7. *Disk Partition*: Use An Entire Disk
	8. *Filesystem Setup:* `[ /dev/sda       16.00G ]`
	9. *Filesystem Summary:* Choose *Done*, then *Continue*
	10. *Profile Setup:*
		1. *Your name:* Solutions Consultant
		2. *Your server's name:* `localhost` (We'll update this later)
		3.  *Pick a username:* magento
		4. *Choose a password:* magento
		5. *Confirm your password:* magento
		6. *Import SSH identity:* No
		7. *Featured Server Snaps:* Hit *tab* and choose *Done*
		8. When available, choose *Reboot Now*
	11. During reboot, the system will ask you to remove the installation medium and press `Enter` (press `Enter` again to finish the reboot)

<a id="accessing-via-ssh"></a>
### Accessing via SSH
While VMWare gives you a window to use as a terminal, it can be rather limited in that the size of the window cannot be changed, and copy-paste is not supported.  To access the machine via SSH using a termimal, you have a couple options:

1. After booting the machine, in the VM Library, right click the machine name and choose *Connect to SSH*
2. VMWare will tunnel into the VM for you using your machine's default application

To use your own terminal application (such as iTerm, for example):

1. Log in to the machine
2. Get the IP address of the machine from the Message of the Day (MoTD)
3. Use ssh to tunnel in using your terminal application: `ssh magento@<YOUR_IP_HERE>`

<a id="setting-the-hostname"></a>
### Setting the Hostname
Next, we'll set a new hostname for the VM.  Since our initial url will be `luma.com`, let's use that as our hostname, too.  Once the hostname is changed, we also need to update our entry in the machine's `etc/hosts` file.  We'll use the VIM text editor to do this with the following commands:

1. `sudo hostnamectl set-hostname luma.com`
2. `sudo vim /etc/hosts`
3. Use `Shift + A` to move to the end of the line and switch to *Insert* mode
4. Press `tab` and type `luma.com`
5. Press `Esc` to exit *Insert* mode
6. Press `x` and then `Enter` to save the changes

Once those changes are saved, reboot the machine. Once the machine boots and loads the login prompt, you'll notice it now says `luma login` instead of `localhost login` which indicates our changes have taken effect.

<a id="adding-the-magento-qa-server-to-the-hosts-file"></a>
#### Adding the Magento QA Server to the Hosts File
In order to stay ahead of the development curve, the Solutions Innovation team often pulls pre-release cod via the Magento QA server.  We can do the same using an ssh tunnel and one of our cloud projects as a proxy.  The Magento VM CLI takes care of most of this for us, but we do need to make one change to ensure it can happen.

1. `sudo vim /etc/hosts`
3. Use `Shift + A` to move to the end of the line and switch to *Insert* mode
3. Enter: `127.0.0.1 connect20-qa04.magedevteam.com`
4. Press `Esc` to exit *Insert* mode
5. Press `x` and then `Enter` to save the changes


<a id="uninstalling-cloud-init"></a>
### Uninstalling Cloud-Init
As we're starting a cloud-init based Ubuntu VM (Ubuntu 18.04 Bionic Beaver ships with `cloud-init`), we may suffer long boot times and confusing output on the terminal. To get rid of it, we'll need to disable cloud-init:

`sudo echo 'datasource_list: [ None ]' | sudo -s tee /etc/cloud/cloud.cfg.d/90_dpkg.cfg && sudo apt-get purge cloud-init -y && sudo rm -rf /etc/cloud/; sudo rm -rf /var/lib/cloud/`

When done, reboot the machine.

(Source: [How to Remove cloud-init From Ubuntu](https://makandracards.com/operations/42688-how-to-remove-cloud-init-from-ubuntu))

<a id="applying-package-updates"></a>
### Applying Package Updates
In this section, we'll make sure the Operating System packages are up to date.

Use the following: `sudo apt update -y && sudo apt upgrade -y && sudo apt-get autoremove -y`

<a id="adding-the-ssh-key"></a>
### Adding the SSH Key
Certain items in our solution stack such as the VM CLI and the Magento code base will need special permissions which will be provided by an ssh key to which they've been granted.  Assuming you have the key in hand, to add it, use the following steps:

1. Create the `.ssh` directory in the `magento` user's home directory: `mkdir /home/magento/.ssh`
1. Create the key file with `vim /home/magento/Magento-Cloud`
2. Switch to *Insert* mode with `i`
3. Paste in the key contents and then exit *Insert* mode with `Esc`
4. Save the key file with `x` and then `Enter` 
5. Change the key file permissions to 0400 with `sudo chmod 0400 /home/magento/Magento-Cloud`

<a id="installing-helpful-additional-programs"></a>
### Installing Helpful Additional Programs
Next, we'll install the additional programs listedin the [Helpful Additions](#helpful-additions) section above. To install these programs and then check for package updates, upgrades and to remove unused packages, use the following commands:

`sudo apt install zip silversearcher-ag figlet -y && sudo apt update -y && sudo apt upgrade -y && sudo apt-get autoremove -y`

<a id="setting-the-motd"></a>
### Setting the MoTD
When a user logs in to a Linux-based operating system, they're greeted with what's called the *Message of the Day* (or MoTD).  This message can be modified, to show whatever we like, so let's modify it now to show some helpful information to our users.  We'll show them the machine's IP and hostname and format it in such a way that they can easily grab it for use as an entry in their local `hosts` file.

To set the MoTD, we must first *disable* the parts of the existing MoTD we don't want, and then add a script of our own.  To do this, run the following command: 

`sudo chmod -x /etc/update-motd.d/00-header /etc/update-motd.d/10-help-text /etc/update-motd.d/50-landscape-sysinfo /etc/update-motd.d/50-motd-news /etc/update-motd.d/80-esm /etc/update-motd.d/80-livepatch /etc/update-motd.d/90-updates-available /etc/update-motd.d/91-release-upgrade /etc/update-motd.d/95-hwe-eol /etc/update-motd.d/97-overlayroot /etc/update-motd.d/98-fsck-at-reboot`

Next, using `vim`, we'll create a custom bash script for our own MoTD: `sudo vim /etc/update-motd.d/01-custom`.  Use `i` to enter *Insert* mode, and then paste in the below:

```
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
printf '\n%23s : %s %s\t%s\n' "${BOLD}Host Entry" "${REG}${IP}" "${HOSTNAME}"
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
```

Exit *Insert* mode with `Esc` and then save and quit the file with `x` and `Enter`.  Make the new script as executable with `sudo chmod +x /etc/update-motd.d/01-custom`.

This MoTD is much more useful; it tells the user what hosts entry to use for the machine, the webmin url and credentials, as well as some useful commands from the VM CLI.  (We'll set up Webmin and the VM CLI shortly.)  To test the new MoTD, simply reboot the machine and login again.

**Note**: If you clear your screen and want to recall the MoTD, use: `cat /var/run/motd.dynamic`.  If you happen to have the VM CLI installed already, you can recall the motd with `motd`.

<a id="solution-components-installation"></a>
## Solution Components Installation
Next, we'll install and configure our solution components listed in the [Solution Components](#solution-components) section.

<a id="php"></a>
### PHP
First we'll install PHP 7.2 on Ubuntu.

<a id="installing-php-with-the-ondrejphp-repository"></a>
#### Installing PHP with the `ondrej/php` Repository
The main set of repositories for both PHP 5.6 and PHP 7.x are actively maintained by a fellow named Ondrej Sury. His repository is not part of the standard repository source list provided by Ubuntu, so we'll need to add it.  Once that's done, we'll check to see if the addition of that repository source requires updates for any of the other repositories on our system and then proceed to install PHP 7.2.x.  We'll also add the necessary PHP extensions/modules that Magento will need in order to run.  Copy and paste the below:

`sudo apt-get -y update && sudo add-apt-repository ppa:ondrej/php && sudo apt-get -y update && sudo apt-get install -y php7.2 libapache2-mod-php7.2 php7.2-common php7.2-gd php7.2-mysql php7.2-curl php7.2-intl php7.2-xsl php7.2-mbstring php7.2-zip php7.2-bcmath php7.2-iconv php7.2-soap php7.2-fpm`

During the installation process, you'll be prompted to confirm the addition of the PHP repository.  Press `Enter` when prompted.  Once the process finishes, PHP (both `cli` and `fpm`) will be installed.  Confirm this by checking your PHP version with `php -v`.  You should see something like:

```
PHP 7.2.13-1+ubuntu18.04.1+deb.sury.org+1 (cli) (built: Dec  7 2018 08:07:36) ( NTS )
Copyright (c) 1997-2018 The PHP Group
Zend Engine v3.2.0, Copyright (c) 1998-2018 Zend Technologies
    with Zend OPcache v7.2.13-1+ubuntu18.04.1+deb.sury.org+1, Copyright (c) 1999-2018, by Zend Technologies
```
With PHP and relevant extensions installed, we next need to configure PHP to run via FPM.

<a id="uninstalling-the-apache-web-server"></a>
#### Uninstalling the Apache Web Server
When we installed PHP, the Apache2 web server was inadvertantly installed.  Since our VM will use the Nginx web server, let's completely remove Apache to ensure there are no conflicts between the two.  To remove apache, use the following commands:

```
sudo systemctl stop apache2 && sudo apt-get purge apache2 apache2-utils -y && sudo apt-get autoremove -y
```

(Source: [How to Uninstall and Remove Apache2 on Ubuntu or Debuian](http://xmodulo.com/how-to-uninstall-and-remove-apache2-on-ubuntu-debian.html))

<a id="configuring-php-cli-and-php-fpm"></a>
#### Configuring PHP CLI and PHP-FPM
When PHP is installed, it can run PHP code immediately via the CLI. PHP-FPM (PHP (F)astCGI (P)rocess (M)anager) is alternative method of running PHP via a FastCGI interface.  This interface sits between the web server and the PHP CLI, and offers better performance for busier sites.  To configure PHP, we'll alter settings for both the CLI and the FPM so that they both use the same settings, and we'll configure the communication between PHP CLI and FPM.

First, the common settings.  Settings for PHP are configured in `php.ini` files.  There are two different `php.ini` files; one for PHP via CLI and one for PHP via FPM.  Here are the common settings we'll configure:

1. *System Timezone* (`date.timezone`): Set this to your preferred timezone in Unix notation (e.g. `America/Los_Angeles` for PST)
2. *PHP Memory Limit* (`memory_limit`): Set this to `2G`
3. *Max Execution Time* (`max_execution_time`): Set this to `1800`
4. *Transparent Output Compression* (`zlib.output_compression`): Set this to `On`
5. *Session Save Path* (`session.save_path`): Uncomment this so it's set to `/var/lib/php/sessions`. (We'll connect this to the web server later)

To edit these settings for PHP via the CLI:

1. Edit the CLI `php.ini` file using `vim` and `sudo`: `sudo vim /etc/php/7.2/cli/php.ini`
2. In *Command* mode, search the file for the above strings with the `/` character, e.g. `/date.timezone`
3. Press `Enter` to execute the search
4. When you find the line you want to edit, switch to *Insert* mode using the `i` key
5. Make your desired changes.  Note that if a setting is commented out with `;`, you'll need to delete the semi-colon for the setting to be live
6. If you want to search the file again for another string after a change is made, switch back to *Command* mode with `Esc` and then search again (e.g. `/memory_limit`)
7. If you're in *Command* mode, save and quit with `x` and then `Enter`.  If in *Insert* mode, use `Esc`, `x`, and `Enter`

To use the same settings for PHP via FPM, follow the same process with `sudo vim /etc/php/7.2/fpm/php.ini`

Once the configurations are saved, we'll want to restart PHP-FPM so they take effect.  Use `sudo systemctl restart php7.2-fpm`

(Sources: [Magento Dev Docs : Required PHP Settings](https://devdocs.magento.com/guides/v2.3/install-gde/prereq/php-centos-ubuntu.html#instgde-prereq-php71-ubuntu) and [Magento Dev Docs : Install and configure php-fpm](https://devdocs.magento.com/guides/v2.3/install-gde/prereq/nginx.html#install-and-configure-php-fpm))

<a id="nginx"></a>
### Nginx

<a id="installing-nginx"></a>
#### Installing Nginx

Use the following commands to install Nginx:

```
sudo apt-get -y install nginx && sudo apt update -y && sudo apt upgrade -y && sudo apt-get autoremove
```
<a id="configuring-the-web-server-user"></a>
#### Configuring the Web Server User
When nginx is installed, it includes a user group called `www-data` which can be used to give users permissions to execute scripts and web server commands.  We'll need to configure our `magento` user to be a part of the `www-data` group. To do this, use:

`sudo usermod -aG www-data magento`

Using the `-G` flag makes the `www-data` group a *supplemental* group for the `magento` user.  This means that the `magento` user will have access to the `www-data` group files, but that new files created by that user will not have the `www-data` group label by default.  The `-a` flag makes sure that other groups the user belongs to are not lost.  This is important in our case because we happen to be a part of the `sudo` group, and if we lost that assignment, we'd be unable to continue.

<a id="configuring-nginx-with-php-fpm"></a>
#### Configuring Nginx with PHP-FPM
Next, we'll need to configure Nginx to talk to PHP-FPM.  This connection is managed in `/etc/php/7.2/fpm/pool.d/www.conf`.  Using `sudo` and `vim` open the `www.conf` file and make the following changes:

```
user = magento
group = magento
```
Then:
```
 listen = 127.0.0.1:9000;
 listen.owner = magento
 listen.group = magento
```
Next, we need to change the ownership of PHP's session save path to be owned by our Magento user:

`sudo chown -R magento:magento /var/lib/php/sessions`

Next, we'll need to update the nginx configuration file to indicate that the `magento` user should run the web server:

1. `sudo vim /etc/nginx/nginx.conf`
2. Change `user www-data` to `user magento`
3. Save and close with `Esc`, `x` and press `Enter` 

Now we'll restart both the web server and PHP-FPM:

`sudo systemctl restart nginx && sudo systemctl restart php7.2-fpm`

Once this is done and the systems are started, you can verify everything is running as expected by running `sudo netstat -tulpn`.

(Source: [Magento Dev Docs : Install and configure php-fpm](https://devdocs.magento.com/guides/v2.3/install-gde/prereq/nginx.html#install-and-configure-php-fpm-1)) -- Note that the settings were taken from a section dealing with CentOS rather than Ubuntu, and the approach was modified to use the `magento` user instead of the web server user and a localhost and port directive instead of the php socket.)

<a id="create-the-web-root"></a>
#### Create The Web Root
Since we'll need the web root in order to make installing the Composer package manager easier, let's create it as `magento` inside of `/var/www`.  To do this, we need to give either the magento user or the web server user ownership of `var/www`.  (Since we've overridden the web server user in favor of `magento` in our PHP-FPM configuration, we'll use `magento`):

`sudo chown -R magento:magento /var/www`

Once that's done, we can create the web root with:

`mkdir /var/www/magento`

<a id="configure-magento-virtual-host"></a>
#### Configure Magento Virtual Host
Similar to apache, nginx uses virtual host (vhost) files to designate different websites that are hosted by the server. These vhost files are enabled and/or disabled by creating symlinks from the `/etc/sites-available` to the `/etc/sites-enabled` folder. By default, it ships with a default vhost: `/etc/nginx/sites-available/default`. Next, we'll disable the default vhost, set up a configuration file which will allow for easier configuration of multiple sites, and then set up the magento vhost for luma.com:

1. Remove the default site symlink and the default vhost file: `sudo rm -rf /etc/nginx/sites-enabled/default && sudo rm -rf /etc/nginx/sites-available/default`
2. Create a new directory for our configuration files.  They'll include `location` directives, which means they must be stored in `sites-available`, so let's use: `sudo mkdir /etc/nginx/sites-available/conf`
3. Create a new configuration file `sudo vim /etc/nginx/sites-available/conf/01-multisite.conf` and then add the following to it:

```
upstream fastcgi_backend {
     server 127.0.0.1:9000;
}

map $http_host $MAGE_RUN_CODE {
    luma.com base;
}

map $MAGE_RUN_CODE $MAGE_RUN_TYPE {
    base website;
}

include /etc/nginx/sites-enabled/luma.com;
```

4. Create a new vhost file `sudo vim /etc/nginx/sites-available/luma.com` and add the following to it:

```
server {
     listen 80;
     server_name luma.com;
     client_max_body_size 100M;
     set $MAGE_ROOT /var/www/magento;
     #include /etc/nginx/sites-available/conf/nginx-magento.conf;
}
```

Note the fact that the `nginx-magento.conf` file is commented out.  This is intentional and will be removed after we install the Magento code base.

5. Enable the new site by creating a symlink from `/etc/sites-available` to `/etc/sites-enabled` for both the multisite configuration and the luma.com virtual host: `sudo ln -s /etc/nginx/sites-available/conf/01-multisite.conf /etc/nginx/sites-enabled/01-multisite.conf && sudo ln -s /etc/nginx/sites-available/luma.com /etc/nginx/sites-enabled/luma.com`

6. Restart nginx with `sudo systemctl restart nginx` 

7. To test the site, we first need to add an entry to our hosts file.  You can grab this from our new MoTD and then use vim or Sublime (or any editor which allows administrator-priviledged edits) to edit the `/etc/hosts` file 

8. Test the site in a browser.  You should see the default nginx landing page

<a id="composer"></a>
### Composer
In order to download the Magento code base (and to work with Magento code in general), we'll use Composer, the PHP package manager.  Let's navigate to our web root and then install Composer globally.  Since we have to use `sudo` to install composer globally, we'll also need to change ownership of our Magento user's `.composer` directory so that it's owned by the `magento` user: with:

`cd /var/www/magento && curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/bin --filename=composer && sudo chown -R magento:magento /home/magento/.composer`

Once Composer is installed, you can test it with: `composer list`.

(Source: [Magento Dev Docs : Install Composer Globally](https://devdocs.magento.com/guides/v2.3/install-gde/prereq/nginx.html))

<a id="vm-cli"></a>
### VM CLI
Next, we'll install the VM CLI.  This is done by cloning a git repository. 

In order to clone the repository, we'll need to make sure the key we inserted earlier has access to it.  If it does, we'll need to add the key to the ssh-agent so that the system recognizes it. Once you've cloned it, you'll need to copy the included `.bashrc` file to the home directory of the magento user and then `source` it. Finally, the CLI consists of some scripts which need to be executable, so we'll set that, too. Use the following commands:

`eval "$(ssh-agent)" && ssh-add /home/magento/.ssh/Magento-Cloud && git clone git@github.com:skukla/vm-dotfiles.git /home/magento/cli && cp /home/magento/cli/.bashrc /home/magento/.bashrc && source /home/magento/.bashrc && sudo chmod +x /home/magento/cli/scripts/*` 

Once that's done, the VM CLI should work as expected.  You can test it by moving into the web root with: `www`.

<a id="mariadb"></a>
### MariaDB
Next, we'll install and configure our database, MariaDB.  As with PHP before, we'll need to add the MariaDB repository to Ubuntu 18.04. This consists of adding a repository key and the repository itself.  Here are the commands to add both to the system and then install MariaDB:

`sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8 && sudo add-apt-repository 'deb [arch=amd64] http://mirror.zol.co.zw/mariadb/repo/10.3/ubuntu bionic main' && sudo apt update && sudo apt -y install mariadb-server mariadb-client`

During installation, you'll be prompted to configure a new password for the root user.  We'll use `password` for ours when prompted.

<a id="adding-a-database-and-a-database-user"></a>
#### Adding A Database and A Database User
Now, we'll add a database to be used with the Magento installation as well as a database user for that database.

First, we log into MariaDB as `root`: `mysql -u root -ppassword`

Next, we'll create a database and database user, and then grant the user permission to use the new database:

```
CREATE DATABASE `magento`;
CREATE USER 'magento' IDENTIFIED BY 'password';
GRANT ALL ON magento.* TO magento@localhost IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
exit
```

Now, test the new user by logging in. You can check for the new database with `SHOW DATABASES;`

(Source: [How to create a user in MySQL/MariaDB and grant permissions on a specific database](http://www.daniloaz.com/en/how-to-create-a-user-in-mysql-mariadb-and-grant-permissions-on-a-specific-database/))

<a id="database-tuning"></a>
#### Database Tuning
Next, we'll tune our database to help it perform well:

1. Create database configuration file `sudo vim /etc/mysql/my.cnf` and ensure it has the followng:

```
!includedir /etc/mysql/conf.d/
!includedir /etc/mysql/mysql.conf.d/

[mysqld]
socket                          = /var/run/mysqld/mysqld.sock
innodb_buffer_pool_size         = 1G
max_allowed_packet              = 512M
tmp_table_size                  = 64M
max_heap_table_size             = 64M
```

2. Save and close with `Esc`, then `x`, then `Enter`
3. Finally, reload the configuration by restarting the server with `sudo systemctl restart mysql`

(Source: See Step 7 at [Magento Dev Docs: Configuring the Magento Database Instance](https://devdocs.magento.com/guides/v2.3/install-gde/prereq/mysql.html#instgde-prereq-mysql-config))

<a id="varnish"></a>
### Varnish
Now we'll install Varnish.  Use the following command:

`sudo apt -y install varnish && sudo apt update -y && sudo apt upgrade -y && sudo apt-get autoremove -y`

Once this is done, verify Varnish has been installed with `sudo netstat -tulpn`.  We'll come back to configuration after we install Magento.

For now, let's stop Varnish with `sudo systemctl stop varnish`.

(Source: [Set up Magento 2 with Redis, Varnish and Nginx as SSL termination : Install and configure Nginx](https://www.rosehosting.com/blog/magento-2-with-redis-varnish-and-nginx-as-ssl-termination/))

<a id="redis"></a>
### Redis
Next, let's install Redis.  Use the following commands:

`sudo apt install php-redis redis-server -y && sudo apt update -y && sudo apt upgrade -y && sudo apt-get autoremove -y`

As with Varnish, we'll configure Redis after we install Magento.

(Source: [Set up Magento 2 with Redis, Varnish and Nginx as SSL termination : Install and configure Redis caching](https://www.rosehosting.com/blog/magento-2-with-redis-varnish-and-nginx-as-ssl-termination/))

<a id="elasticsearch"></a>
### Elasticsearch
Next, let's install Elasticsearch.  Elasticsearch runs on Java, so the first thing we'll need to do is install the Java Software Development Kit (JDK).

<a id="install-java-with-the-jdk"></a>
#### Install Java With The JDK

Use the following commands to add the JDK repository and install Java:

`sudo add-apt-repository -y ppa:webupd8team/java && sudo apt update -y && sudo apt install oracle-java8-installer -y && sudo apt update -y && sudo apt upgrade -y && sudo apt-get autoremove -y`

Accept the Oracle License Agreement during installation.

(Source: [Magento Dev Docs: Install the Latest JDK on Ubuntu](https://devdocs.magento.com/guides/v2.3/config-guide/elasticsearch/es-overview.html#prereq-java))

<a id="installing-elasticsearch-56x"></a>
#### Installing Elasticsearch 5.6.x
In the event that Magento eventually supports a more up-to-date version of Elasticsearch, here are the instructions for installing it:

`sudo wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add - && sudo echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list && sudo apt update && sudo apt install elasticsearch -y && sudo apt update -y && sudo apt upgrade -y && sudo apt-get autoremove -y`

<a id="configuring-elasticsearch"></a>
#### Configuring Elasticsearch
After the installation, a default configuration file will be populated to `/etc/elasticsearch/elasticsearch.yml`. Most lines are commented out, edit the file to tweak and tune the configuration. We'll update it to change our clustername, for example.

1. `sudo vim /etc/elasticsearch/elasticsearch.yml`
2. Enter *Insert* mode with `i` and change `#cluster.name: my-application` to `cluster.name: magento`
3. Save and close with `Esc`, then `x` and press `Enter` 

The default minimum memory allocation set for Elasticsearch to use is 2GB.  On more powerful machines this should be fine, but as some users may have host machines which only have 8G of RAM rather than 16, we'll use less:

1. `sudo vim /etc/elasticsearch/jvm.options`
2. Enter *Insert* mode with `i` and change `-Xms2g` and `-Xmx2g` to values that make more sense for you (e.g. `-Xms512m` and `-Xmx512m` or `-Xms1g` and `-Xmx1g`, respectively.  (Let's use `1g` for now)
3. Save and close with `Esc`, then `x` and press `Enter`

Next, we'll reload the Elasticsearch daemon, enable Elasticsearch to start on boot, and then restart Elasticsearch:

`sudo systemctl daemon-reload && sudo systemctl enable elasticsearch.service && sudo systemctl restart elasticsearch.service`

Check the status of Elasticseatch with `systemctl status elasticsearch` (Use `Ctrl-C` to exit when done) or with `sudo netstat -tulpn`.  (Elasticsearch appears here as a `java` service on port `9200/9300`).

(Configuration and installation: [How to Install Elasticsearch 5.x on Ubuntu 18.04 LTS (Bionic Beaver) Linux](https://computingforgeeks.com/how-to-install-elasticsearch-5-x-on-ubuntu-18-04-lts-bionic-beaver-linux/))

<a id="elasticsearch-plugins"></a>
#### Elasticsearch Plugins
*TODO*

<a id="rabbitmq"></a>
### RabbitMQ
Next, we'll install RabbitMQ.

<a id="install-erlangotp"></a>
#### Install Erlang/OTP
RabbitMQ depends on the Erlang language before it can run.  As with many other parts of the stack, we'll need to add a repository to our sources list, install, check for updates and upgrades, and then remove any unneded packages:

`sudo wget -O - "https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc" | sudo apt-key add - && echo "deb http://dl.bintray.com/rabbitmq-erlang/debian bionic erlang" | sudo tee /etc/apt/sources.list.d/bintray.erlang.list && sudo apt install erlang-nox -y && sudo apt update -y && sudo apt upgrade -y && sudo apt-get autoremove -y`

<a id="install-rabbitmq"></a>
#### Install RabbitMQ
Next, we'll import the RabbitMQ repository keys, add the repository, and install RabbitMQ:

`sudo wget -O - "https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc" | sudo apt-key add - && sudo echo "deb https://dl.bintray.com/rabbitmq/debian bionic main" | sudo tee /etc/apt/sources.list.d/bintray.rabbitmq.list && sudo apt update -y && sudo apt install rabbitmq-server -y && sudo apt update -y && sudo apt upgrade -y && sudo apt-get autoremove -y`

Once this is done, you can confirm RabbitMQ is running with `sudo netstat -tulpn`.  The `/epmd` entry is Erlang, and the entries with `/beam.smp` are RabbitMQ.

(Source: [Installing RabbitMQ on Debian and Ubuntu](https://www.rabbitmq.com/install-debian.html))

<a id="configuring-rabbitmq-to-respect-hostname-change"></a>
#### Configuring RabbitMQ To Respect Hostname Change
RabbitMQ doesn't work well when the VM's hostname is changed.  Since this is important for us, we'll implement a work-around for it.

First, we need to update our `/etc/hosts` file to include the proper hostname for RabbitMQ which (in this case) is `luma`.  To do this: 

1. `sudo vim /etc/hosts`
2. Switch into *Insert* mode and move to the end of the line with `Shift-A`
3. Press `Tab` and then type `luma`.
4. Save and exit with `Esc`, then `x` and press `Enter` 

Next, we'll create a configuration file and specify the original hostname `luma` (Note: not `luma.com` as `hostname` tells us):

1. `sudo vim /etc/rabbitmq/rabbitmq-env.conf`
2. Switch into *Insert* mode with `i`
3. Type: `NODENAME=rabbit@luma`

This gives us a hook to change the node name via a script when a user updates his or her hostname.

Finally, restart RabbitMQ with `sudo systemctl restart rabbitmq-server`.

(Source: [rabbitmq-server fails to start after hostname has changed for the first time](https://stackoverflow.com/questions/14659335/rabbitmq-server-fails-to-start-after-hostname-has-changed-for-first-time) -- The accepted answer is incorrect; see the answer from James Oravec.)

<a id="install-rabbitmq-management-dashboard"></a>
#### Install RabbitMQ Management Dashboard
It can be helpful to have a GUI to manage RabbitMQ, so we'll install and configure one next.

To install it, use: `sudo rabbitmq-plugins enable rabbitmq_management` and then restart RabbitMQ with the RabbitMQ CLI: `rabbitmqctl start_app`.

When installed, you can access the dashboard at `luma.com:15672`.

By default, a guest user is available (`user: guest / password: guest`); however, this user can only log in via a `localhost` hostname. To be able to log in as an actual user, we'll need to create one:

`rabbitmqctl add_user magento magento && rabbitmqctl set_user_tags magento administrator`

Now, log in to the dashboard at the url above.

(Source: [Enable the RabbitMQ Management Dashboard](https://computingforgeeks.com/how-to-install-latest-rabbitmq-server-on-ubuntu-18-04-lts/))

<a id="managing-the-vm-with-webmin"></a>
### Managing the VM with Webmin

<a id="installing-and-configuring-webmin"></a>
#### Installing and Configuring Webmin

<a id="configuring-the-webmin-port"></a>
##### Configuring the Webmin Port
Next, we'll configure webmin to use port 20000:

1. `sudo vim /etc/webmin/miniserv.conf`
2. Use `i` for *Insert* mode and change the port on the first line (`port=20000`)
3. Save and close with `Esc`, `x`, and `Enter`

(Source: [How to change webmin port using terminal?](https://www.iodocs.com/change-webmin-port-using-terminal/))

<a id="remove-ssl-mode"></a>
##### Remove SSL Mode
Next, let's remove SSL authentication from Webmin

1. `sudo vim /etc/webmin/miniserv.conf`
2. Use `i` for *Insert* mode and change `ssl=1` to `ssl=0`
3. Save and close with `Esc`, `x`, and `Enter`

Source: ([Webmin Error: The Web Server is running in SSL mode](http://eitwebguru.com/webmin-error-the-web-server-is-running-in-ssl-mode/))

Restart the `webmin` service using `sudo systemctl restart webmin`

<a id="handling-email-with-mailhog"></a>
### Handling Email with Mailhog
Next, we'll install and configure Mailhog, a tool that catches outgoing email and presents it for viewing via a web interface.

<a id="installing-the-go-programming-language"></a>
#### Installing the Go Programming Language
Mailhog is written in the Go programming language which is not included with Ubuntu 18.04.  So, we'll start by installing it.  Then, we'll create a directory which will serve as our "home" directory for our Go code and then designate this directory as our HOME path for all Go code execution in our bash `.profile`.  This makes it so that whenever we open an ssh or terminal session on the VM and run go code, it knows where the go packages are.  Next, we'll source our shell which will force the terminal to use the new settings, and finally, we'll copy our binaries to a location on the VM where they can be run from everywhere.

`sudo apt install golang-go -y && sudo apt update -y && sudo apt upgrade -y && mkdir /home/vagrant/gocode && echo "export GOPATH=$HOME/gocode" >> ~/.profile && source ~/.profile`

<a id="downloading-and-configuring-mailhog"></a>
#### Downloading and Configuring Mailhog
Now that we have the Go language installed, let’s download MailHog (the SMTP server) plus mhsendmail, which is the mail handler that forwards PHP’s outgoing email to MailHog.  Then, we'll copy the Mailhog and MHSendmail binaries to a location where they can be accessed globally on the system:

`go get github.com/mailhog/MailHog && go get github.com/mailhog/mhsendmail && sudo cp /home/vagrant/gocode/bin/MailHog /usr/local/bin/mailhog && sudo cp /home/vagrant/gocode/bin/mhsendmail /usr/local/bin/mhsendmail`

Finally, let’s connect PHP with MailHog at php.ini:

For both `/etc/php/7.2/cli` and `/etc/php/7.2/fpm`:

1. Find the `sendmail_path` setting `sudo` and `vim` to set it as:
2. `sendmail_path = /usr/local/bin/mhsendmail`
3. Use `Esc`, then `x`, and `Enter` to save and close
4. Restart `php-fpm` with `sudo systemctl restart php7.2-fpm`

<a id="creating-the-mailhog-service"></a>
#### Creating the Mailhog Service
In order to make it easier to use Mailhog and to be able to start it as a service when the VM boots, we need to create a service file:

1. Create the file with `sudo vim /etc/systemd/system/mailhog.service`  and, after switching to *Insert* mode with `i`, paste the following into it:

```
[Unit]
Description=MailHog service

[Service]
ExecStart=/usr/local/bin/mailhog \
  -api-bind-addr 0.0.0.0:10000 \
  -ui-bind-addr 0.0.0.0:10000 \
  -smtp-bind-addr 0.0.0.0:1025

[Install]
WantedBy=multi-user.target
```

2. Save and quit with `Esc`, then `x`, then `Enter`
3. Start the service to verify that it works: `sudo systemctl start mailhog`
4. Enable the service so it runs on bootup: `sudo systemctl enable mailhog`
5. Optional: Restart the VM, login, and then use `sudo netstat -tulpn | grep "mailhog"` to confirm it's running
6. Lastly, you can test it by loading `luma.com:20000` in a browser

With Mailhog configured, you should be able to send transactional emails from Magento and see them in the Mailhog interface.  We'll go over Magento-specific domain configuration in a later section.

Source: [Installing MailHog for Ubuntu 16.04](https://www.lullabot.com/articles/installing-mailhog-for-ubuntu-1604)

<a id="magento"></a>
## Magento

<a id="downloading-the-codebase-with-git-and-composer"></a>
### Downloading The Codebase With Git and Composer
Note that before we can download the Commerce Edition code base, we'll need credentials with the correct access to the Magento code base repository.

Normally, we'd use Composer to download the Magento codebase.  However, to keep consistent with our Magento Cloud counterparts, we'll add our ssh key to the key agent and navigate to the web root using the VM CLI and then install the beginnings of the code base via a git repository maintained by the Magento Solution Innovations team.  Once cloned, we'll check out the proper branch and then use composer to download the code base.

`add-key && www && git clone git@github.com:PMET-public/magento-cloud.git . && git checkout pmet-2.3.0-demo && composer install`

When prompted, enter your Magento code base repository credentials and then store the credentials in `home/magento/.composer/auth.json` when prompted.

<a id="installing-the-magento-application"></a>
### Installing The Magento Application
Use the following comamnd to install the Magento application (change your values where applicable):

TODO: Test installation with Redis... `session-save=db`.

**Without RabbitMQ**

`./bin/magento setup:install --db-host=localhost --db-name=magento --db-user=magento --db-password=password --backend-frontname=admin --base-url=http://luma.com/ --language=en_US --timezone=America/Los_Angeles --currency=USD --admin-lastname=Admin --admin-firstname=Admin --admin-email=admin@luma.com --admin-user=admin --admin-password=admin4tls --use-rewrites=1 --cleanup-database`

**With RabbitMQ**

`./bin/magento setup:install --db-host=localhost --db-name=magento --db-user=magento --db-password=password --backend-frontname=admin --base-url=http://luma.com/ --language=en_US --timezone=America/Los_Angeles --currency=USD --admin-lastname=Admin --admin-firstname=Admin --admin-email=admin@luma.com --admin-user=admin --admin-password=admin4tls --use-rewrites=1 --amqp-host="luma.com" --amqp-port=5672 --amqp-user="guest" --amqp-password="guest" --amqp-virtualhost="/" --cleanup-database`

<a id="installing-cron-tasks"></a>
### Installing Cron Tasks
Magento operates using loads of cron jobs -- everything from reindexing to staging updates requires cron jobs to run.  Luckily for us, the Magento CLI includes an easy-to-use command which allows us to create the required `crontab` to run application cron jobs.  To install it, we'll navigate to the web root and execute the CLI command with:

`www && ./bin/magento cron:install`


<a id="configuring-magento-and-varnish"></a>
### Configuring Magento and Varnish
*TODO*

<a id="configuring-magento-for-multisite-operation"></a>
### Configuring Magento For Multisite Operation
Magento ships with a sample nginx configuration file  `nginx.conf.sample`.  In order to support multisite directives, we'll copy this file and then add some configurations to it. We'll store it away from the code base in case the native `nginx.conf.sample` file changes in a future release.

1. First, let's copy the `nginx.conf.sample` file to our `sites-available` directory: `sudo cp /var/www/magento/nginx.conf.sample /etc/nginx/sites-available/conf/00-nginx-magento.conf`
2. Next, we need to use `sudo vim /etc/nginx/sites-available/conf/nginx-magento.conf` and then add following lines into the location directive for the main PHP entry point of the Magento application (lines 174-181 - start just beneath the `fastcgi_connect_timeout 600s;` line):

```
######
# START MULTI-SITE CUSTOMIZATION
######
fastcgi_param MAGE_RUN_CODE $MAGE_RUN_CODE;
fastcgi_param MAGE_RUN_TYPE $MAGE_RUN_TYPE;
######
# STOP MULTI-SITE CUSTOMIZATION
######
```

3. Now, restart the web server with `sudo systemctl restart nginx`

<a id="how-magento-multisite-operation-works"></a>
### How Magento Multisite Operation Works
*TODO*

<a id="using-the-vm"></a>
# Using the VM
<a id="demo-environments"></a>
## Demo Environments
The Solutions Innovation team provides Solutions Consultants with two Cloud projects for demonstrating the Luma brand: a Reference environment and a Demo environment.  The *Reference* environment is a completely native installation of Magento -- there are no extensions of any kind; only the code base and the sample data which ships with the platform.  In contrast, the *Demo* environment builds on the native installation with sample data but adds both custom modules built and/or maintained by the Solutions Innovation team as well as third-party extensions built by the Magento developer community.

<a id="the-hybrid-vm"></a>
## The Hybrid VM
For some solution consultants, the two default environments cover both extremes, and may not be an ideal solution.  On one hand, while the Reference environments are entirely native, there are useful additions that will serve Solutions Consultants more effectively in the field without including too many customizations.

<a id="preparation"></a>
### Preparation
For whatever reason, it is not currently possible to use the cloud code base to create a custom VM.  Exhaustive testing has shown that some combinations of the Luma DE and Venia-related modules cause cron jobs to become unmanageable and results are not predictable.  As such, we will create the hybrid environment from scratch and pull in needed elements from Cloud.  Note that before you begin pulling code, you'll need a set of composer credentials for the Magento repository which have the correct access permissions.

<a id="downloading-the-code"></a>
### Downloading the Code
To begin, we start by using Composer to download the code in the web root.   We'll also include the B2B modules and the Luma sample data:


1. `www`
2. `rm -rf * .*` (Optional: Removes files from web root -- only used if this is a reinstall)
3. `composer create-project --repository-url=https://repo.magento.com/ magento/project-enterprise-edition=^2.3.0 . && composer require magento/extension-b2b:^1.1 && ./bin/magento sampledata:deploy
`

(The sample data step will require your composer credentials, so be prepared to provide those.  It'll also ask you whether you'd like to store them for future use.)

<a id="customizing-the-codebase"></a>
### Customizing the Codebase
Once the native source code is downloaded, we'll adapt it by adding and removing modules we'll use for our demos.  This process will consist of specifying modules to include in the codebase in the `require` section and then specifying where the code for those modules will be downloaded in the `repositories` section.

In your `composer.json`, use the following require section:

```
"require": {
	"magento/extension-b2b": "^1.1",
	"magento/module-bundle-sample-data": "100.3.*",
	"magento/module-catalog-rule-sample-data": "100.3.*",
	"magento/module-catalog-sample-data": "100.3.*",
	"magento/module-cms-sample-data": "100.3.*",
	"magento/module-configurable-sample-data": "100.3.*",
	"magento/module-customer-balance-sample-data": "100.3.*",
	"magento/module-customer-sample-data": "100.3.*",
	"magento/module-downloadable-sample-data": "100.3.*",
	"magento/module-gift-card-sample-data": "100.3.*",
	"magento/module-gift-registry-sample-data": "100.3.*",
	"magento/module-grouped-product-sample-data": "100.3.*",
	"magento/module-msrp-sample-data": "100.3.*",
	"magento/module-multiple-wishlist-sample-data": "100.3.*",
	"magento/module-offline-shipping-sample-data": "100.3.*",
	"magento/module-product-links-sample-data": "100.3.*",
	"magento/module-review-sample-data": "100.3.*",
	"magento/module-sales-rule-sample-data": "100.3.*",
	"magento/module-sales-sample-data": "100.3.*",
	"magento/module-swatches-sample-data": "100.3.*",
	"magento/module-target-rule-sample-data": "100.3.*",
	"magento/module-tax-sample-data": "100.3.*",
	"magento/module-theme-sample-data": "100.3.*",
	"magento/module-widget-sample-data": "100.3.*",
	"magento/module-wishlist-sample-data": "100.3.*",
	"magento/product-enterprise-edition": "2.3.0",
	"magento/sample-data-media": "100.3.*",
	"magento/page-builder-commerce": "*@beta",

	"firegento/fastsimpleimport": "dev-updated",
	"magentoese/module-admin-configurations": "dev-master",
	"magentoese/module-autofill": "dev-master",
	"magentoese/module-autofill-sample-data": "dev-demo",
	"magentoese/module-demo-admin-configurations": "dev-master",
	"magentoese/module-installation-overrides": "dev-master",
	"magentoese/module-instorepickup": "dev-master",
	"magentoese/module-instorepickup-sample-data": "dev-master",

	"magentoese/module-customer-sample-data": "dev-master",
	"magentoese/module-demo-order-data": "dev-master",
	"magentoese/module-sales-sample-data": "dev-master",

	"magentoese/module-product-sample-data-update": "dev-master",
	"magentoese/module-productbadge": "dev-master",
	"magentoese/module-productbadge-sample-data": "2.3.x-dev",
	"magentoese/module-sctools": "dev-master",
	"magentoese/module-switcherlogos": "dev-master",
	"magentoese/module-themecustomizer": "dev-master",

	"classyllama/module-owlcarousel":"dev-master",
	"magentoese/module-lookbook": "dev-master",
	"magentoese/module-luma-de-attributes": "dev-master",
	"magentoese/module-luma-de-categories": "dev-master",
	"magentoese/module-luma-de-cms": "dev-master",
	"magentoese/module-luma-de-products": "dev-master",
	"magentoese/module-luma-de-setup": "dev-master",
	"magentoese/module-luma-de-widget": "dev-master",
	"splendidinternet/mage2-locale-de-de": "dev-master",

	"magentoese/module-venia-setup": "dev-master",
	"magentoese/theme-frontend-venia": "2.3.x-dev",
	"magentoese/module-venia-catalog-sample-data": "dev-master",
	"magentoese/module-venia-cms-sample-data": "2.3.x-dev",
	"magentoese/module-venia-media-sample-data": "2.3.x-dev",
	"magentoese/module-vimeo": "2.2.x-dev",
	"magentoese/module-venia-video-sample-data": "dev-master",
	"magentoese/magento-scripts": "2.2.5.x-dev",
	"magentoese/ece-tools": "2002.0.14.x-dev",

	"skukla/theme-frontend-custom": "dev-master",
	"skukla/module-custom-brand-setup": "dev-master"
}
```

Next, use the following `repositories` section:

```
"repositories": [
    {"type": "composer", "url": "https://repo.magento.com/"},
    {"type": "git", "url": "git@gitlab.the1umastory.com:md/amasty-module-advanced-conditions.git"},
    {"type": "git", "url": "git@gitlab.the1umastory.com:md/amasty-module-banners-lite.git"},
    {"type": "git", "url": "git@gitlab.the1umastory.com:md/amasty-module-base.git"},
    {"type": "git", "url": "git@gitlab.the1umastory.com:md/amasty-module-blog-pro.git"},
    {"type": "git", "url": "git@gitlab.the1umastory.com:md/amasty-module-duplicate-categories.git"},
    {"type": "git", "url": "git@gitlab.the1umastory.com:md/amasty-module-free-gift.git"},
    {"type": "git", "url": "git@gitlab.the1umastory.com:md/amasty-module-geoip.git"},
    {"type": "git", "url": "git@gitlab.the1umastory.com:md/amasty-module-groupcat.git"},
    {"type": "git", "url": "git@gitlab.the1umastory.com:md/amasty-module-product-attachments.git"},
    {"type": "git", "url": "git@gitlab.the1umastory.com:md/amasty-module-rules-grid.git"},
    {"type": "git", "url": "git@gitlab.the1umastory.com:md/amasty-module-special-promotions-pro.git"},
    {"type": "git", "url": "git@gitlab.the1umastory.com:md/amasty-module-special-promotions.git"},
    {"type": "git", "url": "git@gitlab.the1umastory.com:md/amasty-module-store-locator.git"},
    {"type": "git", "url": "git@gitlab.the1umastory.com:md/module-admin-configurations.git"},
    {"type": "git", "url": "git@gitlab.the1umastory.com:md/module-cms-media-sample-data-update.git"},
    {"type": "git", "url": "git@gitlab.the1umastory.com:md/module-switcherlogos.git"},
    {"type": "git", "url": "git@gitlab.the1umastory.com:md/paradoxlabs-authnetcim.git"},
    {"type": "git", "url": "git@gitlab.the1umastory.com:md/paradoxlabs-firstdata.git"},
    {"type": "git", "url": "git@gitlab.the1umastory.com:md/paradoxlabs-stripe.git"},
    {"type": "git", "url": "git@gitlab.the1umastory.com:md/paradoxlabs-subscriptions.git"},
    {"type": "git", "url": "git@gitlab.the1umastory.com:md/paradoxlabs-tokenbase.git"},
    {"type": "git", "url": "git@github.com:PMET-public/module-m2epro.git"},
    {"type": "git", "url": "git@github.com:PMET-public/module-autofill-sample-data.git"},
    {"type": "git", "url": "git@github.com:PMET-public/module-autofill.git"},
    {"type": "git", "url": "git@github.com:PMET-public/module-demo-admin-configurations.git"},
    {"type": "git", "url": "git@github.com:PMET-public/module-instorepickup.git"},
    {"type": "git", "url": "git@github.com:PMET-public/module-instorepickup-sample-data.git"},
    {"type": "git", "url": "git@github.com:PMET-public/module-product-sample-data-update.git"},
    {"type": "git", "url": "git@github.com:PMET-public/module-productbadge.git"},
    {"type": "git", "url": "git@github.com:PMET-public/module-productbadge-sample-data.git"},
    {"type": "git", "url": "git@github.com:PMET-public/module-productimageswitcher.git"},
    {"type": "git", "url": "git@github.com:PMET-public/module-sctools.git"},
    {"type": "git", "url": "git@github.com:PMET-public/module-themecustomizer.git"},
    {"type": "git", "url": "git@github.com:PMET-public/FireGento_FastSimpleImport2.git"},
    {"type": "git", "url": "git@github.com:PMET-public/module-installation-overrides.git"},
    {"type": "git", "url": "git@gitlab.the1umastory.com:md/module-lookbook.git"},
    {"type": "git", "url": "git@github.com:PMET-public/module-luma-de-attributes.git"},
    {"type": "git", "url": "git@github.com:PMET-public/module-luma-de-categories.git"},
    {"type": "git", "url": "git@github.com:PMET-public/module-luma-de-cms.git"},
    {"type": "git", "url": "git@github.com:PMET-public/module-luma-de-products.git"},
    {"type": "git", "url": "git@github.com:PMET-public/module-luma-de-setup.git"},
    {"type": "git", "url": "git@github.com:PMET-public/module-luma-de-widget.git"},
    {"type": "git", "url": "git@gitlab.the1umastory.com:md/Magento2_German_LocalePack_de_DE.git"},
    {"type": "git", "url": "git@github.com:PMET-public/theme-frontend-venia.git"},
    {"type": "git", "url": "git@gitlab.the1umastory.com:md/module-venia-media-sample-data.git"},
    {"type": "git", "url": "git@github.com:PMET-public/module-venia-catalog-sample-data.git"},
    {"type": "git", "url": "git@github.com:PMET-public/module-venia-cms-sample-data.git"},
    {"type": "git", "url": "git@github.com:PMET-public/module-venia-setup.git"},
    {"type": "git", "url": "git@github.com:PMET-public/module-venia-video-sample-data.git"},
    {"type": "git", "url": "git@github.com:PMET-public/module-vimeo.git"},
    {"type": "git", "url": "git@github.com:PMET-public/module-customer-sample-data.git"},
    {"type": "git", "url": "git@github.com:PMET-public/module-demo-sample-order-data.git"},
    {"type": "git", "url": "git@github.com:PMET-public/module-sales-sample-data.git"},
    {"type": "git", "url": "git@github.com:PMET-public/magento-scripts.git"},
    {"type": "git", "url": "git@gitlab.the1umastory.com:md/ece-tools.git"},
    {"type": "git", "url": "git@github.com:PMET-public/module-sctools.git"},
    {"type": "git", "url": "git@github.com:skukla/theme-frontend-custom.git"},
    {"type": "git", "url": "git@github.com:skukla/module-custom-brand-setup.git"}
]
```

Next, since Page Builder is in beta, we'll need to update our minimum stability setting so that beta code can be included in the codebase. Change the setting from `stable` to `beta`.

Save the `composer.json` file. When done, we can use `composer upgrade` to download the code we want.

<a id="downloading-and-applying-patches"></a>
### Downloading and Applying Patches
Since the Magento application is a moving target, The Innovations team maintains a series of patches to fix known issues prior to installing the application.  First, we'll need to create a folder for the cloud codebase outside of our web root, download the hotfixes we want to apply from the cloud codebase using git, copy them into our codebase, and then apply them:

1. `www && cd ../ && mkdir cloud && cd cloud`
2. `git clone git@github.com:PMET-public/magento-cloud.git . && git checkout pmet-2.3.0-demo`
3. `www && cp -R ../cloud/m2-hotfixes/ .`
4. `php vendor/magentoese/ece-tools/bin/ece-tools patch`

<a id="installing-the-codebase"></a>
### Installing the Codebase
With the patches applied, we can use the install command above to install the application.

<a id="demo-case-setup"></a>
## Demo Case Setup

<a id="autofill-setup"></a>
### Autofill Setup
Initially, the autofill extension includes three enabled personas: VIP, Runner, and Yoga.  The first change we'll make is to add names to these profiles so we can refer to them in the demo story.  In `Stores > Settings > Configuration > Magento Ese > Auto Fill`, update the personas so that the persona labels reflect the following:

1. `Sharon Reynolds (VIP)`
2. `Mark Woodward (Runner)`
3. `Lisa Firey (Yogi)`

Then, clear cache.

<a id="business-operations-setup"></a>
### Business Operations Setup 

<a id="update-the-root-category-website-and-store-names"></a>
#### Update the Root Category, Website, and Store Names
By default, the Root Category for the Luma Catalog is called `Default Category` which doesn't show as well as it could.  Let's update it to `Luma Catalog` instead.

In addition, the Website and Store names could also show better.  Let's use the following:

1. Website:
	Website Name: `Luma Website`
	Website Code: `base`
2. Store:
	Store Name: `Luma Store`
	Store Code: `luma_store`

We can also update Venia to match:

3. Store:
	Store Name: `Venia Store`
	Store Code: `venia_store`

When done, run the `clean` command to reindex and clear the cache.

<a id="set-the-store-information-and-shipping-origin"></a>
#### Set the Store Information and Shipping Origin
In order for Shipping Labels to work properly, we'll need to fill in the Store Information address as well as the Shipping Origin:

Navigate to `Stores > Settings > Configuration > General > General > Store Information` and use:

1. Store Name: `Luma, Inc.`
2. Store Phone Number: `310-945-0345`
3. Store Hours of Operation: `9AM - 5PM`
4. Country: `United States`
5. Region/State: `California`
6. Zip/Postal Code: `90016`
7. City: `Los Angeles`
8. Street Address: `3640 Holdrege Ave`

Next, to set the shipping origin, navigate to `Stores > Settings > Configuration > Sales > Shipping Settings` and update the following settings:

1. Zip/Postal Code: `90016`
2. City: `Los Angeles`
3. Street Address: `3640 Holdrege Ave`

When done, clear the cache.

<a id="set-ups-as-the-shipping-method"></a>
#### Set UPS as the Shipping Method
To set up UPS as the shipping method, navigate to: `Stores > Settings > Configuration > Sales > Shipping Methods`

For some reason, Magento Shipping comes "configured" with API credentials which are incorrect.  We need to remove the values in the Account ID and API Token fields in order for our changes to save.  Remove those first from the `Magento Shipping` section.

Next, use the following in the UPS section:

1. Enabled for Checkout: `Yes`
2. Enabled for RMA: `Yes`
3. UPS Type: `United Parcel Service XML`
4. Mode: `Development`
5. User ID: `magento`
6. Access License Number: `ECAB751ABF189ECA`
7. Password: `magento200`
8. Shipper Number: `207W88`
9. Allowed Methods:
	1. `Ground`
	2. `UPS Next Day Air`

In order to use free shipping promotions, we need to set the following:

10. Free Method: `UPS Ground`
11. Enable Free Shipping Threshold: `Enable`
12. Free Shipping Amount Threshold: `1000000000`

(Using the ridiculously high threshold ensures that free shipping is only offered when shopping cart price rules offer it.  If we leave it at 0, Free Shipping for UPS would be offered for any order amount.)

In addition, we'll disable table rate shipping and flat rate shipping.  Note:  If you ever need to work on the VM offline, you'll need to disable UPS as a shipping method and make sure to use Flat Rate shipping since it doesn't require an API call.

Once saved, refresh the cache.

<a id="configure-braintree-as-authorize-only"></a>
#### Configure Braintree as Authorize Only
The innovations team has configured the demo configurations for the braintree payment method to use Authorize and Capture.  This is not ideal for demonstrating the true, complete order flow - including all possible order statuses.  We'll update that configuration to use `Authorize Only`.

Navigate to: `Stores > Settings > Configuration > Sales > Payment Methods > Braintree > Configure` and change the Payment Action to `Authorize`.

Once changed, refresh the cache. 

<a id="youtube-api-key"></a>
#### YouTube API Key
To use YouTube for product videos, we need to enter a YouTube API key.  Navigate to: `Stores > Settings > Configuration > Catalog > Catalog Product Video` and use the following API key:

`AIzaSyD4E-F8dCwzFp0OkOD1LdIiFFG8Q0wDy1o`

Once saved, refresh the cache.

<a id="enable-rma"></a>
#### Enable RMA
By default, RMA is not enabled for use.  To enable it, navigate to: `Stores > Settings > Configuration > Sales > Sales > RMA Settings`.

1. Enable RMA on Storefront: `Yes`

When saved, refresh the cache.

<a id="password-policy"></a>
#### Password Policy
By default, Magento has a pretty stringent password policy (three separate character classes and a forced reset for admins every 90 days.)  We're going to amend that to something much more friendly.

For customer-facing passwords, navigate to: `Stores > Settings > Configuration > Customers > Customer Configuration > Password Options`:

1. Number of Required Character Classes: `1`
2. Maximum Login Failures to Lockout Account: `0`
3. Minimum Password Length: `1`

For admin-facing passwords, navigate to: `Stores > Settings > Configuration > Advanced > Admin > Security` and verify:

1. Admin Session Lifetime: `900000`
2. Maximum Login Failures to Lockout Account: `{BLANK}`
3. Max Number of Password Reset Requests: `0`
3. Password Lifetime: `{BLANK}`
4. Password Change: `Recommended`

<a id="enable-instant-purchase"></a>
#### Enable Instant Purchase
Verify Instant Purchase is enabled at: `Stores > Settings > Configuration > Sales > Sales > Instant Purchase`

<a id="remove-welcome-message"></a>
#### Remove Welcome Message
By default, Magento includes an annoying text string "Default welcome msg!" which gets replaced with "Welcome!" when a customer logs in.  Since this is stupidly unnecessary for a guest user, we'll remove it.

Navigate to: `Content > Design > Configuration` and choose Global scope. Expand the Header section, empty the Welcome Text field, and save.  Clear cache when done.

<a id="update-site-meta-info"></a>
#### Update Site Meta Info
Next, we'll set up global meta information for pages like the Order Confirmation results page which don't have headings.  Navigate to: `Content > Design > Configuration` and the `Luma Store US English` store view scope.  Use the following:

1. Default Page Title: `LUMA Official Online Store`
2. Default Meta Description: `With more than 230 stores spanning 43 states and growing, Luma is a nationally recognized active wear manufacturer and retailer. We’re passionate about active lifestyles – and it goes way beyond apparel.`
3. Default Meta Keywords: `yoga,exercise,apparel,clothing,working out,fitness`

Next, use the following for the `Venia Store US English` store view scope:

1. Default Page Title: `VENIA Official Online Store`
2. Default Meta Description: `With 50 stores spanning 40 states and growing, Venia is a nationally recognized high fashion retailer for women. We’re passionate about helping you look your best.`
3. Default Meta Keywords: `fashion,women,blouse,top,pant,dress,venia`

<a id="configure-reward-points"></a>
#### Configure Reward Points
In order to use Reward Points in an order, we need to ensure that Reward Points able to be earned for purchases and that a bi-directional Reward Exchange Rate is created.

Navigate to `Customers > Reward Points >  Actions for Acquiring Reward Points by Customers`

1. Purchase: `Yes`
2. Navigate to `Stores > Other Settings > Reward Exchange Rates`
3. Add a new rate for points to currency:
	1. Website: `Luma Website`
	2. Customer Group: `All Customer Groups`
	3. Direction: `Points to Currency`
	4. Rate: `1 / 1`
4. Add a new rate for currency to points:
	1. Website: `Luma Website`
	2. Customer Group: `All Customer Groups`
	3. Direction: `Currency to Points`
	4. Rate: `1 / 1`

<a id="configure-related-products-display"></a>
#### Configure Related Products Display
By default, the related products display doesn't quite fit the theme cleanly. The maximum number of products shown in related products and cross-sells lists is 6 and upsells is 8.  Related products works better at 5 (a single row), cross-sells can stay at 6, and up-sells should match related products at 5 (one row).  To set these:

Navigate to `Stores > Settings > Configuration > Catalog > Catalog > Rule-Based Product Relations`

1. Maximum Number of Products in Related Products List: `5`
2. Maximum Number of Products in Cross-Sell Product List: `6`
3. Maximum Number of Products in Upsell Product List: `5`

When done, save the configuration and clear cache.

<a id="general-content-updates"></a>
### General Content Updates
In order for our meta changes to take effect, we need to add the same changes we made for the default meta information above to each home page (Luma and Venia respectively)

<a id="luma-home-page-us"></a>
#### Luma Home Page (US)

<a id="page-setup"></a>
##### Page Setup
Navigate to `Content > Elements > Pages > Home Page`

1. Page Title: `Luma Home Page - US`
2. Content Heading: `None`
2. Search Engine Optimization:
	1. URL Key: `home`
	2. Meta Title: `LUMA Official Online Store`
	3. Meta Keywords: `yoga,exercise,apparel,clothing,working out,fitness`
	4. Meta Description: `With more than 230 stores spanning 43 states and growing, Luma is a nationally recognized active wear manufacturer and retailer. We’re passionate about active lifestyles – and it goes way beyond apparel.`
3. Page in Websites: `Luma Website > Luma Store > US English`
4. Layout: `Page -- Full Width`

<a id="page-builder-content"></a>
##### Page Builder Content
By default, the home page content is contained within blocks which are then placed onto the home page itself using a widget.  This approach has pros and cons, but in general, it violates the reason content is generally split into blocks: easy reuse.  The content is not reused anywhere else and so, ought not to need block approach; however, the CSS has been written specifically to refer to a widget and thus, it would take more effort than I want to spend to "fix" it properly.  Thus, we'll continue to use the block content method and use page builder to drive the content.

1. **Row 1:**
	1. Appearance: `Full Width`
	2. Background > Background Color: `None`
	3. Background > Background Image: `home-main.jpg`
	4. Background > Background Size: `Cover`
	5. Background > Background Position: `Top Left`
	6. Background > Background Attachment: `Scroll`
	7. Background > Background Repeat: `No`
	8. Paralax > Enable Paralax Background: `No`
	9. Layout > Minimum Height: `600px`
	10. Layout > Vertical Alignment: `Top`
	11. Advanced > Alignment: `Default`
	12. Margins and Padding:
		1. Top Margin: `0`
		2. Right Margin: `0`
		3. Bottom Margin: `10px`
		4. Left Margin: `0`
		5. Top Padding: `10px`
		6. Right Padding: `10px`
		7. Bottom Padding: `10px`
		8. Left Padding: `10px`

2. Next, add a column to the top row so that the row splits into two columns.

3. **Row 1 > Right Column:**
	1. Grid Size: `6/12`
	2. Appearance: `Centered`
	3. Background > Background Color: `rgba(255, 255, 255, 0.9)`
	4. Background > Background Image: `None`
	5. Background > Background Size: `Cover`
	6. Background > Background Position: `Top Left`
	7. Background > Background Attachment: `Scroll`
	8. Background > Background Repeat: `No`
	9. Paralax > Enable Paralax Background: `No`
	10. Layout > Minimum Height: `None`
	11. Layout > Vertical Alignment: `Top`
	12. Advanced > Alignment: `Default`
	13. Margins and Padding:
		1. Top Margin: `20px`
		2. Right Margin: `20px`
		3. Bottom Margin: `0`
		4. Left Margin: `0`
		5. Top Padding: `10px`
		6. Right Padding: `20px`
		7. Bottom Padding: `10px`
		8. Left Padding: `20px`

4. Inside the right column, add a text area.

5. **Row 1 > Right Column > Textarea:**
	1. Content Line 1:
		1. Format: `Heading 2`
		2. Font Size: `26px`
		3. Line Height: `Line Height`
		4. Text: `New Luma Yoga Collection`
	2. Content Line 2:
		1. Format: `Heading 2`
		2. Font Size: `36px`
		3. Line Height: `Line Height`
		4. Text: `Get fit and look fabulous in new seasonal styles`
	3. Advanced > Alignment: `Default`
	4. Advanced > Margins and Padding:
		1. Top Margin: `0`
		2. Right Margin: `0`
		3. Bottom Margin: `0`
		4. Left Margin: `0`
		5. Top Padding: `0`
		6. Right Padding: `0`
		7. Bottom Padding: `0`
		8. Left Padding: `0`

6. Next, inside the right column, add a button element.

**Note:** Individual buttons are wrapped in a `Buttons` element -- think of it like settings for the group of buttons as whole.

7. **Row 1 > Right Column > Buttons:**
	1. Appearance: `Inline`
	2. Appearance > All Buttons are same size: `No`
	3. Advanced > Alignment: `Default`
	4. Advanced > Margins and Padding:
		1. Top Margin: `0`
		2. Right Margin: `0`
		3. Bottom Margin: `0`
		4. Left Margin: `0`
		5. Top Padding: `10px`
		6. Right Padding: `10px`
		7. Bottom Padding: `0`
		8. Left Padding: `0`

8. **Row 1 > Right Column > Buttons > Button:** 
	1. Content > Text: `Shop New Yoga`
	2. Content > Button Type: `Primary`
	3. Content > Button Link: `Category` -- `What's New` (Do not open in a new tab)
	4. Advanced > Alignment: `Center`

10. Duplicate the first row and remove right column.

11. **Row 2:**
	1. Background Image: `None`
	2. Layout > Minimum Height: `None`
	3. Advanced > Margins and Padding:
		1. Top Margin: `10px`
		2. Right Margin: `0`
		3. Bottom Margin: `10px`
		4. Left Margin: `0`
		5. Top Padding: `10px`
		6. Right Padding: `10px`
		7. Bottom Padding: `10px`
		8. Left Padding: `10px`

12. **Row 2 > Left Column:**
	1. Grid Size: `4/12`
	2. Appearance: `Centered`
	3. Background Color: `None`
	4. Background Image: `hp-guy-left.jpg`
	5. Background Size: `Cover`
	6. Background Position: `Top Left`
	7. Background Attachment: `Scroll`
	8. Background Repeat: `No`
	9. Paralax > Enable Paralax Background: `No`
	10. Layout > Minimum Height: `350px`
	11. Layout > Vertical Alignment: `Center`
	12. Advanced > Alignment: `Right`
	13. Margins and Padding:
		1. Top Margin: `10px`
		2. Right Margin: `10px`
		3. Bottom Margin: `10px`
		4. Left Margin: `10px`
		5. Top Padding: `20px`
		6. Right Padding: `20px`
		7. Bottom Padding: `20px`
		8. Left Padding: `20px`

13. Inside the Left Column, add a text area.

14. **Row 2 > Left Column > Textarea:**
	1. Content Line 1:
		1. Format: `Heading 2`
		2. Font Size: `36px`
		3. Line Height: `Line Height`
		4. Text: `20% Off`
		5. Color: `White`
	2. Content Line 2:
		1. Format: `Heading 2`
		2. Font Size: `26px`
		3. Line Height: `Line Height`
		4. Text: `Luma hoodies when you shop today`
		5. Color: `White`
	3. Advanced > Alignment: `Default`
	4. Advanced > Margins and Padding:
		1. Top Margin: `0`
		2. Right Margin: `0`
		3. Bottom Margin: `0`
		4. Left Margin: `0`
		5. Top Padding: `0`
		6. Right Padding: `0`
		7. Bottom Padding: `0`
		8. Left Padding: `0`

15. Duplicate the left column.

16. **Row 2 > Center Column:**
	1. Background Image: `hp-erin-center.jpg`
	2. Advanced > Alignment: `Left`

17. **Row 2 > Center Column > Textarea:**
	1. Content Line 1: 
		1. Text: `Take it from Erin`
		2. Color: `Black`
	2. Content Line 2:
		1. Text: `Luma founder Erin Renney shares her favorites`
		2. Color: `Black`

18. Duplicate the center column.

19. **Row 2 > Right Column:**

	1. Background Image: `hp-girl-right.jpg`
	2. Advanced > Alignment: `Right`

20. **Row 2 > Right Column > Textarea:**
	1. Content Line 1: 
		1. Text: `All Shirts`
		2. Color: `Black`
	2. Content Line 2:
		1. Text: `Buy 3 Luma tees and get a 4th free`
		2. Color: `Black`

21. Duplicate the first row and drag it beneath the second row.

22. **Row 3:**
	1. Background Image: `hp-woman-on-fence.jpg`
	2. Advanced > Margins and Padding:
		1. Top Margin: `10px`

23. **Row 3 > Right Column > Textarea:**
	1. Content Line 1: 
		1. Text: `Twice around, twice as nice`
	2. Content Line 2:
		1. Text: `Find conscientious, comfy clothing in our eco-friendly collection`

24. **Row 3 > Right Column > Buttons > Button:** 
	1. Content > Text: `Shop the Collection`

25. **Row 4**
	1. Appearance: `Full Width`
	2. Background > Background Color: `None`
	3. Background > Background Image: `None`
	4. Background > Background Size: `Cover`
	5. Background > Background Position: `Top Left`
	6. Background > Background Attachment: `Scroll`
	7. Background > Background Repeat: `No`
	8. Paralax Background > Enable Paralax Background > `No`
	9. Layout > Minimum Height: `None`
	10. Layout > Vertical Alignment: `Top`
	11. Advanced > Alignment: `Default`
	12. Advanced > Margins and Padding:
		1. Top Margin: `10px`
		2. Right Margin: `0`
		3. Bottom Margin: `10px`
		4. Left Margin: `0`
		5. Top Padding: `10px`
		6. Right Padding: `10px`
		7. Bottom Padding: `10px`
		8. Left Padding: `10px`

26. Save the block (we'll add more to it later).

<a id="luma-home-page-de"></a>
#### Luma Home Page (DE)

<a id="page-setup-1"></a>
##### Page Setup
Navigate to `Content > Elements > Pages > Home Page`

1. Page Title: `Luma Home Page - DE`
2. Search Engine Optimization:
	1. URL Key: `home`
	2. Meta Title: `Offizieller LUMA Online-Shop`
	3. Meta Keywords: `yoga,sport,bekleidung,kleidung,training,fitness`
	4. Meta Description: `Luma ist ein landesweit anerkannter Hersteller und Händler von Sportbekleidung mit über 230 Filialen in 43 Bundesstaaten. Ein aktiver Lebensstil ist unsere Leidenschaft – und das längst nicht nur in puncto Kleidung.`
3. Page in Websites: `Luma Website > Luma Store > Deutsch`

<a id="page-builder-content-1"></a>
##### Page Builder Content
Next, re-create the `Luma Home Page (US)` above (or delete the existing DE block and duplicate `Luma Home Page (US)`) and make the following updates:

1. **Row 1 > Right Column > Textarea:**
	1. Content Line 1:
		1. Text: `Neue Yoga Kollektion`
	2. Content Line 2:
		1. Text: `Ab jetzt bedeutet Mode immer auch Komfort`

2. **Row 1 > Right Column > Buttons > Button:** 
	1. Content > Text: `In Neue Yoga Stöbern`

3. **Row 2 > Left Column > Textarea:**
	1. Content Line 1:
		1. Text: `20% Rabatt`
	2. Content Line 2:
		2. Text: `Luma Hoodies, wenn Sie heute einkaufen`

4. **Row 2 > Center Column > Textarea:**
	1. Content Line 1: 
		1. Text: `Hören Sie von Erin`
	2. Content Line 2:
		1. Text: `Luma-Gründerin Erin Renney teilt ihre Favoriten`

5. **Row 2 > Right Column > Textarea:**
	1. Content Line 1: 
		1. Text: `Alle Hemden`
	2. Content Line 2:
		1. Text: `Kaufe 3 Tees und erhalte einen vierten gratis`

6. **Row 3 > Right Column > Textarea:**
	1. Content Line 1: 
		1. Text: `Zweimal herum, doppelt so schön`
	2. Content Line 2:
		1. Text: `Schauen Sie sich unsere gewissenhafte, komfortable und umweltfreundliche Kollektion an`

7. **Row 3 > Right Column > Buttons > Button:** 
	1. Content > Text: `Kaufen Sie die Kollektion`

<a id="venia-home-page"></a>
#### Venia Home Page

<a id="page-setup-2"></a>
##### Page Setup
Navigate to `Content > Elements > Pages > Home Page - Venia`

1. Page Title: `Venia Home Page - US`
2. Search Engine Optimization:
	1. URL Key: `home`
	2. Meta Title: `VENIA Official Online Store`
	3. Meta Keywords: `fashion,women,blouse,top,pant,dress,venia`
	4. Meta Description: `With 50 stores spanning 40 states and growing, Venia is a nationally recognized high fashion retailer for women. We’re passionate about helping you look your best.`
3. Page in Websites: `Luma Website > Luma Store > US English` 

<a id="attribute-set-updates"></a>
### Attribute Set Updates
<a id="short-description-and-description-arrangement"></a>
#### Short Description and Description Arrangement
Since every second counts when creating a custom demo, we'll make some adjustments to our attribute arrangement so as to make product creation flow smoother when creating custom products.

The main change here is to rearrange the `short description` and `description` fields in each attribute set, since, usually, if a product has a short description, it is shown *before* the long description (as logic would dictate).  For some reason, Magento doesn't follow this logic natively; the `description` field is listed *before* the `short description` field. Let's change that:

Navigate to `Stores > Attributes > Attribute Set`

1. Start with the `Default` attribute set
2. In the `Content` attribute group, drag the `short description` attribute so that it's positioned above the `description` attribute
3. Save the change

Repeat this for all other attribute sets.

<a id="sale-and-new-attributes"></a>
#### Sale and New Attributes
Next, we'll follow a similar process for the `sale` and `new` attribute so that we can use them for some marketing use cases to follow.  By default, the `sale` and `new` attributes do not apply to all attribute sets.  This limits their use for all products and, thus, prevents us from applying them to large numbers of products via mass actions.  Let's make sure `Sale` and `New` are added to all attribute sets:

1. Start with the `Default` attribute set
2. Drag the `new` attribute into the `Product Details` attribute group, beneath the `badge` attribute
3. Drag the `sale` attribute into the `Product Details` attribute group, beneath the `new` attribute
4. Save the change

Repeat this for all other attribute sets.

<a id="customer-configuration"></a>
### Customer Configuration
<a id="redirect-to-my-account"></a>
#### Redirect to My Account
Natively, when a customer logs in, they are redirected to the same page they were on when they triggered the log in action.  While this can be handy, typically, when logging in, our goal is to show the My Account area.  We can configure Magento to redirect a customer to their My Account area using the setting at:

`Stores > Settings > Configuration > Customers > Customer Configuration > Login Options`

Redirect Customer to Account Dashboard after Logging in: `Yes`

After saving, refresh cache.

<a id="set-up-saved-cards"></a>
#### Set Up Saved Cards
In order to show Instant Purchase, customers will need to have a Saved Card attached to their account.  We'll add one now for Sharon Reynolds.  As Sharon, create an order with the *Push It Messenger Bag*.  At checkout, use the following details:

1. Credit Card
2. CC Number: `4111111111111111`
3. Expiration Date: `01/23`
4. Card Verification Number: `123`
5. Save for later use: `Yes`

Optional: Once you've placed the order, sign out as Sharon.  Next, fufill the order on the backend (create an invoice and a shipment with a shipping label).  Then, find *Push It Messenger Bag* and add back the quantity you purchased.

*Optional*: Add a saved card for Mark and Lisa if you wish.

**Note**: If you need to place orders without an internet connection, remember to disable all API-driven payment methods.  (This would include Braintree and PayPal).  Check or Money Order should be enabled by default for you.

<a id="set-up-a-custom-brand"></a>
### Set Up A Custom Brand
In order to make creating custom demos easier, we'll set up some base elements which SCs will use to create customized demos.

<a id="custom-catalog-store-and-store-view"></a>
#### Custom Catalog, Store, and Store View
When preparing a custom demo, it's typically a good practice to separate the native Luma sample data and its associated demo use cases from custom use cases used to give a custom demo.  To allow for this, we've included a custom module which has installed a separate store, store view, and root category for a custom catalog.

<a id="custom-attribute-set"></a>
#### Custom Attribute Set
Next, in the same vein of keeping custom demo cases separated from Luma ones, we'll create a `Custom` attribute set and attribute set group.  This will allow us to place our custom attributes created for custom products into a distinct attribute set and group which allows us to easily create grid filters and rules as well as to quickly create products via the admin panel given that all of our custom attributes will be grouped together in a logical arrangement.

Navigate to `Stores > Attributes > Attribute Set` and add a new attribute set:

1. Name: `Custom`
2. Based On: `Default`

Next, create a new Attribute Group in the `Custom` attribute set.  When you create it, the group will appear at the bottom of the set.

3. Drag the `Custom` folder up in the list  (Typically, when creating new products in the admin, your custom attributes will be listed *after* basics like description)

<a id="custom-home-page"></a>
#### Custom Home Page
To make custom demos easier, we'll create a custom home page and connect it with our custom store view:

Navigate to `Content > Elements > Pages` and add a new page:

1. Page Title: `Custom Home Page`
2. Search Engine Optimization:
	1. URL Key: `home`
	2. Meta Title: `Custom Official Online Store`
	3. Meta Keywords: `custom,keywords`
	4. Meta Description: `Custom description goes here.`
3. Page in Websites: `Luma Website > Custom Store > Custom US English`
4. Layout: `Page -- Full Width`

When done, refresh the cache.

<a id="custom-site-map"></a>
#### Custom Site Map
Navigate to `Marketing > SEO and Search > Site Map` and create the following:

1. Custom
	1. Filename: `custom.xml`
	2. Path: `/pub/`
	3. Store View: `Luma Website > Custom Store > Custom US English`

<a id="custom-theme-skin-via-sc-theme-customizer"></a>
#### Custom Theme Skin via SC Theme Customizer
The theme customizer is an extension that attaches a CSS-based skin to an existing theme.  It ships with a collection of base skins that an SC can duplicate, customize, and then apply to a custom theme in order to apply a custom look and feel.  The VM ships with a Custom theme specifically for this purpose.  Unfortunately, the "Luma" skin does not fully map to all the necessary styles in the theme and requires the SC to add additional CSS hooks to control the look and feel.

Next, let's create a Luma skin based on the included one and update it with the right CSS to be more complete.  Then, we'll attach it to the included custom theme which is assigned to our custom store view.

Navigate to `SC Tools > SC Tools > Theme Customizer`

1. Find the `Luma Theme Template` in the grid and click `Duplicate`

Next, use the following settings:

1. Name: `Custom Theme Template (Luma)`
2. Apply To Theme: `Blank Custom Theme`
3. Top Bar Color: `#666567`
4. Primary Link Color: `#006bb4`
5. Nav Background Color: `#f0f0f0`
6. Nav Link Color: `#f0f0f0`
7. Button Background Color:`#eeeeee`

In the *Additional CSS* section, paste the following CSS:

```
/* Buttons */
.action.primary,
.actions-toolbar>.primary .action:last-child, 
.actions-toolbar>.secondary .action:last-child {
    background-color:; 
    border-color:; 
    color: white !important;
}
.action.primary:hover,
.action.primary:active,
.action.primary:focus,
.action.primary:visited {
    background-color:; 
    border-color:;
    color: white !important;
}
/* Nav Links */
.navigation ul li a, 
.navigation ul li a:visited { 
    color: #575757 !important;
} 
.navigation .level0.active>.level-top,
.navigation .level0.has-active>.level-top,
.navigation .level0 .submenu .active>a,
.block-collapsible-nav .item.current a,
.block-collapsible-nav .item.current>strong.fotorama__thumb-border { 
    border-color:;
}
/* Main Nav Bar (Navigation Container - Outside Edges) */
.nav-sections, 
.navigation, 
.nav-sections-item-content {
    background-color:;
}
/* Center Nav Bar (Links) */
nav.navigation {
    background-color:;
}
/* Header Bar */
.page-header .header.panel,
.page-header .panel.wrapper { 
    background-color:;
    border:;
}
/* Header Panel */
.page-header {
    background-color: white !important;
}
/* Sign in and Create Account Links */
.header.panel > .header.links > li.welcome,
.header.panel > .header.links > li > a {
    color: white !important;
}
/* Header Text */
ul.header.links {
    color: white !important;
}
/* My Account Dropdown Links */
.customer-welcome li a,
.customer-welcome li a:visited {
    color: #575757 !important;
}
/* Arrow Next To Logged-In Customer's Name */
.customer-welcome .action.switch:after {
    color: white;
}
/* Language and Currency Switchers */
.page-header .switcher strong, 
.page-footer .switcher strong, 
.page-header .switcher .options .action.toggle, 
.page-footer .switcher .options .action.toggle {
    color: white !important;
}
/* Mini Cart Icon */
.minicart-wrapper .action.showcart:before {
    color: #757575 !important;
}
/* Mini Cart Items Count (Orange) */
.minicart-wrapper .action.showcart .counter.qty {
	background: #ff5501;
	color: #ffffff;
}
/* My Account Sidebar Links */
.block-collapsible-nav .item a,
.block-collapsible-nav .item>strong {
    color: #575757 !important;
}
/* In Store Pickup Link */
.catalog-product-view .instorepickup-pdp-wrapper .instorepickup-change-trigger {
    color:;
}
/* B2B-specific My Account Links */
.form-edit-role .box-actions button.action, 
.block-dashboard-company .box-actions button.action, 
.form-edit-role .box-actions .quote-details-items .actions-toolbar>.action.action, 
.block-dashboard-company .box-actions .quote-details-items .actions-toolbar>.action.action {
	color: #1979c3;
}
/* Footer Links */
ul.footer.links > li > a,
.page-footer .switcher .options .action.toggle,
.page-footer .switcher .options ul.dropdown a,
.page-footer .switcher .options ul.dropdown a:visited { 
    color: #575757 !important;
}
/* Photo Gallery Outlines */
.fotorama__thumb-border { 
    border-color:;
}
/* Swatch Borders */
.swatch-option.image:not(.disabled):hover,
.swatch-option.color:not(.disabled):hover,
.swatch-option.selected { 
    outline:; 
}
/* Checkout Styles */
.opc-progress-bar-item._active:before,
.opc-progress-bar-item._active>span:before {
	background:;
	border-color:;
}
.opc-progress-bar-item._active>span:after,
.opc-wrapper .shipping-address-item.selected-item {
	border-color:;
}
.opc-wrapper .shipping-address-item.selected-item:after {
	background:;
	color:;
}

/* Page Builder Styles */

/* Page Builder Primary Buttons */
a.pagebuilder-button-primary, 
button.pagebuilder-button-primary, 
div.pagebuilder-button-primary {
	background:;
	border:;
	color:;
}
a.pagebuilder-button-primary:hover,
button.pagebuilder-button-primary:hover,
div.pagebuilder-button-primary:hover {
	background:;
	border:;
	color:;
}
/* Page Builder Secondary Buttons */
a.pagebuilder-button-secondary,
button.pagebuilder-button-secondary,
div.pagebuilder-button-secondary {
	background:;
	border:;
	color:;
}
a.pagebuilder-button-secondary:hover,
button.pagebuilder-button-secondary:hover,
div.pagebuilder-button-secondary:hover {
	background:;
	border:;
	color:;
}
/* Page Builder Buttons as Links */
a.pagebuilder-button-link,
button.pagebuilder-button-link,
div.pagebuilder-button-link { 
	color: #006bb4 !important;
	text-decoration:;
}
a.pagebuilder-button-link:hover,
button.pagebuilder-button-link:hover,
div.pagebuilder-button-link:hover {
	color:;
	text-decoration:;
}
/* Page Builder Slider Dots */
.slick-dots li.slick-active button { 
	background: #006bb4 !important; 
}
/* Page Builder Slider Arrows */
.slick-prev:before,
.slick-next:before,
.slick-prev:after,
.slick-next:after { 
	color: #006bb4 !important; 
}
```
<a id="products"></a>
### Products

<a id="re-arrange-gear--bags-category"></a>
#### Re-arrange Gear > Bags Category
We like to show the joust duffle bag during our demos, but for some reason it's shown at the bottom of the category even though its listed as the first product in the category.  Let's shove it to the top:

Navigate to `Catalog > Categories > Luma Catalog > Gear > Bags`

1. Expand the `Products in Category` section
2. Swap `Joust Duffle Bag` with `Strive Shoulder Pack`
3. Save
4. Repeat steps 1 and 2 so that `Joust Duffle Bag` is listed first again
5. Save

Once saved, reindex and clear cache with `clean`

<a id="re-arrange-the-womens--hoodies-and-sweatshirts-category"></a>
#### Re-arrange the Womens > Hoodies and Sweatshirts Category
We like to show the Mona Pullover Hoodie during our demos but it's at the bottom of the category.  Let's shove it to the top:

Navigate to `Catalog > Categories > Luma Catalog > Women > Tops > Hoodies & Sweatshirts`

1. Expand the `Products in Category` section
2. Find the `Mona Pullover Hoodie` configurable product (Visible in catalog and search)
3. Change its position number to `0`
3. Save

Once saved, reindex and clear cache with `clean`

<a id="add-running-as-an-attribute-to-select-products"></a>
#### Add Running As An Attribute to Select Products
Since one of our segments is for customers whose favorite activity is Running, we'll need to select some products and update their `Activity` attribute to contain a value of `Running`.  We'll do a combination of tops and bottoms. To do this:

Navigate to `Catalog > Products`

First, the tops:

1. Filter the grid for:
	1. Keyword: `Running`
	2. Type: `Configurable Product`
	3. Attribute Set: `Top`
2. Mass edit the `Atomic Endurance Running Tee (V-neck)` and the `Ingrid Running Jacket`
3. Update the `Activity` attribute to include `Running`
4. Save

Next, the bottoms:

1. Filter the grid for:
	1. Keyword: `Running`
	2. Type: `Configurable Product`
	3. Attribute Set: `Bottom`
2. Mass edit the `Apollo Running Short`, `Cora Parachute Pant`, and the `Erika Running Short`
3. Update the `Activity` attribute to include `Running`
4. Save


<a id="add-stock-for-mailed-gift-card"></a>
#### Add Stock for Mailed Gift Card
For whatever reason, the gift card products show as not having stock because they have no amounts configured and Open Amounts are set to `No`.  Let's fix this by allowing an open amount from $25 - $200:

Navigate to `Catalog > Products`

1. Filter on `Product Type: Gift Card`
2. Select the Mailed Gift Card
3. Open Amount: `Yes`
4. Open Amount From: `25`
5. Open Amount To: `200`

<a id="remove-manual-up-sells-from-cronus-yoga-pant"></a>
#### Remove Manual Up-sells from Cronus Yoga Pant
One of our customer segments revolves around men who purchase pants.  This segment is designed to feature the *Cronus Yoga Pant* and shows a change in related products rules when logged in as a member of that segment.  Natively, the product has some manually configured up-sells which, when shown as part of the demo scenario, make the change in segment less effective.  To address this, we'll remove the manually-assigned up-sell products from the *Cronus Yoga Pant* configurable product.

<a id="marketing"></a>
### Marketing

<a id="featured-products-on-home-page"></a>
#### Featured Products on Home Page
The goal of this addition is to use a "Featured Product" attribute together with the Visual Merchandiser rules to populate a hidden *Featured Products* category in order to display products on the home page.  We'll show five products so that we fit with the design, and we'll use this product list to show off 5 of Magento's 7 product types.

Navigate to `Catalog > Categories > Luma Catalog > Promotions`

1. Add a new subcategory:
	1. Enable Category: `Yes`
	2. Include in Menu: `No`
	3. Category Name: `Featured Products`
	
Next, we can use a "Featured Products" to mark the products we want to include in the category:

Navigate to `Stores > Attributes > Product` and add a new attribute:

1. Attribute Properties > Default Label: `Featured Product`
2. Attribute Properties > Catalog Input Type for Store Owner: `Yes/No`
3. Attribute Properties > Values Required: `No`
4. Attribute Properties > Attribute Code: `featured_product`
5. Advanced Attribute Properties > Scope: `Store View`
6. Storefront Properties > Use in Search: `No`
7. Storefront Properties > Comparable on Storefront: `No`
8. Storefront Properties > Use for Promo Rule Conditions: `Yes`
9. Storefront Properties > Visible on Catalog Pages on Storefront: `No`
10. Storefront Properties > Used in Product Listing: `No`
11. Used for Sorting in Product Listing: `No`

With the attribute created, we now need to add it to all of our attribute sets (in case we want to use it with any existing product in the future):

Navigate to `Stores > Attributes > Attribute Set` and add a new attribute set:
	
1. Select the `Bag` attribute set from the grid
2. Add the `luma_featured_product` attribute to the `Product Details` attribute group under the `sale` attribute
3. Save the change

Repeat for all attribtue sets and then refresh the cache.

Once the attribute is created, we'll go ahead and make sure we can use it via Visual Merchandiser so we can populate our Featured Products category dynamically:

Navigate to `Stores > Settings > Configuration > Catalog > Visual Merchandiser`

1. Find the `Featured Product` attribute in the `Visible Attributes for Category Rules` multi-select
2. Hold `Command` (Mac) to maintain the attributes which are already selected and click the `Featured Product` attribute to add it
3. Save the change

Refresh the cache when done.

Next, we'll assign our `Featured Product` attribute to the products we want to feature. You can use the Filter and the `Update Attributes` Mass Actions to assign the Featured Product attribute value to the following SKUs:

1. SKU: `24-MB01` (Joust Duffle Bag)
2. SKU: `24-WG080` (Sprite Yoga Companion Kit)
3. SKU: `24-WG085_Group` (Set of Sprite Yoga Straps)
4. SKU: `243-MB04` (Luma Mailed Gift Card)
5. SKU: `WH01` (Mona Pullover Hoodie)

**Note**: If you don't see the `Featured Product` attribute at the bottom of the mass action list, it most likely means the attribute hasn't been added to the product's attribute set.

Next, we'll populate our Featured Products category using a Visual Merchandiser rule:

Navigate to `Catalog > Categories > Luma Catalog > Promotions > Featured Products`

1. Products in Category:
	1. Match products by rule: `Yes`
	2. Click `Add Condition`
		1. Attribute: `Featured Product`
		2. Operator: `Equal`
		3. Value: `Yes`
2. Save the category

Once saved, verify the products have been added to the category as shown above.

<a id="sale-category"></a>
#### Sale Category
In an ideal world, category permissions and staging and preview would work well together.  In reality (as of 2.3.0), they don't.  As soon as Category Permissions are enabled, the top navigation disappears from all staging previews.  This is slated to be fixed in 2.3.1, so we'll include instructions here on how to show a *B2C* example of a custom catalog.  Our goal here is to only show the Sale category to our VIP customers.

By default, category permissions are disabled, so we'll start by enabling them.

Navigate to `Stores > Settings > Configuration > Catalog > Catalog > Category Permissions`

1. Enable: `Yes`
2. Allow Browsing Category: `Yes, for Everyone`
3. Display Product Prices: `Yes, for Everyone`
4. Allow Adding to Cart: `Yes, for Everyone`
5. Save the changes

Reindex and refresh the cache with the `clean` command.

Next, we'll apply permissions specifically to the Sale category:

Navigate to `Catalog > Categories > Sale`

1. Expand the `Category Permissions` panel
2. Add a new permission:
	1. Website: `Luma Website`
	2. Customer Group: `All Groups`
	3. Allow Browsing Category: `Deny`
	4. Display Product Prices: `Deny`
	5. Allow Adding to Cart: `Deny`
3. Add a second permission:
	1. Website: `Luma Website`
	2. Customer Group: `VIP`
	3. Allow Browsing Category: `Allow`
	4. Display Product Prices: `Allow`
	5. Allow Adding to Cart: `Allow`

Save the category and then reindex and refresh the cache with the `clean` command.

<a id="customer-segments"></a>
#### Customer Segments

<a id="luma-guest-customers"></a>
##### Luma Guest Customers
We'll use this segment to show targeted content to guest customers as opposed to those with accounts.

Navigate to: `Customers > Customer Segments > Add Segment`

1. General Properties > Segment Name: `LUMA Guest Customers`
2. General Properties > Assigned to Website: `Luma Website`
3. General Properties > Status: `Active`
4. General Properties > Apply To: `Visitors`
5. Save

Once saved, use the `clean` command to reindex and refresh cache.

<a id="luma-registered-customers"></a>
##### Luma Registered Customers
We'll use this segment to show targeted content to registered customers as opposed to guest customers.

Navigate to: `Customers > Customer Segments > Add Segment`

1. General Properties > Segment Name: `LUMA Registered Customers`
2. General Properties > Assigned to Website: `Luma Website`
3. General Properties > Status: `Active`
4. General Properties > Apply To: `Registered Customers`
5. Save the segment

Once saved, use the `clean` command to reindex and refresh cache.

<a id="luma-rewards"></a>
##### LUMA Rewards
We'll use the following segments to create a simple Rewards program with tiers based on a customer's total sales amount.

<a id="bronze-tier"></a>
###### Bronze Tier
Navigate to: `Customers > Customer Segments > Add Segment`

1. General Properties > Segment Name: `LUMA Rewards - Bronze ($250 - $500)`
2. General Properties > Assigned to Website: `Luma Website`
3. General Properties > Status: `Active`
4. General Properties > Apply To: `Registered Customers`
5. Save and Continue
6. Conditions:
	1. If **ALL** of these conditions are **TRUE**:
		1. **Total** Sales Amount **equals or greater than** **250** while **ALL** of these Conditions match:
		2. **Total** Sales Amount **equals or less than** **500** while **ALL** of these Conditions match:
7. Save the segment

Once saved, use the `clean` command to reindex and refresh cache.

<a id="silver-tier"></a>
###### Silver Tier
Navigate to: `Customers > Customer Segments > Add Segment`

1. General Properties > Segment Name: `LUMA Rewards - Silver ($500 - $1000)`
2. General Properties > Assigned to Website: `Luma Website`
3. General Properties > Status: `Active`
4. General Properties > Apply To: `Registered Customers`
5. Save and Continue
6. Conditions:
	1. If **ALL** of these conditions are **TRUE**:
		1. **Total** Sales Amount **equals or greater than** **500** while **ALL** of these Conditions match:
		2. **Total** Sales Amount **equals or less than** **1000** while **ALL** of these Conditions match:
7. Save the segment

Once saved, use the `clean` command to reindex and refresh cache.

<a id="gold-tier"></a>
###### Gold Tier
Navigate to: `Customers > Customer Segments > Add Segment`

1. General Properties > Segment Name: `LUMA Rewards - Bronze ($1000 - $2000)`
2. General Properties > Assigned to Website: `Luma Website`
3. General Properties > Status: `Active`
4. General Properties > Apply To: `Registered Customers`
5. Save and Continue
6. Conditions:
	1. If **ALL** of these conditions are **TRUE**:
		1. **Total** Sales Amount **equals or greater than** **1000** while **ALL** of these Conditions match:
		2. **Total** Sales Amount **equals or less than** **2000** while **ALL** of these Conditions match:
7. Save the segment

Once saved, use the `clean` command to reindex and refresh cache.

<a id="platinum-tier"></a>
###### Platinum Tier
Navigate to: `Customers > Customer Segments > Add Segment`

1. General Properties > Segment Name: `LUMA Rewards - Platinum ($2000+)`
2. General Properties > Assigned to Website: `Luma Website`
3. General Properties > Status: `Active`
4. General Properties > Apply To: `Registered Customers`
5. Save and Continue
6. Conditions:
	1. If **ALL** of these conditions are **TRUE**:
		1. **Total** Sales Amount **equals or greater than** **2000** while **ALL** of these Conditions match:
7. Save the segment

Once saved, use the `clean` command to reindex and refresh cache.

<a id="purchase-history"></a>
##### Purchase History

<a id="apparel-purchased-in-the-last-week"></a>
###### Apparel Purchased in the Last Week
Navigate to: `Customers > Customer Segments > Add Segment`

1. General Properties > Segment Name: `Purchase History - Apparel Purchased in the Last Week`
2. General Properties > Assigned to Website: `Luma Website`
3. General Properties > Status: `Active`
4. General Properties > Apply To: `Registered Customers`
5. Save and Continue
6. Conditions:
	1. If **ALL** of these conditions are **TRUE**:
		1. If Product **was ordered** and matches **ANY** of these Conditions
			1. Product Attribute Set **is** **Top**
			2. Product Attribute Set **is** **Bottom**
		2. If Product **was ordered** and matches **ALL** of these Conditions
			1. Period **equals or less than** **7** days Up To Date
7. Save the segment

Once saved, use the `clean` command to reindex and refresh cache.

<a id="men-who-have-viewed-pants"></a>
###### Men Who Have Viewed Pants
Navigate to: `Customers > Customer Segments > Add Segment`

1. General Properties > Segment Name: `Purchase History - Men Who Have Viewed Pants`
2. General Properties > Assigned to Website: `Luma Website`
3. General Properties > Status: `Active`
4. General Properties > Apply To: `Registered Customers`
5. Save and Continue
6. Conditions:
	1. If **ALL** of these conditions are **TRUE**:
		1. If Customer Gender **is** **Male**
		2. If Product **was viewed** and matches **ALL** of these Conditions
			1. Product Category **is** **19**
7. Save the segment

Once saved, use the `clean` command to reindex and refresh cache.

Next, log in as **Mark Woodward** and view a pair of pants on the storefront.

Finally, back in the segment, click `Refresh Segment Data` to populate the segment.

<a id="vip-customers"></a>
###### VIP Customers
Navigate to: `Customers > Customer Segments > Add Segment`

1. General Properties > Segment Name: `Purchase History - VIP Customers`
2. General Properties > Assigned to Website: `Luma Website`
3. General Properties > Status: `Active`
4. General Properties > Apply To: `Registered Customers`
5. Save and Continue
6. Conditions:
	1. If **ANY** of these conditions are **TRUE**:
		1. **Total** Number of Orders **equals or greater than** **100** while **ANY** of these Conditions match:
			1. Order Status **is** **Complete**
			2. Order Status **is** **Processing**
		2. **Total** Sales Amount **equals or greater than** **10000** while **ALL** of these Conditions match:
		3. Customer Group **is** **VIP**
7. Save the segment

Once saved, use the `clean` command to reindex and refresh cache.

<a id="female-repeat-customers-neve-studio-dance-jacket"></a>
###### Female Repeat Customers (Neve Studio Dance Jacket)
Navigate to: `Customers > Customer Segments > Add Segment`

1. General Properties > Segment Name: `Purchase History - Female Repeat Customers (Neve Studio Dance Jacket)`
2. General Properties > Assigned to Website: `Luma Website`
3. General Properties > Status: `Active`
4. General Properties > Apply To: `Registered Customers`
5. Save and Continue
6. Conditions:
	1. If **ALL** of these conditions are **TRUE**:
		1. **Total** Number of Orders **is** **1** while **ALL** of these Conditions match:
		2. If Product **was** **ordered** and matches **ALL** of these Conditions:
			1. Product SKU **contains** **WJ11** 
7. Save the segment

We'll use **Lisa Firey** as our customer for this use case.  Unfortunately, she already has at least one order in the demo sales data, which means we'll need to delete her orders and place one to meet our segment criteria.  To do this, we'll install an extension from Mageplaza.

SSH into the VM via terminal with: `ssh vagrant@luma.com`.  If a password is requested, use `vagrant`

`www && add-key && composer require mageplaza/module-delete-orders && upgrade`

With the extension added, navigate to `Sales > Orders`

1. Filter the orders grid for Bill-to Name: `Lisa Firey`
2. Select the resultant orders and use mass actions to delete them
3. Clear the order filter

Next, we'll place an order as **Lisa Firey** for the **Neve Studio Dance Jacket**

1. On the storefront, log in as `Lisa Firey`
2. Navigate to `Women > Tops > Jackets`
3. Select a small, blue `Neve Studio Dance Jacket` and add to cart
4. Proceed to checkout and complete the purchase
5. Log out as `Lisa Firey`

Next, we'll verify that our segment is correct.

Navigate to `Customers > Customer Segments`

1. Choose the `Purchase History - Female Repeat Customers (Neve Studio Dance Jacket)` segment
2. Click `Refresh Segment Data`
3. Check that `Lisa Firey` is in the segment

Finally, we'll remove the Mageplaza Delete Orders extension we just used, making sure the remove data and clear static content in the process.

SSH into the VM via terminal with: `ssh vagrant@luma.com`.  If a password is requested, use `vagrant`

1. `./bin/magento module:uninstall --remove-data --clear-static-content Mageplaza_Core Mageplaza_DeleteOrders`
2. Enter `y` when prompted
3. `di-compile`
4. `clean`

Finally, clear the notifications left by the Mageplaza extensions.

<a id="customer-preference"></a>
##### Customer Preference
<a id="runners"></a>
###### Runners
For the Runners segment, we need to create a customer attribute.

Navigate to `Stores > Attributes > Customer` and add a new attribute:

1. Properties > Attribute Properties > Default Label: `Preferred Activities`
2. Properties > Attribute Properties > Attribute Code: `preferred_activities`
3. Properties > Attribute Properties > Input Type: `Mutiple Select`
4. Properties > Attribute Properties > Values Required: `No`
5. Properties > Attribute Properties > Add to Column Options: `Yes`
6. Properties > Attribute Properties > Use in Filter Options: `Yes`
7. Properties > Attribute Properties > Use in Search Options: `No`
8. Properties > Attribute Properties > Use in Customer Segment: `Yes`
9. Properties > Storefront Properties > Show on Storefront: `Yes`
10. Properties > Storefront Properties > Sort Order: `100`
11. Properties > Storefront Properties > Forms to Use In: `Customer Registration`, `Customer Account Edit`, `Admin Checkout`
12. Manage Label / Options > Manage Titles:
	1. Deutsch: `Bevorzugte Aktivitäten`
12. Manage Label / Options > Manage Options:
	1. Admin: `Running`, Deutsch: `Laufen`
	2. Admin: `Crossfit`
	3. Admin: `Pilates`
	4. Admin: `Yoga`
13. Save the attribute

Use `clean` to reindex and refresh the cache.

Next, we'll assign the attribute to **Mark Woodward**.

1. Log in to the storefront as `Mark Woodward`
2. Click on the name dropdown and choose `My Account`
3. Click on `Account Information`
4. Choose `Running` in the `Preferred Activities` multi-select
5. Save the selection

Next, we'll create the segment based on this preference.

Navigate to: `Customers > Customer Segments > Add Segment`

1. General Properties > Segment Name: `Customer Preference - Runners`
2. General Properties > Assigned to Website: `Luma Website`
3. General Properties > Status: `Active`
4. General Properties > Apply To: `Registered Customers`
5. Save and Continue
6. Conditions:
	1. If **ALL** of these conditions are **TRUE**:
		1. Customer Preferred Activities **contains** **Running**
7. Save the segment

Use `clean` to reindex and refresh the cache.

<a id="shopping-cart"></a>
##### Shopping Cart
<a id="free-shipping-threshold-75---99"></a>
###### Free Shipping Threshold ($75 - $99)
We'll set up a free shipping threshold between $75 - $99 so we can target those customers and alert them to the fact that if they spend $100 or more, they'll get free shipping:

Navigate to: `Customers > Customer Segments > Add Segment`

1. General Properties > Segment Name: `Shopping Cart - Free Shipping Threshold ($75 - $99)`
2. General Properties > Assigned to Website: `Luma Website`
3. General Properties > Status: `Active`
4. General Properties > Apply To: `Visitors and Registered Customers`
5. Save and Continue
6. Conditions:
	1. If **ALL** of these conditions are **TRUE**:
		1. Shopping Cart **Subtotal** Amount **equals or greater than** **$75**
		2. Shopping Cart **Subtotal** Amount **less than** **$100**
7. Save the segment

Use `clean` to reindex and refresh the cache.

Next we'll set up **Lisa Firery** so that she fits this segment:

1. Log in as Lisa
2. Add the following to the cart:
	1. `Cassia Funnel Sweatshirt x 1`
	2. `Affirm Water Bottle x 1`
	3. `Joust Duffel Bag x 1`
3. Refresh the above segment

<a id="related-products-rules"></a>
#### Related Products Rules

<a id="remove-unwanted-rules-and-configure-global-result-numbers"></a>
##### Remove Unwanted Rules and Configure Global Result Numbers
Although the included Related Products Rules help convey a fully-featured reference store, the sheer number of them can be overwhelming when trying to tell a succinct, effective demo story.  In addition, because there are so many of them, the risk of conflicting rules when creating new custom rules is quite high.  For that reason, we will remove all but the last five and then rework those rules into the ones we want.  This will preserve the ID numbering if we choose to create new, custom rules.

Navigate to `Marketing > Related Products Rules`

Remove rules 1-40

Next, we'll update our global configuration for how many cross-sell results to return for cross-sell rules.  For some reason, the default is set to 5 when the design has room for 6.

Navigate to `Stores > Settings > Configuration > Catalog > Catalog > Rule-based Product Relations`

Maximum Number of Products in Cross-Sell Product List: `6`

<a id="womens-hoodies-to-womens-pants-related-products"></a>
##### Women’s Hoodies to Women's Pants (Related Products)
Navigate to `Marketing > Related Products Rules`

Reconfigure Rule ID 41: Cross-sells Women Bottoms Pants to match the following:

1. Rule Information > Rule Name: `Related Products - Women's Hoodies to Women's Pants`
2. Rule Information > Apply To: `Related Products`
3. Rule Information > Status: `Active`
4. Rule Information > Customer Segments: `All`
5. Products to Match:
	1. If **ALL** of these conditions are **TRUE**:
		1. Category **is** **25**
6. Products to Display:
	1. If **ALL** of these conditions are **TRUE**:
		1. Product Category **is** **Constant Value** **28**
7. Save changes

<a id="mens-pants-to-mens-hoodies-segmented-related-products"></a>
##### Men's Pants to Men's Hoodies (Segmented) (Related Products)
Navigate to `Marketing > Related Products Rules`

Reconfigure Rule ID 42: Cross-sells Men Top Tees to match the following:

1. Rule Information > Rule Name: `Related Products - Men's Pants to Men's Hoodies (Segmented)`
2. Rule Information > Apply To: `Related Products`
3. Rule Information > Status: `Active`
4. Rule Information > Customer Segments: `Specified`
	1. `Purchase History - Men Who Have Viewed Pants`
5. Products to Match:
	1. If **ALL** of these conditions are **TRUE**:
		1. Category **is** **19**
6. Products to Display:
	1. If **ALL** of these conditions are **TRUE**:
		1. Product Category **is** **Constant Value** **16**
7. Save changes

<a id="watch-upsells"></a>
##### Watch Upsells
In order to create this rule, we need to configure the `Price` attribute so that it can be used in the rule engine.

Navigate to `Stores > Attributes > Product`

1. Open the `Price` attribute
2. Storefront Properties > Use for Promo Rule Conditions: `Yes`
3. Reset the attribute grid filter if you used one
4. Save changes

When done, refresh the cache.

Navigate to `Marketing > Related Products Rules`

Next, reconfigure Rule ID 43: Cross-sells Men Bottoms Pants to match the following:

1. Rule Information > Rule Name: `Up-sells - Watches`
2. Rule Information > Apply To: `Up-sells`
3. Rule Information > Status: `Active`
4. Rule Information > Customer Segments: `All`
5. Products to Match:
	1. If **ALL** of these conditions are **TRUE**:
		1. Category **is** **6**
6. Products to Display:
	1. If **ALL** of these conditions are **TRUE**:
		1. Product Category **is** **Constant Value** **6**
		2. Product Price **equals or greater than** **Matched Product Price**
7. Save changes

<a id="venia-up-sells"></a>
##### Venia Up-sells
In order to show a consistent, logical ordering of the rules grid, we'll reconfigure Rule ID 44: Cross-sells Gear Bags to match the Venia Upsells rule beneath it:

Navigate to `Marketing > Related Products Rules`

1. Rule Information > Rule Name: `Up-sells - Venia`
2. Rule Information > Apply To: `Up-sells`
3. Rule Information > Status: `Active`
4. Rule Information > Customer Segments: `All`
5. Products to Match:
	1. If **ALL** of these conditions are **TRUE**:
		1. Category **is one of** **45,47,48,49,44,50,51,52,53**
6. Products to Display:
	1. If **ALL** of these conditions are **TRUE**:
		1. Product Category **is the Same as Matched Product Categories**
7. Save changes

**Note:** On the Cloud, the rule uses **is** instead of **is one of** in the `Products to Match` section. This has caused issues in older versions of Magento, so we'll use **is one of** to be safe here.

<a id="bags-to-hoodies-and-fitness-equipment-cross-sells"></a>
##### Bags to Hoodies and Fitness Equipment (Cross-sells)
Navigate to `Marketing > Related Products Rules`

1. Rule Information > Rule Name: `Cross-sells - Bags to Hoodies and Fitness Equipment`
2. Rule Information > Apply To: `Cross-sells`
3. Rule Information > Status: `Active`
4. Rule Information > Customer Segments: `All`
5. Products to Match:
	1. If **ALL** of these conditions are **TRUE**:
		1. Category **is** **4**
6. Products to Display:
	1. If **ANY** of these conditions are **TRUE**:
		1. Product Category **is** **Constant Value** **25**
		2. Product Category **is** **Constant Value** **16**
		3. Product Category **is** **Constant Value** **5**
7. Save changes

<a id="promotions-cart-price-rules"></a>
#### Promotions (Cart Price Rules)

<a id="deactivate-unwanted-rules"></a>
##### Deactivate Unwanted Rules
For the most part, all of the included cart rules can help tell an effective demo story.  The only one which *may* conflict, or make things more complicated, is: `20% OFF Ever $200-plus purchase!*`.  We'll deactivate this one and take care of a couple other things.

Navigate to `Marketing > Promotions > Cart Price Rules`

1. By default, the grid is strangely sorted.  Sort it by ID
2. By chance, I found that the description of `20% OFF Ever $200-plus purchase!*` has pretty bad English.  Update the description to: `Shopping cart price rule for the cart over $200. Does not apply to items in the Sale category.`
3. Set the `20% OFF Ever $200-plus purchase!*` rule to `Inactive`

<a id="free-shipping"></a>
##### Free Shipping
Next, we'll update the Free Shipping rule for our larger marketing story.

Navigate to `Marketing > Promotions > Cart Price Rules`

Make the following updates:

1. Rule Name: `Spend $100 or more - shipping is free!`
2. Description: `Free shipping on any purchase of $100 or more.`
2. Add the `VIP` customer group to the rule
3. Conditions:
	1. IF **ALL** of these conditions are TRUE:
		1. **Subtotal** **equals or greater than** **100**

<a id="targeted-content-dynamic-blocks"></a>
#### Targeted Content (Dynamic Blocks)

<a id="featured-products-guest-customers"></a>
##### Featured Products (Guest Customers)
First, we'll create a featured products list for guest customers, starting with the US Market:

Navigate to `Content > Elements > Dynamic Blocks`

1. Add a new Dynamic Block and use the following settings:
	1. Enable Dynamic Block: `Yes`
	2. Dynamic Block Name: `Featured Products (Guest Customers)`
	3. Dynamic Block Type: `Any Dynamic Block Type`
	4. Customer Segment: `LUMA Guest Customers`

Content will consist of one row containing the HTML-driven heading we saved earlier and a products list element which refers to the `Featured Products` category.

1. Duplicate the first row
2. Drag an `HTML Code` element into the top row
3. Paste the following

```
<div class="content-heading">
    <h2 class="title">Hot Sellers</h2>
    <p class="info">Here is what`s trending on Luma right now</p>
</div>
```

4. Advanced > Alignment: `Center` (Optional, but useful to illustrate the expected result)
5. Add a `Products List` element and use the following settings:
	1. Condition:
		1. If **ALL** of these conditions are **TRUE**
			1. Category **is** **62**
	2. Number of Products to Display: `5`
	3. Advanced > Alignment: `Center`

6. Save the Dynamic Block.
7. Once saved, re-open the new block and switch from `All Store Views` to the `Luma > Luma Store > US English` store view.
8. Make sure `Use default` is de-ticked. (This ensures that the US English store view is included in the grid and may demo better)

**Note:** Creating the dynamic block using `All Store Views` first is mandatory.  For some reason, Magento doesn't render store view specific dynamic blocks which are nested inside of static blocks, but it *does* render the content assigned to *All Store Views*.  By assigning the block to *All Store Views*, we ensure we can see it render in the home page content block which we'll use to demo most often.

Next, open the same Dynamic Block and repeat for the German store view:

1. Switch the store view scope to `Luma > Luma Store > Deutsch`
2. De-tick `Use Default Value`
3. Update the HTML heading to:
```
<div class="content-heading">
   <h2 class="title">Heiße Angebote</h2>
   <p class="info">Favoriten von Luma Shoppers</p>
</div>
```
Once the dynamic block is created, we need to add it to the Home Page blocks for the US and German store views:

Navigate to `Content > Elements > Blocks > Home Page Block - US`

1. Add a second row to the content - use the default `Contained` row template
2. Update the row properties and zero out the top and bottom padding
3. Add the `Featured Products (Guest Customers)` dynamic block to the second row
4. Save

Repeat this process for the `Home Page Block - DE` content block.

<a id="featured-products-runners"></a>
##### Featured Products (Runners)
Next, we'll create a featured products list for customers whose favorite activity is running, starting with the US Market:

Navigate to `Content > Elements > Dynamic Blocks`

1. Add a new Dynamic Block and use the following settings:
	1. Enable Dynamic Block: `Yes`
	2. Dynamic Block Name: `Featured Products (Runners)`
	3. Dynamic Block Type: `Any Dynamic Block Type`
	4. Customer Segment: `Customer Preference - Runners`

Content will consist of one row containing the HTML-driven heading we saved earlier and a products list element which refers to the `Featured Products` category.

1. Duplicate the first row
2. Drag an `HTML Code` element into the top row
3. Paste the following

```
<div class="content-heading">
    <h2 class="title">Because You Love Running</h2>
    <p class="info">#RunnersLife</p>
</div>
```

4. Advanced > Alignment: `Center` (Optional, but useful to illustrate the expected result)
5. Add a `Products List` element and use the following settings:
	1. Condition:
		1. If **ALL** of these conditions are **TRUE**
			1. Activity **contains** **Running**
			2. Visibility **is** **Catalog, Search**
	2. Number of Products to Display: `5`
	3. Advanced > Alignment: `Center`

6. Save the Dynamic Block.
7. Once saved, re-open the new block and switch from `All Store Views` to the `Luma > Luma Store > US English` store view.
8. Make sure `Use default` is de-ticked. (This ensures that the US English store view is included in the grid and may demo better)

Next, open the same Dynamic Block and repeat for the German store view:

1. Switch the store view scope to `Luma > Luma Store > Deutsch`
2. De-tick `Use Default Value`
3. Update the HTML heading to:
```
<div class="content-heading">
    <h2 class="title">Weil Du Gerne Rennst</h2>
    <p class="info">#LäuferLeben
</p>
</div>
```
Once the dynamic block is created, we need to add it to the Home Page blocks for the US and German store views:

Navigate to `Content > Elements > Blocks > Home Page Block - US`

1. Duplicate the `Featured Products (Guest Customers)` dynamic block, change the newly-added dynamic block to the `Featured Products (Runners)` block, and then drag the `Featured Products (Runners)` block *above* the `Featured Products (Guest Customers)` block.
2. Save

Repeat this process for the `Home Page Block - DE` content block.

<a id="featured-products-women-who-purchased-nsdj"></a>
##### Featured Products (Women Who Purchased NSDJ)
Next, to align with an MBI dashboard the SC's use, we'll create a featured products list for female customers who have only made one purchase which contained the Neve Studio Dance Jacket, starting with the US Market:

Navigate to `Content > Elements > Dynamic Blocks`

1. Add a new Dynamic Block and use the following settings:
	1. Enable Dynamic Block: `Yes`
	2. Dynamic Block Name: `Featured Products (Women Who Purchased NSDJ)`
	3. Dynamic Block Type: `Any Dynamic Block Type`
	4. Customer Segment: `Purchase History - Female Repeat Customers (Neve Studio Dance Jacket)`

Content will consist of one row containing the HTML-driven heading we saved earlier and a products list element which refers to the `Featured Products` category.

1. Duplicate the first row
2. Drag an `HTML Code` element into the top row
3. Paste the following

```
<div class="content-heading">
    <h2 class="title">Just For You</h2>
    <p class="info">Here are some items to go with your new jacket!</p>
</div>
```

4. Advanced > Alignment: `Center` (Optional, but useful to illustrate the expected result)
5. Add a `Products List` element and use the following settings:
	1. Condition:
		1. If **ANY** of these conditions are **TRUE**
			1. **SKU** **contains** **WH08**
			2. **SKU** **contains** **WJ11**
			3. **SKU** **is** **24-UG06**
			4. **SKU** **contains** **MJ06**
			5. **SKU** **contains** **MS08**
	2. Number of Products to Display: `5`
	3. Advanced > Alignment: `Center`

6. Save the Dynamic Block.
7. Once saved, re-open the new block and switch from `All Store Views` to the `Luma > Luma Store > US English` store view.
8. Make sure `Use default` is de-ticked. (This ensures that the US English store view is included in the grid and may demo better)

Next, open the same Dynamic Block and repeat for the German store view:

1. Switch the store view scope to `Luma > Luma Store > Deutsch`
2. De-tick `Use Default Value`
3. Update the HTML heading to:
```
<div class="content-heading">
    <h2 class="title">Nur für Dich</h2>
    <p class="info">Hier sind einige Artikel zu Ihrer neuen Jacke!</p>
</div>
```
Once the dynamic block is created, we need to add it to the Home Page blocks for the US and German store views:

Navigate to `Content > Elements > Blocks > Home Page Block - US`

1. Duplicate the `Featured Products (Runners)` dynamic block, change the newly-added dynamic block to the `Featured Products (Women Who Purchased NSDJ)` block, and then drag the `Featured Products (Women Who Purchased NSDJ)` block *above* the `Featured Products (Runners)` block.
2. Save

Repeat this process for the `Home Page Block - DE` content block.

<a id="featured-products-vip"></a>
##### Featured Products (VIP)
Next, we'll show our VIP customers a list of our newest products, starting with the US Market:

Navigate to `Content > Elements > Dynamic Blocks`

1. Add a new Dynamic Block and use the following settings:
	1. Enable Dynamic Block: `Yes`
	2. Dynamic Block Name: `Featured Products (VIP)`
	3. Dynamic Block Type: `Any Dynamic Block Type`
	4. Customer Segment: `Purchase History - VIP Customers`

Content will consist of one row containing the HTML-driven heading we saved earlier and a products list element which refers to the `Featured Products` category.

1. Duplicate the first row
2. Drag an `HTML Code` element into the top row
3. Paste the following

```
<div class="content-heading">
    <h2 class="title">For Your Eyes Only, VIP</h2>
    <p class="info">Here are some of our newest products</p>
</div>
```

4. Advanced > Alignment: `Center` (Optional, but useful to illustrate the expected result)
5. Add a `Products List` element and use the following settings:
	1. Condition:
		1. If **ALL** of these conditions are **TRUE**
			1. New **is** **Yes**
	2. Number of Products to Display: `5`
	3. Advanced > Alignment: `Center`

6. Save the Dynamic Block.
7. Once saved, re-open the new block and switch from `All Store Views` to the `Luma > Luma Store > US English` store view.
8. Make sure `Use default` is de-ticked. (This ensures that the US English store view is included in the grid and may demo better)

Next, open the same Dynamic Block and repeat for the German store view:

1. Switch the store view scope to `Luma > Luma Store > Deutsch`
2. De-tick `Use Default Value`
3. Update the HTML heading to:
```
<div class="content-heading">
    <h2 class="title">Nur für Deine Augen, VIP</h2>
    <p class="info">Hier sind einige unserer neuesten Produkte</p>
</div>
```
Once the dynamic block is created, we need to add it to the Home Page blocks for the US and German store views:

Navigate to `Content > Elements > Blocks > Home Page Block - US`

1. Duplicate the `Featured Products (Women Who Purchased NSDJ)` dynamic block, change the newly-added dynamic block to the `Featured Products (VIP)` block, and then drag the `Featured Products (VIP)` block *above* the `Featured Products (Women Who Purchased NSDJ)` block.
2. Save

Repeat this process for the `Home Page Block - DE` content block.

<a id="free-shipping-advertisement"></a>
##### Free Shipping Advertisement
Next, we'll create a free shipping advertisement which will show on the shopping cart whenever a customer enters the Free Shipping threshold we set up with our Free Shipping promotion ($75 - $99).

Navigate to `Content > Elements > Dynamic Blocks`

1. Add a new Dynamic Block and use the following settings:
	1. Enable Dynamic Block: `Yes`
	2. Dynamic Block Name: `Free Shipping Advertisement`
	3. Dynamic Block Type: `Any Dynamic Block Type`
	4. Customer Segment: `Shopping Cart - Free Shipping Threshold ($75 - $99)`
	5. Appearance: `Contained`
	6. Background > Background Image:
		1. Choose `Select from Gallery`
		2. Upload the `free_ship_2019.png` image to the `promotions` folder and select it
	7. Background > Background Size: `Cover`
	8. Background > Background Position: `Center Right`
	9. Layout > Minimum Height: `427`
	10. Advanced > Margins and Padding:
		1. Top Margin: `0`
		2. Left Margin: `0`
		3. Right Margin: `0`
		4. Bottom Magin: `0`
		5. Top Padding: `10`
		6. Left Padding: `10`
		7. Right Padding: `10`
		8. Bottom Padding: `10`

2. Add a `Text` element:
	1. Content Line 1:
		1. Format: `Heading 2`
		2. Font Size: `40px`
		3. Line Height: `26px`
		4. Text: `You're Almost There!`
	2. Content Lines 2 and 3:
		1. Format: `Heading 2`
		2. Font Size: `26px`
		3. Line Height: `34px`
		4. Text: `Spend $100 or more to get` (Add a non-breaking line break using `Shift+Enter`) `**FREE SHIPPING**`
	3. Advanced > Margins and Padding: 
		1. Top Margin: `20`
		2. Left Margin: `60`
		3. Right Margin: `0`
		4. Bottom Magin: `0`
		5. Top Padding: `0`
		6. Left Padding: `0`
		7. Right Padding: `0`
		8. Bottom Padding: `0`

Next, we need to create a new Dynamic Block Rotator widget we'll use to display the Free Shipping advertisement:

Navigate to `Content > Elements > Widgets`

1. Add a new widget
	1. Storefront Properties > Type: `Dynamic Block Rotator`
	2. Storefront Properties > Design Package/Theme: `Magento Luma`
	3. Storefront Properties > Widget Title: `Free Shipping Messaging`
	4. Storefront Properties > Assign to Store Views: `Luma Website > Luma Store > US English, Deutsch`
	5. Storefront Properties > Sort Order: `0`
	6. Storefront Properties > Layout Updates:
		1. Display on: `Specified Page`
		2. Page: `Shopping Cart`
		3. Container: `After Page Header Top` (Beneath the main navigation on the shopping cart page)
		4. Template: `Dynamic Block Template`
	7. Widget Options:
		1. Dynamic Blocks to Display: `Specified Dynamic Blocks`
		2. Restrict by Dynamic Block Types: `None`
		3. Rotation Mode: `Display all instead of rotating`
		4. Specify Dynamic Blocks (After clicking `Reset filter`): 
			1. `Free Shipping Advertisement` -- Position: `1`
	8. Save the Dynamic Block Rotator widget

Once saved, clear the cache

<a id="free-shipping-applied-message"></a>
##### Free Shipping Applied Message
Next, we'll create a *Free Shipping Applied* message which tells the customer that free shipping has been applied (since, by default, the 'Estimate Shipping and Tax' information which would show a shipping cost of $0 is collapsed).  We'll use the *Related Promotions* feature to ensure that this message appears whenever the Free Shipping promotion has been applied.

Navigate to `Content > Elements > Dynamic Blocks`

1. Add a new Dynamic Block
	1. Enable Dynamic Block: `Yes`
	2. Dynamic Block Name: `Free Shipping Applied`
	3. Dynamic Block Type: `Any Dynamic Block Type`
	4. Customer Segment: `All Segments`
	5. Appearance: `Contained`
	6. Background > Background Color: `#e7eee6`
	7. Background > Background Image:
		1. Choose `Select from Gallery`
		2. Upload the `checkmark` image to the `promotions` folder and select it
	8. Background > Background Size: `Auto`
	9. Background > Background Position: `Center Left`
	10. Layout > Minimum Height: `75px`
	11. Vertical Alignment: `Top`
	12. Advanced > Margins and Padding:
		1. Top Margin: `-45px`
		2. Left Margin: `0`
		3. Right Margin: `0`
		4. Bottom Magin: `0`
		5. Top Padding: `0`
		6. Left Padding: `0`
		7. Right Padding: `0`
		8. Bottom Padding: `0`

2. Add a `Text` element:
	1. Content Line 1:
		1. Format: `Paragraph`
		2. Font Size: `18px`
		3. Line Height: `Line Height`
		4. Text Color: `#006400`
		4. Text: `Free Shipping Applied!`
	2. Advanced > Margins and Padding: 
		1. Top Margin: `0`
		2. Left Margin: `0`
		3. Right Margin: `0`
		4. Bottom Magin: `0`
		5. Top Padding: `25px`
		6. Left Padding: `65px`
		7. Right Padding: `0`
		8. Bottom Padding: `0`

3. Related Promotions > Add Cart Price Rules > `Spend $100 or more - shipping is free!`
4. Save the Dynamic Block

**Note:** The reason for the -45px top margin above has to do with how Magento displays Dynamic Block rotator widgets. In our example, we'll be displaying two separate dynamic block rotator widgets on the same shopping cart page.  Each of these rotators is contained within its own `div` element which is still *visible* on the page (only its *content* is hidden and displayed based on segmentation). Therefore, each Dynamic Block Rotator widget's containing `div` is still affected by padding and margin.

Next, we need to create a new Dynamic Block Rotator widget we'll use to display the :

Navigate to `Content > Elements > Widgets`

1. Add a new widget
	1. Storefront Properties > Type: `Dynamic Block Rotator`
	2. Storefront Properties > Design Package/Theme: `Magento Luma`
	3. Storefront Properties > Widget Title: `Free Shipping Applied Message`
	4. Storefront Properties > Assign to Store Views: `Luma Website > Luma Store > US English, Deutsch`
	5. Storefront Properties > Sort Order: `10`
	6. Storefront Properties > Layout Updates:
		1. Display on: `Shopping Cart`
		2. Page: `Shopping Cart`
		3. Container: `After Page Header Top` (Beneath the main navigation on the shopping cart page)
		4. Template: `Dynamic Block Template`
	7. Widget Options:
		1. Dynamic Blocks to Display: `Shopping Cart Promotions Related`
		2. Restrict by Dynamic Block Types: `None`
		3. Rotation Mode: `Display all instead of rotating`
	8. Save the Dynamic Block Rotator widget

**Note:** The value of `10` for the sort order is important: it ensures that the advertisement is display first and the applied message is shown second.  Hence, our top margin value of `-45px` for the applied message moves the message up to where the advertisement sits. 

<a id="rewards-program-advertisements"></a>
##### Rewards Program Advertisements
Next, we'll create our Rewards Program Advertisements - *Loyalty Pays* for Guest Customers and *Triple Points* for Bronze, Silver, and Gold members.

First, *Loyalty Pays*:

Navigate to `Content > Elements > Dynamic Blocks`

1. Add a new Dynamic Block
	1. Enable Dynamic Block: `Yes`
	2. Dynamic Block Name: `Rewards Program (Guest Customers)`
	3. Dynamic Block Type: `Any Dynamic Block Type`
	4. Customer Segment: `LUMA Guest Customers`

	**Note:** For this block, we'll need to use an image since we'll be showing the advertisement in the left column of certain category landing pages and Page Builder content isn't fully responsive yet.

	5. Appearance: `Contained`
	6. Add an image:
		1. `Select From Gallery`
		2. Inside the `wysiwyg` folder, create a new folder called `promotions`
		3. Inside the `promotions` folder, upload the `loyalty-pays.jpg` image
	7. Save

Next, *Triple Points*:

Navigate to `Content > Elements > Dynamic Blocks`

1. Add a new Dynamic Block
	1. Enable Dynamic Block: `Yes`
	2. Dynamic Block Name: `Rewards Program (Bronze, Silver, and Gold Members)`
	3. Dynamic Block Type: `Any Dynamic Block Type`
	4. Customer Segment: `LUMA Rewards - Bronze ($250 - $500), LUMA Rewards - Silver ($500 - $1000), LUMA Rewards - Gold ($1000 - $2000)`

	**Note:**  For this block, we'll need to use an image since we'll be showing the advertisement in the left column of certain category landing pages and Page Builder content isn't fully responsive yet.
	
	5. Appearance: `Contained`
	6. Add an image:
		1. `Select From Gallery`
		2. Inside the `promotions` folder, upload the `triple-points.jpg` image
	7. Save

To finish, we need to create a Dynamic Block Rotator widget to insert the dynamic blocks on certain category landing pages:

Navigate to `Content > Elements > Widgets`

1. Add a new widget
	1. Storefront Properties > Type: `Dynamic Block Rotator`
	2. Storefront Properties > Design Package/Theme: `Magento Luma`
	3. Storefront Properties > Widget Title: `Loyalty Advertisements`
	4. Storefront Properties > Assign to Store Views: `Luma Website > Luma Store > US English, Deutsch`
	5. Storefront Properties > Sort Order: `0`
	6. Storefront Properties > Layout Updates:
		1. Display on: `Anchor categories`
		2. Categories: `Specific Categories`
			1. `24,25,26` (Women's Jackets, Women's Hoodies & Sweatshirts, Women's Tees)
		3. Container: `Sidebar Additional` (Beneath layered navigation filters, Compare Products, and My Wishlists blocks)
		4. Template: `Dynamic Block Template`
	7. Widget Options:
		1. Dynamic Blocks to Display: `Specified Dynamic Blocks`
		2. Restrict by Dynamic Block Types: `None`
		3. Rotation Mode: `Display all instead of rotating`
		4. Specify Dynamic Blocks (After clicking `Reset filter`): 
			1. `Rewards Program (Guest Customers)` -- Position: `1`
			2. `Rewards Program (Bronze, Silver, and Gold Members)` -- Position `2`
	8. Save the Dynamic Block Rotator widget

Once saved, clear the cache

<a id="staging-and-preview-campaigns"></a>
#### Staging and Preview Campaigns

<a id="valentines-day"></a>
##### Valentine's Day

<a id="summer-sale-lead-in"></a>
##### Summer Sale Lead-in
1. Change the top row background image to `promotions/summersunset.jpg`
2. Text:
	1. Line 1: `Summer's Here`
	2. Line 2: `Wow your friends and hit the beach in style!`


<a id="fourth-of-july-sale"></a>
##### Fourth of July Sale
1. Change the top row background image to `promotions/summersunset.jpg`
2. Text:
	1. Line 1: `Summer's Here`
	2. Line 2: `Wow your friends and hit the beach in style!`

<a id="summer-sale-lead-out"></a>
##### Summer Sale Lead-out
1. Change the top row background image to `promotions/summersunset.jpg`
2. Text:
	1. Line 1: `Summer's Here`
	2. Line 2: `Wow your friends and hit the beach in style!`

<a id="black-friday-lead-in"></a>
##### Black Friday Lead-in
1. Change the top row background image to `promotions/summersunset.jpg`
2. Text:
	1. Line 1: `Summer's Here`
	2. Line 2: `Wow your friends and hit the beach in style!`

<a id="black-friday-sale"></a>
##### Black Friday Sale
1. Change the top row background image to `promotions/summersunset.jpg`
2. Text:
	1. Line 1: `Summer's Here`
	2. Line 2: `Wow your friends and hit the beach in style!`

<a id="holiday-campaign"></a>
##### Holiday Campaign
1. Change the top row background image to `promotions/summersunset.jpg`
2. Text:
	1. Line 1: `Summer's Here`
	2. Line 2: `Wow your friends and hit the beach in style!`

<a id="content-with-page-builder"></a>
### Content with Page Builder

<a id="gear-category-landing-page"></a>
#### Gear Category Landing Page
Initially, the Gear category is set to show a static block of content via a Static Block widget, and the category's display mode is set to *Static Block Only*.  We'll change the display to show *Products Only* so that the SC can use it as part of a landing page creation use case.

Navigate to `Catalog > Categories > Gear`

1. Display Settings > Display Mode: `Products only`
2. Content > Elements > Widgets > Gear Category Content > Layout Updates: Delete Layout Update
3. Save

When done, clear cache

<a id="grid-views"></a>
### Grid Views

<a id="product-grids"></a>
#### Product Grids
<a id="womens-hoodies"></a>
##### Women's Hoodies
Filter on the following:

1. SKU: `WH`
2. Type: `Configurable Product`
3. Attribute Set: `Top`
4. Use the following columns:
	1. SKU
	2. Thumbnail
	3. Name
	4. Type
	5. Attribute Set
	6. Price
	7. Quantity
	8. Salable Quantity
	9. Visibility
	10. Status
	11. Websites

<a id="on-sale"></a>
##### On Sale
1. Set the `Sale` attribute to be filterable and able to be used in column arrangement
2. Filter on Sale = Yes (33)
3. Select all items
4. De-tick `Strive Shoulder Pack`, `Savvy Shoulder Tote`, `Endeavor Daytrip Backpack`, `Dual Handle Cardio Ball`
5. Use Mass Actions to set all *other* items Sale = `No`
6. Add the following items on sale:
	1. Zing Jump Rope
	2. Bolo Sport Watch
	3. Pursuit Lumaflex Tone Band
	4. Go Get'r Pushup Grips
7. Use the following columns:
	1. SKU
	2. Thumbnail
	3. Name
	4. Type
	5. Attribute Set
	6. Price
	7. Quantity
	8. Salable Quantity
	9. Visibility
	10. Status
	11. Websites
	12. Sale

<a id="featured-products"></a>
##### Featured Products
Filter on `Featured Product = Yes`

Use the following columns:
1. SKU
2. Thumbnail
3. Name
4. Type
5. Attribute Set
6. Price
7. Quantity
8. Salable Quantity
9. Visibility
10. Status
11. Websites
12. Featured Product

<a id="cms-pages-grid"></a>
#### CMS Pages Grid
1. Filter on Name = `Home`
2. Save grid as `Home Pages`

<a id="customers-grid"></a>
#### Customers Grid
By default, the customers grid is very crowded.  To help with this, consider removing the following columns:

1. Confirmed Email
2. Tax/VAT Number
3. Customer Since

<a id="staging-and-preview-grid"></a>
#### Staging and Preview Grid

<a id="cache-warmer-site-map"></a>
### Cache Warmer (Site Map)
In order for the cache warmer(s) to function properly, we need to create an XML file for each store view which has products assigned to it.  In our case, that's one for Luma US and one for Venia US store views.  Navigate to `Marketing > SEO and Search > Site Map` and create the following:

1. Luma
	1. Filename: `luma.xml`
	2. Path: `/pub/`
	3. Store View: `Luma Website > Luma Store > US English`
2. Venia
	1. Filename: `venia.xml`
	2. Path: `/pub/`
	3. Store View: `Luma Website > Venia Store > US English`

<a id="b2b-demo-cases"></a>
### B2B Demo Cases

<a id="configuration"></a>
#### Configuration

<a id="enable-b2b-modules"></a>
##### Enable B2B Modules
To use the B2B features, we'll need to enable them first:

Navigate to: `Stores > Settings > Configuration > General > B2B Features`

1. Enable Company: `Yes`
2. Enable Shared Catalog: `No` (We'll leave this disabled for now until the product team fixes it properly -- expected in 2.3.1)
3. Enable B2B Quote: `Yes`
4. Enable Quick Order: `Yes`
5. Enable Requisition List: `Yes`

<a id="payment-on-account"></a>
##### Payment on Account
By default, the Payment on Account method used to deduct a purchase amount from company credit is disabled and needs to be enabled before it can be used.  To enable it:

Navigate to `Stores > Settings > Configuration > Sales > Payment Methods`

1. Payment on Account > Enabled: `Yes`
2. Save the payment method

When saved, clear the cache

<a id="customers"></a>
#### Customers
First, we'll need to import or create customers to use for our B2B use cases.  You can expedite this by importing the included `B2B Customers Main File` CSV file followed by the `B2B Customer Addresses` CSV file:

Navigate to `System > Data Transfer > Import`

*Main File*

1. Entity Type: `Customers Main File`
2. Import Behavior: `Add/Update Complex Data`
3. Select File to Import: `B2B Customers Main File.csv`
4. Check Data
5. Import

*Addresses File*

1. Entity Type: `Customer Addresses`
2. Import Behavior: `Add/Update Complex Data`
3. Select File to Import: `B2B Customers Addresses.csv`
4. Check Data
5. Import

Once the users are imported, we'll need to set them as active (even though they are listed as being active in their account information.) To ensure that they are active:

Navigate to: `Customers > All Customers`

1. Filter the customer grid on the customer in question
2. Ensure that Customer Information > Account Information > Customer Active: `Yes`
3. Save the customer and note the `Active` status in the customer grid

<a id="sales-representative-role-and-user"></a>
#### Sales Representative Role and User
Next, we'll create another admin user and user role that we'll assign as the sales representative for our companies.

**Note:** For whatever reason, permissions for Quotes are not available to anyone except a user with complete access.

*User Role*

Navigate to `System > Permissions > User Roles`

1. Add a new role
2. Role Info > Role Name: `Sales Representative`
3. Role Info > Your Password: `admin4tls`
4. Role Resources > Role Scopes: `All`
5. Role Resources > Role Resources > Resource Access > `All` 
6. Save the role

*User*

Navigate to `System > Permissions > All Users`

1. Add a new user
2. User Info > Account Information > User Name: `mjones`
3. User Info > Account Information > First Name: `Mark`
4. User Info > Account Information > Last Name: `Jones`
5. User Info > Account Information > Email: `mjones@luma.com`
6. User Info > Account Information > Password: `admin4tls`
7. User Info > Account Information > Password Confirmation: `admin4tls`
8. User Info > Account Information > Interface Locale: `English (United States)`
9. User Info > Account Information > This account is: `Active`
10. User Info > Current User Identity Verification > Your Password: `admin4tls`
11. User Role: `Sales Representative`
12. Save the user

<a id="companies"></a>
#### Companies
After the customers are imported, we'll create the two companies we're going to use to tell the B2B story, and then assign the proper customers to them.

Navigate to `Customers > Companies`

<a id="terra-outfitters"></a>
##### Terra Outfitters

1. Add a new company
2. Company Name: `Terra Outfitters`
3. Status: `Active`
4. Company Email: `info@terraoutfitters.com`
5. Sales Representative: `mjones`
6. Account Information > Company Legal Name: `Terra Outfitters, Inc.`
7. Account Information > VAT / TAX ID: `None`
8. Reseller ID: `1548`
9. Account Information > Comment: `None`
10. Legal Address > Street Address: `10441 Jefferson Blvd., Ste 200`
11. Legal Address > City: `Culver City`
12. Legal Address > Country: `United States`
13. Legal Address > State/Province: `California`
14. Legal Address > Zip/Postal Code: `90232`
15. Legal Address > Phone Number: `310-345-0984`
16. Company Admin > Website: `Luma Website`
17. Company Admin > Job Title: `VP, eCommerce`
18. Company Admin > Email: `john.smith@terraoutfitters.com`
19. Company Admin > Prefix: `None`
20. Company Admin > First Name: `John`
21. Company Admin > Middle Name/Initial: `None`
22. Company Admin > Last Name: `Smith`
23. Company Admin > Suffix: `None`
24. Company Admin > Gender: `Male`
25. Company Credit > Credit Currency: `US Dollar`
26. Company Credit > Credit Limit: `$50,000`
27. Company Credit > Reason For Change: `Initial allotment`
28. Company Credit > Allow to Exceed Credit Limit: `No`
29. Advanced Settings > Allow Quotes: `Yes`

<a id="emilys-exercise-emporium"></a>
##### Emily's Exercise Emporium

1. Add a new company
2. Company Name: `Emily's Exercise Emporium`
3. Status: `Active`
4. Company Email: `contact@3e.com`
5. Sales Representative: `mjones`
6. Account Information > Company Legal Name: `Emily's Exercise Emporium, LLC`
7. Account Information > VAT / TAX ID: `None`
8. Reseller ID: `1549`
9. Account Information > Comment: `None`
10. Legal Address > Street Address: `135 Cannon St`
11. Legal Address > City: `Charleston`
12. Legal Address > Country: `United States`
13. Legal Address > State/Province: `South Carolina`
14. Legal Address > Zip/Postal Code: `29403`
15. Legal Address > Phone Number: `843-493-2938`
16. Company Admin > Website: `Luma`
17. Company Admin > Job Title: `Owner`
18. Company Admin > Email: `emily.hopkins@3e.com`
19. Company Admin > Prefix: `None`
20. Company Admin > First Name: `Emily`
21. Company Admin > Middle Name/Initial: `None`
22. Company Admin > Last Name: `Hopkins`
23. Company Admin > Suffix: `None`
24. Company Admin > Gender: `Female`
25. Company Credit > Credit Currency: `US Dollar`
26. Company Credit > Credit Limit: `$25,000`
27. Company Credit > Reason For Change: `Initial allotment`
28. Company Credit > Allow to Exceed Credit Limit: `No`
29. Advanced Settings > Allow Quotes: `Yes`

<a id="buyer-users"></a>
#### Buyer Users
Once the users have been imported and the companies have been created, we can assign Jack Fitz and Jill Moorehouse to Terra Outfitters:

Navigate to `Customers > All Customers`

1. Find the desired customer in the grid
2. Customer Information > Account Information > Associate to Company: `Terra Outfitters`
3. Save the customer

<a id="buyer-teams"></a>
#### Buyer Teams
Now that the users have been created and assigned to their companies, we'll create user teams on the storefront and users to them.

Login as `John Smith` on the storefront and navigate to `John Smith > Company Structure`

*East Coast Team*
1. Add a team
2. Team Title: `East Coast`
3. Description: `This is our East Coast team - based out of Montclair, New Jersey.`
4. Save the team
5. Drag Jack Fitz into the East Coast team and expand it

*West Coast Team*
1. Add a team
2. Team Title: `West Coast`
3. Description: `This is our West Coast team - based out of San Francisco, California.`
4. Save the team
5. Drag Jill Moorehouse into the West Coast team and expand it

<a id="buyer-roles-and-permissions"></a>
#### Buyer Roles and Permissions
Next, we'll edit the Default User role and rename it to Buyer.  Then, we'll customize its permissions.

Login as `John Smith` on the storefront and navigate to `John Smith > Roles and Permissions`

1. Edit the `Default User` role
2. Role Name: `Buyer`
3. Add `Use Pay On Account Method` permission
4. Remove `Company User Management` permission
5. Add `Company Credit` and `Company Credit > View` permissions


<a id="b2b-autofill"></a>
#### B2B Autofill
Now that we've added the B2B customers, we can add them as personas in the autofill so we can easily login to their accounts during a demo:

Navigate to `Stores > Settings > Configuration > Magento Ese > Auto Fill`

*John Smith*
1. Expand `Persona 4`
2. Enable this Persona: `Yes`
3. Persona Label: `John Smith (VP, eCommerce - Terra Outfitters)`
4. Email Account: `john.smith@terraoutfitters.com`
5. Password: `Password1`
6. First Name: `John`
7. Last Name: `Smith`
8. Company: `Terra Outfitters, Inc`
9. Address: `10441 Jefferson Blvd., Ste 200`
10. Country: `United States`
11. State/Province: `California`
12. City: `Culver City`
13. Zip/Postal Code: `90232`
14. Telephone: `310-345-0984`
15. Fax: `None`
16. Credit Card Type: `Visa`
17. Credit Card Number: `4111111111111111`
18. Credit Card Expiration Month: `1`
19. Credit Card Expiration Year: `2023`
20. Credit Card Verification Number: `123`

*Jack Fitz*
1. Expand `Persona 5`
2. Enable this Persona: `Yes`
3. Persona Label: `Jack Fitz (Buyer - Terra Outfitters)`
4. Email Account: `jack.fitz@terraoutfitters.com`
5. Password: `Password1`
6. First Name: `Jack`
7. Last Name: `Fitz`
8. Company: `Terra Outfitters, Inc.`
9. Address: `7 N Willow St`
10. Country: `United States`
11. State/Province: `New Jersey`
12. City: `Montclair`
13. Zip/Postal Code: `07042`
14. Telephone: `231-394-0342`
15. Fax: `None`
16. Credit Card Type: `Visa`
17. Credit Card Number: `4111111111111111`
18. Credit Card Expiration Month: `1`
19. Credit Card Expiration Year: `2023`
20. Credit Card Verification Number: `123`

*Jill Moorehouse*
1. Expand `Persona 6`
2. Enable this Persona: `Yes`
3. Persona Label: `Jill Moorehouse (Buyer - Terra Outfitters)`
4. Email Account: `jill.moorehouse@terraoutfitters.com`
5. Password: `Password1`
6. First Name: `Jill`
7. Last Name: `Moorehouse`
8. Company: `Terra Outfitters, Inc.`
9. Address: `130 Beaver St`
10. Country: `United States`
11. State/Province: `California`
12. City: `San Francisco`
13. Zip/Postal Code: `94115`
14. Telephone: `556-417-6947`
15. Fax: `None`
16. Credit Card Type: `Visa`
17. Credit Card Number: `4111111111111111`
18. Credit Card Expiration Month: `1`
19. Credit Card Expiration Year: `2023`
20. Credit Card Verification Number: `123`

*Emily Hopkins*
1. Expand `Persona 7`
2. Enable this Persona: `Yes`
3. Persona Label: `Emily Hopkins (Owner, Emilys Exercise Emporium)`
4. Email Account: `emily.hopkins@3e.com`
5. Password: `Password1`
6. First Name: `Emily`
7. Last Name: `Hopkins`
8. Company: `Emilys Exercise Emporium`
9. Address: `135 Cannon St`
10. Country: `United States`
11. State/Province: `South Carolina`
12. City: `Charleston`
13. Zip/Postal Code: `29403`
14. Telephone: `843-493-2938`
15. Fax: `None`
16. Credit Card Type: `Visa`
17. Credit Card Number: `4111111111111111`
18. Credit Card Expiration Month: `1`
19. Credit Card Expiration Year: `2023`
20. Credit Card Verification Number: `123`

Clear cache once the personas are saved

**Note:** Do *not* use apostrophes in the Persona Labels or the Company names.  For some reason those cause errors.

**Note:** It's a good idea to disable the B2B personas by default once they're set up and tested.

<a id="catalogs"></a>
#### Catalogs

<a id="fixes"></a>
### Fixes
*TODO: Convert the core file changes listed in the following sections to legitimate patches that can then be applied via composer.*

Sources: [CWeagans Composer Patching Plugin](https://github.com/cweagans/composer-patches/)

<a id="pickup-in-store-quantity-is-mis-aligned"></a>
#### Pickup In Store Quantity is Mis-Aligned
For some reason, the quantity statement in the Pick Up In Store Module overlay is mis-aligned and needs to be adjusted:

1. In `vendor/magentoese/module-instorepickup/view/frontend/web/js/templates/result.html`, on line 12, add CSS margin to move the "Available" string: `span style="float: right; margin-right: 20%;"`
2. Save with `Esc`, then `:wq` and `Enter`
3. Clear `pub/static`, then clear the cache.  After, re-deploy static content for US and German store views: `rm -rf pub/static/ && rm -rf var/cache/* var/page_cache/* && deploy-content && deploy-content-de`
4. Note: You may need to clear browser cache to see the change

<a id="pickup-in-store-extension-breaks-b2b-checkout"></a>
#### Pickup In Store Extension Breaks B2B Checkout

1. In `vendor/magento/module-negotiable-quote/Block/Checkout/LayoutProcessor.php`, comment out line 56: `$cartItemsComponent['template'] = self::TEMPLATE_CART_ITEMS;`
2. Recompile classes, deploy static content, reindex and clear cache with: `di-compile && deploy-content && deploy-content-de && clean`

<a id="image-gallery-uses-prepend-instead-of-replace"></a>
#### Image Gallery Uses Prepend Instead of Replace

1. In `vendor/magento/theme-frontend-luma/etc/view.xml`, use the `/` key and search for the word `prepend`.  
2. Change it from `prepend` to `replace`
3. Save with `Esc`, then `:wq` and `Enter`
4. Clear the cache with: `cache`

<a id="hide-the-venia-lookbook-category"></a>
#### Hide the Venia Lookbook Category
Currently, the lookbook extension is required by other extensions but doesn't work well itself.  So, to prevent landmines, we'll disable the Lookbook category, hide it from the main navigation, and then update the Venia home page content so that it doesn't refer to anything related to the lookbook:

Navigate to: `Catalog > Categories`

1. Click on the `Shop the Look` category and set the following:
	1. Enable Category: `No`
	2. Include in Menu: `No`
2. Navigate to: `Content > Elements > Pages` and select the `Venia Home Page - US`
3. Change the paragraph text to: `Check out these fabulous looks we've curated just for you`
4. Change the button text to: `SHOP TOPS`
5. Update the button and make it link to the `Venia Catalog > Tops` category
6. Add a second button: `SHOP BOTTOMS`
7. Update the button and make it link to the `Venia Catalog > Bottoms` category
8. Edit the button group and set `All Buttons are same size` to `Yes`
9. Update the `Just For You` text to `Accessories FTW`
10. Update the button text to: `SHOP ACCESSORIES`
11. Update the button link to the `Venia Catalog > Accessories` category

<a id="fix-the-venia-tops-category"></a>
#### Fix the Venia Tops Category
There's a known break in the code which causes the Venia Tops category to break and show a white page.  To fix this, we'll update the display mode of the category to use `Products Only` instead of the `Static Block` it uses by default:

Navigate to: `Catalog > Categories > Venia Catalog > Display Settings`

1. Set the display setting to `Products Only`
2. Expand the `Design` section and *remove* the following content from the `Layout XML` textarea:

```
<referenceBlock name="catalog.leftnav" remove="true" />
<referenceBlock name="page.main.title" remove="true" />
<referenceBlock name="catalog.compare.sidebar" remove="true"/>
<referenceBlock name="view.addto.compare" remove="true" />
<referenceBlock name="view.addto.wishlist" remove="true" />
```

When done, refresh the cache.

<a id="email-from-doesnt-show-properly"></a>
#### Email "From" Doesn't Show Properly

Sources: [Confirmation emails have no FROM or FROM email address 2.2.4 #14952](https://github.com/magento/magento2/issues/14952)
