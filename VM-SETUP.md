# Magento Demo VM Documentation

## Table of Contents
- [VM Setup and Usage](VM-SETUP.md)
- [How Do I...](HOW-DO-I.md)
- [Building the VM](BUILDING-THE-VM.md)
- [Building the B2C Demo Cases](BUILDING-THE-B2C-DEMO-CASES.md)
- [Building the B2B, Multisite, and MSI Demo Cases](BUILDING-THE-B2B-MULTISITE-MSI-DEMO-CASES.md)

# VM Setup and Usage

<!-- MarkdownTOC autolink="true" autoanchor="true" markdown_preview="github" -->

- [Getting Started](#getting-started)
	- [Sublime Text 3](#sublime-text-3)
	- [iTerm 2](#iterm-2)
	- [Git \(via Xcode Command Line Tools\)](#git-via-xcode-command-line-tools)
- [The Cloud Extension](#the-cloud-extension)
- [VMWare Fusion](#vmware-fusion)
	- [Installing VMWare Fusion](#installing-vmware-fusion)
	- [Configuring VMWare Fusion](#configuring-vmware-fusion)
	- [Possible VMWare Issues](#possible-vmware-issues)
		- [A "/dev/vmmon" Error](#a-devvmmonerror)
- [Importing the VM File](#importing-the-vm-file)
- [The Hosts File](#the-hosts-file)
	- [Understanding the Hosts File](#understanding-the-hosts-file)
	- [Configuring the Hosts File](#configuring-the-hosts-file)
		- [Creating A Hosts File Alias](#creating-a-hosts-file-alias)
		- [Finding the Hosts Entry](#finding-the-hosts-entry)
	- [Updating the Hosts File](#updating-the-hosts-file)
	- [Testing the VM](#testing-the-vm)
	- [Possible Hosts File Issues](#possible-hosts-file-issues)
- [Saving the Base State Snapshot](#saving-the-base-state-snapshot)
- [Using Snapshots](#using-snapshots)
	- [Using Snapshots As Branches](#using-snapshots-as-branches)
		- [Everything Starts From the Base State](#everything-starts-from-the-base-state)
		- [Create the Custom Demo Branches](#create-the-custom-demo-branches)
		- [Updating the Base State Snapshot](#updating-the-base-state-snapshot)
- [VM and SSH](#vm-and-ssh)

<!-- /MarkdownTOC -->

<a id="getting-started"></a>
## Getting Started
Before we begin with VM installation, there are some tools you should download first:

<a id="sublime-text-3"></a>
### Sublime Text 3 
Text Editor which allows administrative access to system files which we'll need later.  This is required. 

[Download Sublime Text 3](https://www.sublimetext.com/3)

The primary purpose for using Sublime Text will be to edit your system's `hosts` file.  In order to open the `hosts` file with Sublime, it is recommended that you take the following approach:

1. Open Sublime Text 3
2. Right-click the Sublime Text 3 icon in the dock, and select `Options > Keep In Dock`

<a id="iterm-2"></a>
### iTerm 2
Terminal replacement for MacOS.  This is optional.

[Download iTerm 2](https://www.iterm2.com/downloads.html)

<a id="git-via-xcode-command-line-tools"></a>
### Git (via Xcode Command Line Tools)
Version Control System.  This is optional.  

To install:
1. Open a terminal on your Mac (Cmd+Spacebar, then type "Terminal")
2. In terminal, enter: `git --version`, then `Enter`. You'll be prompted to install the Command Line Tools -- follow the prompts to continue

<a id="the-cloud-extension"></a>
## The Cloud Extension
The Cloud Extension is an extension for Google Chrome developed by Keith Bentrup. It is a helpful tool for demo preparation and management and is necessary for more advanced VM usage.  To install it, use the steps detailed here:
 
[Magento Cloud Extension Information](https://github.com/PMET-public/magento-cloud-extension)

[Download the Magento Cloud Extension](https://github.com/PMET-public/magento-cloud-extension/releases)

**Note:** Even though it's listed as an "Alpha" version, you'll need to install version 0.0.25 or higher of the extension in order to work with the VM.

<a id="vmware-fusion"></a>
## VMWare Fusion
All we’ll need to use this solution is a hypervisor called VMWare Fusion. This is provided by Adobe via the App Catalog.

<a id="installing-vmware-fusion"></a>
### Installing VMWare Fusion
To Install VMWare Fusion:

1. Click on the App Catalog icon in the bottom right hand corner of your dock
2. Search for VMWare
3. Click on VMWare Fusion in the results
4. Click on Install and wait for a bit – there is no progress indicator
5. After some time, check your Applications folder to see if VMWare Fusion has been installed
6. Once you notice that it has been installed, reboot your system
7. After rebooting, launch VMWare Fusion and choose "Check for Updates" from the VMWare Fusion Apple menu
8. Install any updates found if the application allows you to do so.  If it provides a "Learn More" button instead, ignore the update step entirely.

<a id="configuring-vmware-fusion"></a>
### Configuring VMWare Fusion
Here are some recommended preferences for VMWare that others have found helpful:

1. Open VMWare Fusion
2. Navigate to: VMWare Fusion > Preferences
3. For the "When closing a virtual machine" setting, select: Power off the virtual machine
4. Tick the Confirm before closing checkbox

**Note:** These settings do two important things.  The first change ensures that the VM will be powered off completely rather than suspended when it is closed.  The second change allows an SC to close the VM terminal without shutting down the VM itself.  To use, close the VM terminal and note the dialog which allows you to *Run in Background* or  *Power Off* as desired.

<a id="possible-vmware-issues"></a>
### Possible VMWare Issues
The installation process should run smoothly; however, there are some known issues that some folks have encountered and some solutions for them:

<a id="a-devvmmonerror"></a>
#### A "/dev/vmmon" Error
This issue is ultimately caused by the fact that a particular VMWare Fusion component does not have permission to run on your machine.  To solve:

1. Open System Preferences and navigate to Security & Privacy
2. Select the General tab (Privacy may be selected by default) There should be an indication near the bottom of the window that suggests something was blocked from installing or running.
3. Click the lock in the lower left to make changes
4. Allow the application/component to be installed (Eventually, you'll see VMWare in a list)

**Note:** Once done, you'll need to restart your machine for the changes to take effect.

<a id="importing-the-vm-file"></a>
## Importing the VM File
VMs are be packaged as .ova (Open Virtualization Archive) files. These files are glorified .zip files that combine several files used by the VM into one.

To import a new VM file:

1. Open VMWare Fusion
2. Choose File > Import
3. Choose your .ova file and click Continue
4. When the machine is imported, click Continue
5. Start the VM. If asked to upgrade, click *Upgrade*

<a id="the-hosts-file"></a>
## The Hosts File
<a id="understanding-the-hosts-file"></a>
### Understanding the Hosts File
As you may already know, when a person uses a web browser to access something on the web, they enter an address for what they're trying to find.  Typically, this address has been mapped to a user-friendly domain -- something like https://magento.com, for example.  Tied to the user-friendly domain is a machine-friendly Internet Protocol (IP) address -- in the case of https://magento.com, the IP address is: 34.203.65.223. Since the VM is essentially another computer (a "guest) which is using the resources of the computer on which its running (the "host"), the VM has its own IP address.  The web server inside the VM which powers the Magento application is mapped to a specific domain name by default which is http://luma.com. This is great for demo purposes as it helps with the illusion that Luma is an actual brand.  However, if we were to browse to http://luma.com, we'd see our challenge: http://luma.com is an actual domain on the internet which points to an IP of 208.91.197.128.  To use it for our demos, we'll need a way to tell our browser that we want to re-route the request for http://luma.com. We need to change the IP mapping from the actual IP of 208.91.197.128 to our VM's IP. 
 
Enter the hosts file.
 
The hosts file is a system file on our machine which can intercept requests from our browser and map them to IP addresses that we specify. We can even send a request for multiple domains (e.g. http://luma.com and http://b2b.luma.com) to the same IP address to be processed by the web server there.

<a id="configuring-the-hosts-file"></a>
### Configuring the Hosts File

<a id="creating-a-hosts-file-alias"></a>
#### Creating A Hosts File Alias
First, we need to find our hosts file and create an alias for it which we can move to our Desktop.  This will make it easier to find and update in the future.

1. Open a new Finder window
2. In the Finder's "File" menu bar at the absolute top of the screen, look for the "Go" menu
3. Navigate to Go > Go To Folder
4. In the dialog, enter: /etc and press Enter
5. In the search bar, search for: hosts
6. Change the search location from This Mac to /etc
7. Right-click on the hosts file which should be the first item in the list and choose Make Alias
8. Enter your computer password
9. Drag the hosts alias file to your Desktop (the original hosts alias file will remain in the list, this is expected behavior)
10. Click on the hosts alias file in the list and delete it by pressing Cmd+Delete. Enter your computer password when prompted.
11. Confirm the hosts alias file is on your Desktop

<a id="finding-the-hosts-entry"></a>
#### Finding the Hosts Entry
Next, we need to find out what our VM's IP address is.

1. Log in to the VM operating system using the VM terminal window provided by VMWare Fusion:

```
Username: vagrant
Password: vagrant
```

In the first section, note the Host Entry line which should look something like:

```
172.16.234.128    luma.com b2b.luma.com custom-demo.com b2b.custom-demo.com
```

Here  we see the IP address of the VM and the various domains which should be re-routed to it when accessed via a browser.

**Note:** Your IP address will be different than the one listed above.

<a id="updating-the-hosts-file"></a>
### Updating the Hosts File
Now that we have a hosts file alias, we'll use Sublime Text to update it:

1. Find the hosts file alias on your Desktop
2. Drag the alias icon onto the Sublime Text 3 icon in your dock
3. The file should open and the first 9 lines look something like this:

```
##
# Host Database
#
# localhost is used to configure the loopback interface
# when the system is booting.  Do not change this entry.
##
127.0.0.1    localhost
255.255.255.255    broadcasthost
::1             localhost
```

At the bottom of the file, add the Hosts Entry from the VM which should be formatted as referenced above. Specifically:

1. Use a tab between the IP address and the domain(s)
2. Use spaces to separate multiple domains

When done, save the hosts file and enter your computer password when prompted.

<a id="testing-the-vm"></a>
### Testing the VM
If the VM is running, you can test these changes by opening a browser and navigating to http://luma.com for the storefront and http://luma.com/admin for the admin panel.  Use the following credentials to log in to the admin panel:

Username: admin
Password: admin4tls

Note: Since the Magento application depends heavily on browser cache, you may want or need to quit chrome and then open it in incognito mode to ensure everything is as it should be.

<a id="possible-hosts-file-issues"></a>
### Possible Hosts File Issues
Issues with the hosts file are the most common source of VM-related problems.  The most tell-tale sign that you have a hosts file issue is the fact that when you attempt to open http://luma.com

1. The browser loads the actual http://luma.com site
2. The browser "spins" and ultimately doesn't load.  (You can confirm this is the case by paying attention to the bottom left-hand corner of the browser window.  If you see "Connecting..." instead of "Waiting for luma.com...", you most likely have a hosts file issue.

<a id="saving-the-base-state-snapshot"></a>
## Saving the Base State Snapshot
At this point, provided you can load both the storefront and admin panel successfully, you have completed the initial VM setup. Next, we'll use VMWare Fusion's "snapshot" functionality to save a snapshot of the working VM so that we can always return to this working version of what we've created.  We'll touch on using snapshots more in an uncoming section.  For now, let's create a "Base State" snapshot:

1. Open VMWare Fusion
2. If a VM is currently running, we need to shut it down.  To do this:
	1. In the VMWare Fusion "File" menu, find the "Virtual Machine" menu
	2. Choose "Shut Down"
	3. You can also shut down the VM by clicking the red circle in the top left-hand corner of the VM Terminal window and choosing *Power Off*.  **Note:** You'll know the VM is powered off completely when the VM terminal window shows a large *Play* button.
3. With the VM powered down, we'll open the *Snapshots* UI:
	1. In the VMWare Fusion *File* menu, find the *Virtual Machine* menu
	2. Navigate to *Snapshots...*  **Note:** You can also reach this screen by clicking on the *Snapshot* icon in the VM Terminal window. To find this icon, look for the red, yellow, and green screen magnification buttons in the left-hand corner of the window.  The next button to the right is a small *Play* icon which starts the VM.  The button to the right of that looks like a polaroid with a clock.  This is the *Snapshot* icon.
4. In the Snapshots UI, find the camera icon next to the green *Full Screen* button in the top left-hand corner of the window.  Click the icon to take a snapshot.
5. Give the snapshot a name of *Base State* (or something similar that works for you) and click *Take*.

When done, close the Snapshot UI.

<a id="using-snapshots"></a>
## Using Snapshots
Snapshots are an incredibly useful feature provided by VMWare Fusion.  They allow SC's to essentially "save" their work by saving a version of the VM's current state and then allowing an SC to continue working on that saved state.  Using snapshots, SC's can create simple or complex branching structures which they can use to build custom demos. Snapshots can be easily restored, modified, or removed as needed.

<a id="using-snapshots-as-branches"></a>
### Using Snapshots As Branches
Here's an example of how one might consider using snapshots to create two unique custom demos:

<a id="everything-starts-from-the-base-state"></a>
#### Everything Starts From the Base State
Your Base State is meant to be your starting point for every demo you give. With that in mind, we'll make sure that our VM's current state is in line with our base state by restoring our base state snapshot.  To do this:

1. Make sure that the VM is powered off
2. Right-click on the Base State snapshot
3. Choose *Restore Snapshot*
4. Now we can be sure we're on our correct starting point.

<a id="create-the-custom-demo-branches"></a>
#### Create the Custom Demo Branches
To keep everything clear, we'll continue by creating two distinct branches from our Base State starting point -- one for each custom demo we want to build.  Let's say we have two prospects, *Prospect 1* and *Prospect 2*, respectively. We'll create a new snapshot from Base State for each of these:

1. With Current State highlighted, click the camera icon to create a new snapshot
2. Name it *Prospect 1 Start* and click *Take*
3. Right-click on Base State and click *Restore Snapshot* When asked if you want to save, choose *Don't Save* (Note the switch that happens here)
4. Repeat steps 1 and 2, but this time, name the snapshot "Prospect 2 Start"

Now, you should have two distinct branches for two different prospects and each prospect branch can now be further branched as many times as you'd like, allowing you to save your work as you go.

When you finish with a particular prospect's demo, you can then delete the entire branch of snapshots (since each snapshot takes up space on your host machine).  To do this, click the first snapshot in the branch and then shift+click each subsequent branch you'd like to include for deletion.  When you've selected all of them, right click on any of the selected snapshots and click *Delete Snapshot*.  All selected snapshots should be deleted.

<a id="updating-the-base-state-snapshot"></a>
#### Updating the Base State Snapshot
From time to time, you may find that you're making the same configuration changes for all of your custom demos.  If this happens, you may want to consider updating your Base State snapshot to include those changes.  To update the Base State snapshot:

1. Make sure the VM is powered off
2. Restore the existing Base State snapshot
3. Make the changes you want to add to the snapshot
4. Take a new Snapshot with the camera icon and name it "Base State 2"
5. Delete the original Base State snapshot
6. Right-click the "Base State 2" snapshot and choose "Get Info"
7. Modify the name to "Base State" and save

Now you should have a Base State snapshot with the changes you added ready to go.

<a id="vm-and-ssh"></a>
## VM and SSH
From time to time, it will be necessary to access the VM's operating system so that you can manage aspects of the Magento application which can only done from the command line.  These actions might include things like forcing a reindex to see a new category or product, clearing cache, running a cron job, or installing extensions for custom demos.

To access the inner workings of the VM from your terminal, we'll use something called Secure Shell (SSH).  The Cloud Extension we installed earlier makes this process extremely easy and straightforward:

1. Power on the VM
2. Load the Magento storefront in your browser: http://luma.com
3. Click the Magento Cloud extension icon in chrome to use the extension
4. Click the *Commands* tab
5. Find the grey box titled *VM specific cmds*
6. Click the *copy* icon next to the *SSH into VM* command
7. Open a terminal on your system
8. Open Spotlight with `Command + Spacebar`
9. Search for Terminal and press `Enter`
10. Paste the output of the command you copied into the terminal and press `Enter`
11. Here's an example of what it should look like:

```
bash -c "$(curl -sS https://raw.githubusercontent.com/PMET-public/magento-cloud-extension/0.0.25/sh-scripts/lib.sh        https://raw.githubusercontent.com/PMET-public/magento-cloud-extension/0.0.25/sh-scripts/ssh.sh | env ext_ver=0.0.25 tab_url=http://luma.com bash)"
```

When you press `Enter`, upon into the VM for the first time, you will be prompted with:

```
The authenticity of host ‘luma.com (172.16.234.128)’ can’t be established.
ECDSA key fingerprint is SHA256:tPs1894RmUqQilp5qkZGuMfCRHjlK6W0vEP2oMpDB3E.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added ‘luma.com,172.16.234.128’ (ECDSA) to the list of known hosts.
```

Once done, you'll be greeted with the VM's welcome screen which will offer you additional commands you can use. 
