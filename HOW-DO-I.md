# Magento Demo VM Documentation

## Table of Contents
- [VM Setup and Usage](VM-SETUP.md)
- [How Do I...](HOW-DO-I.md)
- [Building the VM](BUILDING-THE-VM.md)
- [Building the B2C Demo Cases](BUILDING-THE-B2C-DEMO-CASES.md)
- [Building the B2B, Multisite, and MSI Demo Cases](BUILDING-THE-B2B-MULTISITE-MSI-DEMO-CASES.md)

# How Do I...

<!-- MarkdownTOC autolink="true" autoanchor="true" markdown_preview="github" -->

- [Install New Extensions](#install-new-extensions)
	- [Composer and What It Does](#composer-and-what-it-does)
	- [Custom Module Require Statements and Repositories](#custom-module-require-statements-and-repositories)
		- [Accorin \(B2B\)](#accorin-b2b)
		- [Amasty](#amasty)
		- [MSI](#msi)
		- [Page Builder Additions](#page-builder-additions)
		- [Paradox Labs](#paradox-labs)
	- [Notes on Updating the Codebase](#notes-on-updating-the-codebase)
		- [VM Snapshots and Failed Cloud Tokens](#vm-snapshots-and-failed-cloud-tokens)
	- [Installing Extensions From the Solution Innovation Team](#installing-extensions-from-the-solution-innovation-team)
		- ['Cannot Update Repo' Error](#cannot-update-repo-error)
	- [Installing Extensions From a Third Party](#installing-extensions-from-a-third-party)
- [Add a New Language](#add-a-new-language)
- [Configure the VM With A Static IP](#configure-the-vm-with-a-static-ip)
- [Renew IP Leases](#renew-ip-leases)
- [Use the VM in Offline Mode](#use-the-vm-in-offline-mode)

<!-- /MarkdownTOC -->


<a id="install-new-extensions"></a>
## Install New Extensions
One of the primary benefits to using the VM is that new functionality can be added and removed as you, the SC, see fit.  Depending on the extension you're adding (whether it comes from the Solution Innovation team or a third-party), the process is still relatively simple.

<a id="composer-and-what-it-does"></a>
### Composer and What It Does
Before we get into installing extensions, it would be beneficial to understand how composer and Magento work together, since composer is the primary tool we use for downloading new modules for the platform.

Modern software platforms like Magento 2 are built in a modular fashion -- each feature of the platform is, essentially, self-contained in its own module.  The module has all the necessary components it needs to hook into the admin panel and display on the storefront, etc.  When developers ship their applications, they often store them in a collection of git repositories.  When merchants install and deploy the applications, they'll use a "package manager" -- a tool which receives instructions about where to find an application's packages (or modules), instructions about which modules are required by other modules and so on.

Composer is a PHP package manager. PHP application developers use it to deploy their applications and define dependencies between their applications' modules.  Each application written for deployment and management via composer uses a "master" file to define which modules are to be included, their versions, their dependencies, and so on.  Further, each module used in the application has its *own* `composer.json` file which is responsible for defining specific details about that module and how it should behave with other modules in the application as a whole.

_TODO: Finish this_ 

<a id="custom-module-require-statements-and-repositories"></a>
### Custom Module Require Statements and Repositories

<a id="accorin-b2b"></a>
#### Accorin (B2B)
**Require Statements**
```
"accorin/module-orderapprovals": "dev-master",
"accorin/module-companyaddressbook": "dev-master"
```
**Repositories**
```
{"type": "git", "url": "git@gitlab.the1umastory.com:md/module-accorin-orderapprovals.git"},
{"type": "git", "url": "git@gitlab.the1umastory.com:md/module-accorin-companyaddressbook.git"}
```

<a id="amasty"></a>
#### Amasty
**Require Statements**
```
"amasty/base": "1.5.5.x-dev",
"amasty/blog": "1.3.4.x-dev",
"amasty/duplicatecategories": "1.0.4.x-dev",
"amasty/geoip": "1.3.7.x-dev",
"amasty/groupcat": "1.5.9.x-dev",
"amasty/module-advanced-conditions":"1.3.10.x-dev",
"amasty/module-banners-lite":"1.0.4.x-dev",
"amasty/module-salesrulewizard": "dev-master",
"amasty/module-special-promo": "2.7.3.x-dev",
"amasty/module-special-promo-pro": "2.7.6.x-dev",
"amasty/module-store-locator": "1.12.4.x-dev",
"amasty/product-attachment": "1.3.3.x-dev",
"amasty/promo": "2.4.0.x-dev",
"amasty/rgrid": "1.0.7.x-dev",
```
**Repositories**
```
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
{"type": "git", "url": "git@gitlab.the1umastory.com:md/amasty-module-salesrulewizard.git"},
{"type": "git", "url": "git@gitlab.the1umastory.com:md/amasty-module-special-promotions-pro.git"},
{"type": "git", "url": "git@gitlab.the1umastory.com:md/amasty-module-special-promotions.git"},
{"type": "git", "url": "git@gitlab.the1umastory.com:md/amasty-module-store-locator.git"},
```

<a id="msi"></a>
#### MSI
**Require Statements**
```
"magento/module-msi-inventory-sample-data": "dev-master",
"magento/module-msi-source-stock-sample-data": "dev-master",
"magentoese/module-msi-inventory-sample-data-demo":  "dev-master",
```
**Repositories**
```
{"type": "git", "url": "git@github.com:PMET-public/module-msi-inventory-sample-data-demo.git"},
{"type": "git", "url": "git@github.com:PMET-public/module-msi-inventory-sample-data.git"},
{"type": "git", "url": "git@github.com:PMET-public/module-msi-source-stock-sample-data.git"},
```

<a id="page-builder-additions"></a>
#### Page Builder Additions
**Require Statements**
```
"davemacaulay/module-page-builder-grid": "dev-master",
"example/module-page-builder-faq": "dev-master",
"example/module-page-builder-quote": "dev-master",
"example/module-page-builder-extension-banner": "dev-master",
"example/module-page-builder-extension-base-forms": "dev-master",
"example/module-page-builder-extension-slider": "dev-master",
"example/module-page-builder-extension-text": "dev-master",
```
**Repositories**
```
{"type": "git","url": "git@github.com:bdenham/page-builder-quote.git"},
{"type": "git","url": "git@github.com:davemacaulay/module-page-builder-grid.git"},
{"type": "git","url": "https://github.com/PMET-public/module-page-builder-extension-banner.git"},
{"type": "git","url": "https://github.com/PMET-public/module-page-builder-extension-base-forms.git"},
{"type": "git","url": "https://github.com/PMET-public/module-page-builder-extension-slider.git"},
{"type": "git","url": "https://github.com/PMET-public/module-page-builder-extension-text.git"},
{"type": "git","url": "https://github.com/PMET-public/module-page-builder-faq.git"}
```

<a id="paradox-labs"></a>
#### Paradox Labs
**Require Statements**
```
"paradoxlabs/tokenbase": "4.2.1.x-dev",
"paradoxlabs/subscriptions": "3.1.0.x-dev"
"paradoxlabs/authnetcim": "4.2.1.x-dev",
"paradoxlabs/firstdata": "2.2.0.x-dev",
"paradoxlabs/stripe": "2.2.0.x-dev",       
```
**Repositories**
```
{"type": "git", "url": "git@gitlab.the1umastory.com:md/paradoxlabs-authnetcim.git"},
{"type": "git", "url": "git@gitlab.the1umastory.com:md/paradoxlabs-firstdata.git"},
{"type": "git", "url": "git@gitlab.the1umastory.com:md/paradoxlabs-stripe.git"},
{"type": "git", "url": "git@gitlab.the1umastory.com:md/paradoxlabs-subscriptions.git"},
{"type": "git", "url": "git@gitlab.the1umastory.com:md/paradoxlabs-tokenbase.git"},
{"type": "git", "url": "git@gitlab.the1umastory.com:md/paradoxlabs-tokenbase.git"},
```

<a id="notes-on-updating-the-codebase"></a>
### Notes on Updating the Codebase
As of this writing (2/25/19), there have been changes made to the Solution Innovations team's gitlab account which have placed it behind a firewall.  As such, updates to the Cloud Extension have been added to aid SCs in accessing the Solution Innovations team's code. As a pre-requisite, make sure you have at least version `0.0.25` of the extension installed and `kukla-vm.0.0.2.ova` imported inthe VMWare.

<a id="vm-snapshots-and-failed-cloud-tokens"></a>
#### VM Snapshots and Failed Cloud Tokens
Whenever you restore a snapshot and then try to upgrade or add new code via composer, the cloud login token will become invalid.  Unforunately, there's no way to *prevent* this at present; however, there *is* a pretty simple work-around.  If the cloud token is invalid, simply use the `cloud-login` command and re-authenticate with your cloud username and password.  The login will **fail** the first time you do it -- _this is unfortunate but expected_. Log in a second time using the same command and you should be able to proceed with composer activities as expected.

<a id="installing-extensions-from-the-solution-innovation-team"></a>
### Installing Extensions From the Solution Innovation Team
Use the following steps to install extensions:

1. Find the require statement of the extension you want to install from the list of require statements above: [Extensions List](https://github.com/skukla/vm-from-scratch/blob/master/HOW-TO.md#require-statements)
2. Open a finder window
3. Under _Locations_ on the left side, choose `luma`
4. Double-click into the `web root` folder
5. Right-click on `composer.json` and edit with Sublime (or your favorite code editor)
6. Find the end of the Require block (mine goes from lines 12-85)
7. Add a comma to the end of the last require statement, then add the lines of the extensions you want to add on new lines beneath.  The last line of the require block should not have a comma
For example, for the subscriptions module, you need these two require statements:
```
"paradoxlabs/tokenbase": "4.1.5.x-dev",
"paradoxlabs/subscriptions": "3.0.4.x-dev"
```
8. Save the file
9. Use the chrome extension and find the single, VM-specific command `SSH into VM` and copy it
10. Open a terminal window on your mac (`cmd+spacebar`, type `terminal`, press `Enter`)
11. Paste in the command and press `Enter`. You should be ssh'd into the VM at this point
12. Log in to the Magento Cloud CLI using `cloud-login` (Enter your username and password for Magento cloud at the prompts).  It will throw an error, but never fear.  Use the same `cloud-login` command again and repeat the process.  You should then be logged in.
13. Run the `upgrade` command

<a id="cannot-update-repo-error"></a>
#### 'Cannot Update Repo' Error
From time to time, even using the chrome extension, you _may_ run into a particular set of errors which indicate that certain gitlab repositories can't be updated and that some repositories may be outdated.  If this happens, it means that the gitlab SSH key needs to be re-added to the SSH agent. To achieve this, you can:

1. Use `Ctrl-C` to stop the currently running command
2. Exit the SSH session typing `exit`
3. Re-paste the VM ssh command from the chrome extension
4. Use `configure-proxy && disable-cron && clear-cron-schedule && update-composer && add-modules && enable-cron` to proxy to gitlab, clear the cron schedule database table, install the modules, re-enable all cache, and re-enable cron

<a id="installing-extensions-from-a-third-party"></a>
### Installing Extensions From a Third Party
*TODO*

<a id="add-a-new-language"></a>
## Add a New Language
*TODO*

<a id="configure-the-vm-with-a-static-ip"></a>
## Configure the VM With A Static IP
As you continue to download and install new VM .ova files, you may run into the scenario whereby you run out of assignable IP addresses.  In addition, you may find it more advantageous and easier to manage your `hosts` file with a single, static IP rather than always checking for a dynamically-assigned one.  To use a static IP, you can:

1. Open VMWare Fusion
2. Select the VM from the VM list in the VM Library
3. Navigate to: `Virtual Machine > Settings > System Settings > General` and taking note of the `Name` value.  **Note** Your VM name cannot use any spaces.  If it does, edit it and remove them
4. Navigate to: `Virtual Machine > Network Adapter > Settings` (See the very bottom of the menu)
5. `Share With My Mac` will be selected.  At the bottom of the list, expand the carrot next to `Advanced Options`
6. Copy the VM's MAC Address.  (It will look something like this: `00:0C:29:C3:04:70`)
7. Turn off your VM and quit the VMWare Fusion program entirely
7. Open a new Finder window
8. Navigate to `Go > Go To Folder`
9. Enter the following path: `/Library/Preferences/VMware Fusion/vmnet8` and press `Enter`
10. Edit the `dhcp.conf` file in Sublime Text (Drag the file onto the Sublime Text icon similarly to what's done to edit your `hosts` file)
10. In this file, you will find a line defining a range of IPs this VM instance is configured to use dynamically:

```
range 172.16.100.128 172.16.100.254;
```

In this example, we can see that our dynamic range starts at `172.16.100.128` and goes up from there.  This means that we can assign any value from `172.16.100.1` to `172.16.100.127` as a static value for this VM.

11. At the bottom of the file, find the following line:

```
####### VMNET DHCP Configuration. End of "DO NOT MODIFY SECTION" #######
```

Beneath it, we will add a directive to create a static IP which will follow this format

```
host <YOUR VM NAME> {
    hardware ethernet <YOUR MAC ADDRESS>
    fixed-address  <YOUR STATIC IP>;
}
```

Use this format to add your own fixed IP address. As an example, supposing your machine was called `KuklaVM`, your MAC address was `00:0C:29:C3:04:70`, your dynamic IP range was between `172.16.100.127` and `172.16.100.254`, your host block might look like this:

```
host KuklaVM {
    hardware ethernet 00:0C:29:C3:04:70
    fixed-address  172.16.100.80;
}
```

12. Save the file -- Sublime will prompt you for your Mac password
13. Restart VMWare Fusion and your VM
14. Log in to the VM and note that your `Hosts Entry` line should reflect the static IP you defined above
15. Make sure you update your `/etc/hosts` file accordingly

Sources: [Assign Static IP Addresses in VMware Fusion](https://one.vg/static-ip-addresses-in-vmware-fusion/)

<a id="renew-ip-leases"></a>
## Renew IP Leases
If you're using dynamic IP assignment in VMWare Fusion, you'll notice that each new VM you create (whether a linked clone or an import of a new .ova file) updates your IP address -- usually incrementing it by one (e.g. if you have a VM with an IP address of `172.16.100.125` and you add a new clone or a new VM file, the new IP will likely be `172.16.100.126`). As you delete clones and VMs, these dynamically-assigned IP addresses should be released such that they are able to be recycled.  In the (very unlikely) event that they are not and/or some other conflict occurs, it _is_ possible to manually refresh the IP leases and effectively "reset" the IP list.  To do so:

1. If VMWare Fusion is running, shut down any running VMs and then quit the program
2. Open a new Finder window
3. Navigate to `Go > Go To Folder` and paste in the following path: `/var/db/vmware/`
5. Delete the following files: `vmnet-dhcpd-vmnet8.leases` and `vmnet-dhcpd-vmnet8.leases~` respectively (VMWare Fusion should recreate these)
6. Navigate to `Go > Go To Folder` and paste in the following path: `/Library/Preferences/VMware Fusion/` and open the `networking` file using Sublime
7. In this file, you should notice a line similar to this one:

```
answer VNET_8_DHCP_CFG_HASH 4FA179C6B5222481B3D0A97D6B0D49A555659324
```

8. Delete this line and save the file (**Note** `VMNET_8` here refers to the NAT network adapter.  You'll use a different, corresponding `VMNET` value if you're using a different adapter)
9. Restart VMWare Fusion

Sources: [Renewing IP Leases In VMWare Fusion](https://communities.vmware.com/message/2738585#2738585) (See the 3rd and 4th reponses)

<a id="use-the-vm-in-offline-mode"></a>
## Use the VM in Offline Mode
*TODO*