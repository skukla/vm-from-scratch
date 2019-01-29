# Creating A Magento VM
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
- [Giving Demos with the VM](#giving-demos-with-the-vm)
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
			- [YouTube API Key](#youtube-api-key)
			- [Enable RMA](#enable-rma)
			- [Password Policy](#password-policy)
			- [Enable Instant Purchase](#enable-instant-purchase)
			- [Remove Welcome Message](#remove-welcome-message)
			- [Update Site Meta Info](#update-site-meta-info)
			- [Configure Reward Points](#configure-reward-points)
		- [General Content Updates](#general-content-updates)
			- [Luma Home Page \(US\)](#luma-home-page-us)
			- [Luma Home Page \(DE\)](#luma-home-page-de)
			- [Venia Home Page](#venia-home-page)
		- [Customer Configuration](#customer-configuration)
			- [Redirect to My Account](#redirect-to-my-account)
			- [Set Up Saved Cards](#set-up-saved-cards)
		- [Marketing](#marketing)
			- [Featured Products on Home Page](#featured-products-on-home-page)
			- [Sale Category](#sale-category)
			- [Customer Segments](#customer-segments)
			- [Related Products Rules](#related-products-rules)
			- [Promotions](#promotions)
			- [Staging and Preview Campaigns](#staging-and-preview-campaigns)
		- [Grids Setup](#grids-setup)
			- [Product Grids](#product-grids)
			- [CMS Blocks Grid](#cms-blocks-grid)
			- [CMS Pages Grid](#cms-pages-grid)
			- [Staging and Preview Grid](#staging-and-preview-grid)
		- [Tools](#tools)
			- [Cache Warmer \(Site Map\)](#cache-warmer-site-map)
			- [SC Theme Customizer](#sc-theme-customizer)
		- [B2B Demo Cases](#b2b-demo-cases)
	- [Fixes](#fixes)
		- [Pickup In Store Quantity is Mis-Aligned](#pickup-in-store-quantity-is-mis-aligned)
		- [Pickup In Store Extension Breaks B2B Checkout](#pickup-in-store-extension-breaks-b2b-checkout)
		- [Image Gallery Uses Prepend Instead of Replace](#image-gallery-uses-prepend-instead-of-replace)
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

Note: If you clear your screen and want to recall the MoTD, use: `cat /var/run/motd.dynamic`.

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

Next, using`vim`, we'll create a custom bash script for our own MoTD: `sudo vim /etc/update-motd.d/01-custom`.  Use `i` to enter *Insert* mode, and then paste in the below:

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
In order to mirror

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


<a id="configuring-magento-and-varnish"></a>
### Configuring Magento and Varnish

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

<a id="giving-demos-with-the-vm"></a>
## Giving Demos with the VM
<a id="demo-environments"></a>
### Demo Environments
The Solutions Innovation team provides Solutions Consultants with two Cloud projects for demonstrating the Luma brand: a Reference environment and a Demo environment.  The *Reference* environment is a completely native installation of Magento -- there are no extensions of any kind; only the code base and the sample data which ships with the platform.  In contrast, the *Demo* environment builds on the native installation with sample data but adds both custom modules built and/or maintained by the Solutions Innovation team as well as third-party extensions built by the Magento developer community.

<a id="the-hybrid-vm"></a>
### The Hybrid VM
For some solution consultants, the two default environments cover both extremes, and may not be an ideal solution.  On one hand, while the Reference environments are entirely native, there are useful additions that will serve Solutions Consultants more effectively in the field without including too many customizations.

<a id="preparation"></a>
#### Preparation
For whatever reason, it is not currently possible to use the cloud code base to create a custom VM.  Exhaustive testing has shown that some combinations of the Luma DE and Venia-related modules cause cron jobs to become unmanageable and results are not predictable.  As such, we will create the hybrid environment from scratch and pull in needed elements from Cloud.  Note that before you begin pulling code, you'll need a set of composer credentials for the Magento repository which have the correct access permissions.

<a id="downloading-the-code"></a>
#### Downloading the Code
To begin, we start by using Composer to download the code in the web root.   We'll also include the B2B modules and the Luma sample data:


1. `www`
2. `rm -rf * .*` (Optional: Removes files from web root -- only used if this is a reinstall)
3. `composer create-project --repository-url=https://repo.magento.com/ magento/project-enterprise-edition=^2.3.0 . && composer require magento/extension-b2b:^1.1 && ./bin/magento sampledata:deploy
`

(The sample data step will require your composer credentials, so be prepared to provide those.  It'll also ask you whether you'd like to store them for future use.)

<a id="customizing-the-codebase"></a>
#### Customizing the Codebase
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
#### Downloading and Applying Patches
Since the Magento application is a moving target, The Innovations team maintains a series of patches to fix known issues prior to installing the application.  First, we'll need to create a folder for the cloud codebase outside of our web root, download the hotfixes we want to apply from the cloud codebase using git, copy them into our codebase, and then apply them:

1. `www && cd ../ && mkdir cloud && cd cloud`
2. `git clone git@github.com:PMET-public/magento-cloud.git . && git checkout pmet-2.3.0-demo`
3. `www && cp -R ../cloud/m2-hotfixes/ .`
4. `php vendor/magentoese/ece-tools/bin/ece-tools patch`

<a id="installing-the-codebase"></a>
#### Installing the Codebase
With the patches applied, we can use the install command above to install the application.

<a id="demo-case-setup"></a>
### Demo Case Setup

<a id="autofill-setup"></a>
#### Autofill Setup
Initially, the autofill extension includes three enabled personas: VIP, Runner, and Yoga.  The first change we'll make is to add names to these profiles so we can refer to them in the demo story.  In `Stores > Settings > Configuration > Magento Ese > Auto Fill`, update the personas so that the persona labels reflect the following:

1. `Sharon (VIP)`
2. `Mark (Runner)`
3. `Lisa (Yoga)`

Then, clear cache.

<a id="business-operations-setup"></a>
#### Business Operations Setup 

<a id="update-the-root-category-website-and-store-names"></a>
##### Update the Root Category, Website, and Store Names
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
##### Set the Store Information and Shipping Origin
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
##### Set UPS as the Shipping Method
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
	`Ground`
	`UPS Next Day Air`

In order to use free shipping promotions, we need to set the following:

10. Free Method: `UPS Ground`
11. Enable Free Shipping Threshold: `Enable`
12. Free Shipping Amount Threshold: `1000000000`

(Using the ridiculously high threshold ensures that free shipping is only offered when shopping cart price rules offer it.  If we leave it at 0, Free Shipping for UPS would be offered for any order amount.)

In addition, we'll disable table rate shipping and flat rate shipping.  Note:  If you ever need to work on the VM offline, you'll need to disable UPS as a shipping method and make sure to use Flat Rate shipping since it doesn't require an API call.

Once saved, refresh the cache.

<a id="youtube-api-key"></a>
##### YouTube API Key
To use YouTube for product videos, we need to enter a YouTube API key.  Navigate to: `Stores > Settings > Configuration > Catalog > Catalog Product Video` and use the following API key:

`AIzaSyD4E-F8dCwzFp0OkOD1LdIiFFG8Q0wDy1o`

Once saved, refresh the cache.

<a id="enable-rma"></a>
##### Enable RMA
By default, RMA is not enabled for use.  To enable it, navigate to: `Stores > Settings > Configuration > Sales > Sales > RMA Settings`.

1. Enable RMA on Storefront: `Yes`

When saved, refresh the cache.

<a id="password-policy"></a>
##### Password Policy
By default, Magento has a pretty stringent password policy (three separate character classes and a forced reset for admins every 90 days.)  We're going to amend that to something much more friendly.

For cusotmer-facing passwords, navigate to: `Stores > Settings > Configuration > Customers > Customer Configuration > Password Options`:

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
##### Enable Instant Purchase
Verify Instant Purchase is enabled at: `Stores > Settings > Configuration > Sales > Sales > Instant Purchase`

<a id="remove-welcome-message"></a>
##### Remove Welcome Message
By default, Magento includes an annoying text string "Default welcome msg!" which gets replaced with "Welcome!" when a customer logs in.  Since this is stupidly unnecessary for a guest user, we'll remove it.

Navigate to: `Content > Design > Configuration` and choose Global scope. Expand the Header section, empty the Welcome Text field, and save.  Clear cache when done.

<a id="update-site-meta-info"></a>
##### Update Site Meta Info
Next, we'll set up global meta information for pages like the Order Confirmation results page which don't have headings.  Navigate to: `Content > Design > Configuration` and the `Luma Store US English` store view scope.  Use the following:

1. Default Page Title: `LUMA Official Online Store`
2. Default Meta Description: `With more than 230 stores spanning 43 states and growing, Luma is a nationally recognized active wear manufacturer and retailer. We’re passionate about active lifestyles – and it goes way beyond apparel.`
3. Default Meta Keywords: `yoga,exercise,apparel,clothing,working out,fitness`

Next, use the following for the `Venia Store US English` store view scope:

1. Default Page Title: `VENIA Official Online Store`
2. Default Meta Description: `With 50 stores spanning 40 states and growing, Venia is a nationally recognized high fashion retailer for women. We’re passionate about helping you look your best.`
3. Default Meta Keywords: `fashion,women,blouse,top,pant,dress,venia`

<a id="configure-reward-points"></a>
##### Configure Reward Points
In order to use Reward Points in an order, we need to ensure that Reward Points able to be earned for purchases and that a bi-directional Reward Exchange Rate is created.

1. Navigate to `Customers > Reward Points >  Actions for Acquiring Reward Points by Customers`
2. Set `Purchase` to `Yes`
3. Navigate to `Stores > Other Settings > Reward Exchange Rates`
4. Add a new rate for points to currency:
	1. `Website`: `Luma Website`
	2. `Customer Group`: `All Customer Groups`
	3. `Direction`: `Points to Currency`
	4. `Rate`: `1 / 1`
5. Add a new rate for currency to points:
	1. `Website`: `Luma Website`
	2. `Customer Group`: `All Customer Groups`
	3. `Direction`: `Currency to Points`
	4. `Rate`: `1 / 1`

<a id="general-content-updates"></a>
#### General Content Updates
In order for our meta changes to take effect, we need to add the same changes we made for the default meta information above to each home page (Luma and Venia respectively)

<a id="luma-home-page-us"></a>
##### Luma Home Page (US)
Navigate to `Content > Elements > Pages > Home Page`

1. Page Title: `Luma Home Page - US`
2. Search Engine Optimization:
	1. URL Key: `home`
	2. Meta Title: `LUMA Official Online Store`
	3. Meta Keywords: `yoga,exercise,apparel,clothing,working out,fitness`
	4. Meta Description: `With more than 230 stores spanning 43 states and growing, Luma is a nationally recognized active wear manufacturer and retailer. We’re passionate about active lifestyles – and it goes way beyond apparel.`
3. Page in Websites: `Luma Website > Luma Store > US English`

<a id="luma-home-page-de"></a>
##### Luma Home Page (DE)
Navigate to `Content > Elements > Pages > Home Page`

1. Page Title: `Luma Home Page - DE`
2. Search Engine Optimization:
	1. URL Key: `home`
	2. Meta Title: `Offizieller LUMA Online-Shop`
	3. Meta Keywords: `yoga,sport,bekleidung,kleidung,training,fitness`
	4. Meta Description: `Luma ist ein landesweit anerkannter Hersteller und Händler von Sportbekleidung mit über 230 Filialen in 43 Bundesstaaten. Ein aktiver Lebensstil ist unsere Leidenschaft – und das längst nicht nur in puncto Kleidung.`
3. Page in Websites: `Luma Website > Luma Store > Deutsch`

<a id="venia-home-page"></a>
##### Venia Home Page
Navigate to `Content > Elements > Pages > Home Page - Venia`

1. Page Title: `Venia Home Page - US`
2. Search Engine Optimization:
	1. URL Key: `home`
	2. Meta Title: `VENIA Official Online Store`
	3. Meta Keywords: `fashion,women,blouse,top,pant,dress,venia`
	4. Meta Description: `With 50 stores spanning 40 states and growing, Venia is a nationally recognized high fashion retailer for women. We’re passionate about helping you look your best.`
3. Page in Websites: `Luma Website > Luma Store > US English`

When done, refresh the cache.

<a id="customer-configuration"></a>
#### Customer Configuration
<a id="redirect-to-my-account"></a>
##### Redirect to My Account
Natively, when a customer logs in, they are redirected to the same page they were on when they triggered the log in action.  While this can be handy, typically, when logging in, our goal is to show the My Account area.  We can configure Magento to redirect a customer to their My Account area using the setting at:

`Stores > Settings > Configuration > Customers > Customer Configuration > Login Options > Redirect Customer to Account Dashboard after Logging in`: `Yes`

After saving, refresh cache.

<a id="set-up-saved-cards"></a>
##### Set Up Saved Cards
In order to show Instant Purchase, customers will need to have a Saved Card attached to their account.  We'll add one now for Sharon Reynolds.  As Sharon, create an order with the *Push It Messenger Bag*.  At checkout, use the following details:

1. Credit Card
2. CC Number: `4111111111111111`
3. Expiration Date: `01/23`
4. Card Verification Number: `123`
5. Save for later use: `Yes`

Optiona: Once you've placed the order, sign out as Sharon.  Next, find *Push It Messenger Bag* and add back the quantity you purchased.

<a id="marketing"></a>
#### Marketing

<a id="featured-products-on-home-page"></a>
##### Featured Products on Home Page

<a id="sale-category"></a>
##### Sale Category

<a id="customer-segments"></a>
##### Customer Segments

<a id="related-products-rules"></a>
##### Related Products Rules

<a id="promotions"></a>
##### Promotions

<a id="staging-and-preview-campaigns"></a>
##### Staging and Preview Campaigns

<a id="grids-setup"></a>
#### Grids Setup

<a id="product-grids"></a>
##### Product Grids

<a id="cms-blocks-grid"></a>
##### CMS Blocks Grid

<a id="cms-pages-grid"></a>
##### CMS Pages Grid

<a id="staging-and-preview-grid"></a>
##### Staging and Preview Grid

<a id="tools"></a>
#### Tools
<a id="cache-warmer-site-map"></a>
##### Cache Warmer (Site Map)
In order for the cache warmer(s) to function properly, we need to create an XML file for each store view which has products assigned to it.  In our case, that's one for Luma US, one for Venia US, and then a final one for our Custom US store views.  Navigate to `Marketing > SEO and Search > Site Map` and create the following:

1. Luma
	1. Filename: `luma.xml`
	2. Path: `/pub/`
	3. Store View: `Luma Website > Luma Store > US English`
2. Venia
	1. Filename: `venia.xml`
	2. Path: `/pub/`
	3. Store View: `Luma Website > Venia Store > US English`
3. Custom
	1. Filename: `custom.xml`
	2. Path: `/pub/`
	3. Store View: `Luma Website > Custom Store > Custom US English`

<a id="sc-theme-customizer"></a>
##### SC Theme Customizer


<a id="b2b-demo-cases"></a>
#### B2B Demo Cases

<a id="fixes"></a>
### Fixes

Sources: [CWeagans Composer Patching Plugin](https://github.com/cweagans/composer-patches/)

<a id="pickup-in-store-quantity-is-mis-aligned"></a>
#### Pickup In Store Quantity is Mis-Aligned
For some reason, the quantity statement in the Pick Up In Store Module overlay is mis-aligned and needs to be adjusted:

1. In `vendor/magentoese/module-instorepickup/view/frontend/web/js/templates/result.html`, on line 12, add CSS margin to move the "Available" string
2. Save with `Esc`, then `:wq` and `Enter`
3. Clear `pub/static` and the cache: `rm -rf pub/static && cache`

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


<a id="email-from-doesnt-show-properly"></a>
#### Email "From" Doesn't Show Properly

Sources: [Confirmation emails have no FROM or FROM email address 2.2.4 #14952](https://github.com/magento/magento2/issues/14952)
