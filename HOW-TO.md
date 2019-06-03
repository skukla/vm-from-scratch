# Magento Demo VM From Scratch

## Table of Contents
- [Building the VM](BUILDING-THE-VM.md)
- [Kukla VM Demo Setup](DEMO-SETUP.md)
- [Kukla VM and B2B, Multisite, and MSI](B2B.md)
- [How Do I...](HOW-TO.md)

# How Do I...

<!-- MarkdownTOC autolink="true" autoanchor="true" markdown_preview="github" -->

- [Install New Extensions](#install-new-extensions)
	- [Composer and What It Does](#composer-and-what-it-does)
	- [Custom Module Require Statements and Repositories](#custom-module-require-statements-and-repositories)
		- [Require Statements](#require-statements)
		- [Repositories](#repositories)
	- [Notes on Updating the Codebase](#notes-on-updating-the-codebase)
		- [VM Snapshots and Failed Cloud Tokens](#vm-snapshots-and-failed-cloud-tokens)
	- [Installing Extensions From the Solution Innovation Team](#installing-extensions-from-the-solution-innovation-team)
	- [Installing Extensions From a Third Party](#installing-extensions-from-a-third-party)
- [Add a New Language](#add-a-new-language)
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
<a id="require-statements"></a>
#### Require Statements
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
"paradoxlabs/tokenbase": "4.1.5.x-dev",
"paradoxlabs/subscriptions": "3.0.4.x-dev",
"paradoxlabs/authnetcim": "4.1.3.x-dev",
"paradoxlabs/firstdata": "2.1.2.x-dev",
"paradoxlabs/stripe": "2.1.3.x-dev"
```
<a id="repositories"></a>
#### Repositories
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
{"type": "git", "url": "git@gitlab.the1umastory.com:md/paradoxlabs-authnetcim.git"},
{"type": "git", "url": "git@gitlab.the1umastory.com:md/paradoxlabs-firstdata.git"},
{"type": "git", "url": "git@gitlab.the1umastory.com:md/paradoxlabs-stripe.git"},
{"type": "git", "url": "git@gitlab.the1umastory.com:md/paradoxlabs-subscriptions.git"},
{"type": "git", "url": "git@gitlab.the1umastory.com:md/paradoxlabs-tokenbase.git"},
{"type": "git", "url": "git@gitlab.the1umastory.com:md/paradoxlabs-tokenbase.git"}
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

<a id="installing-extensions-from-a-third-party"></a>
### Installing Extensions From a Third Party
*TODO*

<a id="add-a-new-language"></a>
## Add a New Language
*TODO*

<a id="use-the-vm-in-offline-mode"></a>
## Use the VM in Offline Mode
*TODO*