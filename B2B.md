# Magento Demo VM From Scratch

## Table of Contents
- [Building the VM](BUILDING-THE-VM.md)
- [Kukla VM Demo Setup](DEMO-SETUP.md)
- [Kukla VM and B2B, Multisite, and MSI](B2B.md)
- [How Do I...](HOW-TO.md)

# Kukla VM and B2B, Multisite, and MSI

<!-- MarkdownTOC autolink="true" autoanchor="true" markdown_preview="github" -->

- [B2B Configuration](#b2b-configuration)
	- [Add B2B URL to VM Hosts File](#add-b2b-url-to-vm-hosts-file)
	- [Create A B2B Site Map](#create-a-b2b-site-map)
	- [Enable B2B Modules](#enable-b2b-modules)
	- [Payment on Account](#payment-on-account)
- [Creating the Luma B2B Website](#creating-the-luma-b2b-website)
	- [Adding the Luma B2B Website](#adding-the-luma-b2b-website)
	- [Configuring the Luma B2B Website](#configuring-the-luma-b2b-website)
		- [Updating the Luma Website for B2C](#updating-the-luma-website-for-b2c)
		- [Configuring CMS Content for Luma B2B](#configuring-cms-content-for-luma-b2b)
		- [Configuring the URLs](#configuring-the-urls)
		- [Adding the Virtual Host](#adding-the-virtual-host)
		- [Configuring the Virtual Host](#configuring-the-virtual-host)
	- [Adding Custom Websites](#adding-custom-websites)
		- [Re-assigning Custom Stores to the Custom Websites](#re-assigning-custom-stores-to-the-custom-websites)
		- [Creating Additional Site Definitions and Virtual Hosts](#creating-additional-site-definitions-and-virtual-hosts)
		- [Adding Custom Sites to the Cache Warmer](#adding-custom-sites-to-the-cache-warmer)
- [B2B Demo Cases](#b2b-demo-cases)
	- [Customers](#customers)
	- [Sales Representative Role and User](#sales-representative-role-and-user)
	- [Companies](#companies)
		- [Terra Outfitters](#terra-outfitters)
		- [Emily's Exercise Emporium](#emilys-exercise-emporium)
	- [Buyer Users](#buyer-users)
	- [Buyer Teams](#buyer-teams)
	- [Buyer Roles and Permissions](#buyer-roles-and-permissions)
	- [B2B Autofill](#b2b-autofill)
	- [Company Content](#company-content)
		- [Terra Welcome Message Widget](#terra-welcome-message-widget)
	- [Company User Segments](#company-user-segments)
	- [Catalogs](#catalogs)
	- [B2B Call-outs](#b2b-call-outs)
	- [Home Page Updates](#home-page-updates)
	- [B2B Staging Updates](#b2b-staging-updates)
	- [B2B - B2C Menu Connection](#b2b---b2c-menu-connection)
- [Multi-source Inventory](#multi-source-inventory)
	- [Creating Sources](#creating-sources)

<!-- /MarkdownTOC -->

<a id="b2b-configuration"></a>
## B2B Configuration

<a id="add-b2b-url-to-vm-hosts-file"></a>
### Add B2B URL to VM Hosts File
In order for things like the cache warmer to work, we'll need to add the hostname we choose for the B2B Website to the `/etc/hosts` file.

1. `sudo vim /etc/hosts`
2. `Shift+A` to move to the end of the `luma.com` line
3. Add a space and then `b2b.luma.com` to the end of the `luma.com` line

<a id="create-a-b2b-site-map"></a>
### Create A B2B Site Map
TBD

<a id="enable-b2b-modules"></a>
### Enable B2B Modules
To use the B2B features, we'll need to enable them first:

Navigate to: `Stores > Settings > Configuration > General > B2B Features`

**Note:** If you're using the multi-website approach, set these settings at the website scope level for the Luma B2B Website.

1. Enable Company: `Yes`
2. Enable Shared Catalog: `No` (We'll leave this disabled for now until the product team fixes it properly -- expected in 2.3.1)
3. Enable B2B Quote: `Yes`
4. Enable Quick Order: `Yes`
5. Enable Requisition List: `Yes`

<a id="payment-on-account"></a>
### Payment on Account
By default, the Payment on Account method used to deduct a purchase amount from company credit is disabled and needs to be enabled before it can be used.  To enable it:

Navigate to `Stores > Settings > Configuration > Sales > Payment Methods`

**Note:** If you're using the multi-website approach, set these settings at the website scope level for the Luma B2B Website.

1. Payment on Account > Enabled: `Yes`
2. Save the payment method

When saved, clear the cache

<a id="creating-the-luma-b2b-website"></a>
## Creating the Luma B2B Website
In order to realistically and effectively show Magento's B2B capabilities, we'll convert Luma into a B2C and B2B merchant by adding a B2B website.  This helps with a few things -- first, it elegantly demonstrates multi-site capabilities beyond the shared cart scenario that Venia provides.  Second, it helps us get around the need to avoid shared catalogs; we can simply apply those cases to the separated website.  And third, it allows us to tell a B2B story without using a copy or snapshot of the VM.

<a id="adding-the-luma-b2b-website"></a>
### Adding the Luma B2B Website
First, we'll need to create the website, store, and store views we'll use for B2B.

Navigate to: `Stores > Settings > All Stores`

1. `Create Website`
2. Website Information:
	1. Name: `Luma B2B Website`
	2. Code: `base_b2b`
	3. Sort Order: `5`
3. Save the website
4. `Create Store`
5. Store Information:
	1. Website: `Luma B2B Website`
	2. Name: `Luma B2B Store`
	3. Code: `luma_b2b_store`
	4. Root Category: `Luma Catalog`
6. Save the store
7. `Create Store View`
8. Store View Information:
	1. Store: `Luma B2B Store`
	2. Name: `US English`
	3. Code: `default_b2b`
	4. Status: `Enabled`
	5. Sort Order: `0`
9. Save the store view

Next, let's add a B2B German store view for the Luma B2B Store:

1. `Create Store View`
2. Store View Information:
	1. Store: `Luma B2B Store`
	2. Name: `Deutsch`
	3. Code: `luma_b2b_de`
	4. Status: `Enabled`
	5. Sort Order: `5`
3. Save the store view

Next, let's add a custom store and store view for the Luma B2B website:

*Store*
1. `Create Store`
2. Store Information:
	1. Website: `Luma B2B Website`
	2. Name: `Custom B2B Store`
	3. Code: `custom_b2b_store`
	4. Root Category: `Custom Catalog`
3. Save the store

*Store View*
1. `Create Store View`
2. Store View Information:
	1. Store: `Custom B2B Store`
	2. Name: `Custom US English`
	3. Code: `custom_b2b_us`
	4. Status `Disabled`
	5. Sort Order: `10`
3. Save the store view

Reindex and clear the cache.

<a id="configuring-the-luma-b2b-website"></a>
### Configuring the Luma B2B Website

*Configuring Luma B2B US English Store View*

Navigate to `Content > Design Configuration > Luma B2B Website > Luma B2B Store > US English`

1. Default Page Title: `LUMA Official Online Buyer Portal`
2. Default Meta Description: `With more than 230 stores spanning 43 states and growing, Luma is a nationally recognized active wear manufacturer and retailer. We’re passionate about active lifestyles – and it goes way beyond apparel.`
3. Default Meta Keywords: `yoga,exercise,apparel,clothing,working out,fitness`

*Configuring the Luma B2B German Store View*

1. Set the VM in developer mode via ssh with the `dev-mode` command
2. Navigate to: `Stores > Settings > Configuration`
3. Switch the store view to: `Luma B2B Website > Luma B2B Store > Deutsch`
4. Expand the `General > General > Locale Options` section
5. Locale: `German (Germany)`
6. Weight unit: `kgs`
7. Save
8. Navigate to `General > Currency Setup`
9. Default Display Currency: `Euro`
10. Allowed currencies: `Euro`
11. Save

Next, we'll update the meta data and favicon for the B2B German store view:

Navigate to `Content > Design Configuration > Luma B2B Website > Luma B2B Store > Deutsch`

1. HTML Head > Favicon: Upload `favicon.png`
2. HTML Head > Default Page Title: `Offizieller LUMA Online Käuferportal`
3. HTML Head > Default Meta Description: `Luma ist ein landesweit anerkannter Hersteller und Händler von Sportbekleidung mit über 230 Filialen in 43 Bundesstaaten. Ein aktiver Lebensstil ist unsere Leidenschaft – und das längst nicht nur in puncto Kleidung.`
4. HTML Head > Default Meta Keywords: `yoga,sport,bekleidung,kleidung,training,fitness`

When done, refresh the cache.

Next, let's update the meta information for the custom B2B store view.

Navigate to: `Content > Design Configuration > Luma B2B Website > Luma B2B Store > Custom US English`

1. Applied Theme: `Blank Custom Theme`
2. HTML Head > Favicon: Upload `favicon.png`
3. HTML Head > Default Page Title: `Custom Official Online Buyer Portal`
4. HTML Head > Default Meta Description: `Custom description goes here.`
5. HTML Head > Default Meta Keywords: `custom,keywords`

Next, let's update the Store Information for the custom B2B store view.

Navigate to: `Stores > Settings > Configuration > General > General > Store Information`

1. Store Name: `Custom Brand`
2. Store Description: `Custom description goes here`

<a id="updating-the-luma-website-for-b2c"></a>
#### Updating the Luma Website for B2C
Now that we'll have a separated B2C and B2B website, let's update our original Luma website to reflect its B2C purpose.

Navigate to: `Stores > Settings > All Stores`

Make the following updates to the following entities:

**NB:** Changes to website, store, and store view codes are optional.

1. Luma Website:
	1. Name: `Luma B2C Website`
2. Luma Website > Luma Store:
	1. Name: `Luma B2C Store`
	2. Code: `luma_b2c_store`
3. Luma Website > Luma Store > US English:
	1. Code: `default_b2c`
4. Luma Website > Luma Store > Deutsch:
	1. Code: `luma_b2c_de`
5. Luma Website > Custom Store:
	1. Name: `Custom B2C Store`
	2. Code: `custom_b2c_store`
6. Luma Website > Custom Store > US English:
	1. Code: `custom_b2c_us` (Initially, a database update was required for this.  TODO: Update the custom module that installs the store view)
7. Luma Website > Venia Store:
	1. Name: `Venia B2C Store`
	2. Code: `venia_b2c_store`
8. Luma Website > Venia Store > US English:
	1. Code: `venia_b2c_us`

<a id="configuring-cms-content-for-luma-b2b"></a>
#### Configuring CMS Content for Luma B2B
Since we're adding a new B2B website with the intention of possibly demoing the same stories as for B2C from a content perspective (aside from the home page), we'll need to update all of our CMS blocks and widgets to refer to both the Luma B2C and B2B websites. We can find the blocks we need to update by filtering for them:

Navigate to: `Content > Elements > Blocks` and filter `Store View` on `Luma B2C Website > Luma B2C Store > US English`

Update the blocks accordingly.

Next, use the following filter for the German blocks: `Luma B2C Website > Luma B2C Store > US English`

Do the same for all necessary dynamic blocks and pages.

<a id="configuring-the-urls"></a>
#### Configuring the URLs
Next, we'll need to configure the url for the Luma B2B Website in the Magento admin before moving on to the web server configuration.

Navigate to: `Stores > Settings > Configuration`

1. Switch the store view switch to: `Luma B2B Website`
2. General > Web > Base URLs > Base URL: `http://b2b.luma.com/`
3. General > Web > Base URLs > Base Link URL: `http://b2b.luma.com/`
4. General > Web > Base URLs (Secure) > Base URL: `http://b2b.luma.com/`
5. General > Web > Base URLs (Secure) > Base Link URL: `http://b2b.luma.com/`

Save the configuration and then refresh the cache.

<a id="adding-the-virtual-host"></a>
#### Adding the Virtual Host
First, we'll need to add a virtual host definition for the new website.  We'll copy the existing luma.com virtual host file and use it as a base to tweak for our b2b virtual host.

`ssh` into the VM using `ssh vagrant@luma.com` and `vagrant` as the password at a terminal.

1. `sudo cp /etc/nginx/sites-available/luma.com /etc/nginx/sites-available/b2b.luma.com`
2. `sudo vim /etc/nginx/sites-available/b2b.luma.com`
3. Change the server name to `b2b.luma.com`
4. Save the virtual host file

<a id="configuring-the-virtual-host"></a>
#### Configuring the Virtual Host
Next, we need to map 

1. `sudo vim /etc/nginx/sites-available/conf/01-multisite.conf`
2. Use `:set number` to show line numbers in the file
3. Navigate to row 6 (`luma.com base;`) and use `o` to insert a new line beneath
4. Add 4 spaces and then: `b2b.luma.com luma_b2b`
5. Navigate to row 13 (`base website;`) and use `o` to insert a new line beneath
6. Add 4 spaces and then: `luma_b2b website`
7. Navigate to the end of line 18 and use `Enter` to insert a line
8. Add `include /etc/nginx/sites-enabled/b2b.luma.com;` (We'll create this next)
9. Use `:wq`, then `Enter` to save the changes

Finally, we need to symlink the new Luma B2B website's virtual hosts file to activate the website and then restart the web server:

`sudo ln -s /etc/nginx/sites-available/b2b.luma.com /etc/nginx/sites-enabled/b2b.luma.com && sudo service nginx restart`

To be able to use the B2B website, we'll need to add it to our hosts file. 

<a id="adding-custom-websites"></a>
### Adding Custom Websites
In most cases, demoing a custom brand via a store associated with the Luma website(s) will be all we'll need.  However, there may be some cases where we want to separate the custom brand experience into its own websites.  To provide for that, we'll create a couple of custom websites (one for b2c and one for b2b).

Navigate to: `Stores > Settings > All Stores`

First, the Custom B2C site:

1. `Create Website`
2. Website Information:
	1. Name: `Custom B2C Website`
	2. Code: `custom_b2c`
	3. Sort Order: `10`
3. Save the website

Next, the Custom B2B site:

1. `Create Website`
2. Website Information:
	1. Name: `Custom B2B Website`
	2. Code: `custom_b2b`
	3. Sort Order: `15`
3. Save the website

We won't bother creating stores and store views for these; instead, since we already have custom stores and store views created for both B2B and B2C, we can simply re-assign those to their respective websites.

<a id="re-assigning-custom-stores-to-the-custom-websites"></a>
#### Re-assigning Custom Stores to the Custom Websites

<a id="creating-additional-site-definitions-and-virtual-hosts"></a>
#### Creating Additional Site Definitions and Virtual Hosts
Since our optimal goal is to be able to show a connected B2C + B2B story, as well as to give SC's the ability to create as custom an experience as they might need to deliver a quality demo, we'll add some additional multi-site configuration to make that process easier.

At the moment, provided you've followed along from the beginning and added the Luma B2B website above, we should have four virtual hosts created:

1. b2b.luma.com
2. luma.com
3. site1.com
4. site2.com

While we could create new virtual hosts for our efforts, it'll be easier for us if we simply repurpose `site1.com` and `site2.com` as custom B2C and B2B sites.

First, we'll rename the two virtual host files so we can easily see what their purpose will be.  This will break our symlinks for the virtual hosts in `/etc/nginx/sites-enabled`, so we'll need to delete the broken links and recreate those next.  After the symlinks are recreated, we'll then want to update the server names inside of each virtual host so it matches the name of the virtual host file.

**NB:** The server name value we're going to use is just a placeholder -- `custom-demo.com`.  If you plan to use this approach for your demos, you'll likely want to update this value to something more relevant to your demo use case.  You don't have to rename the virtual host files to match, but it may help avoid confusion to do so.

1. `sudo mv /etc/nginx/sites-available/site1.com /etc/nginx/sites-available/custom-demo.com && sudo mv /etc/nginx/sites-available/site2.com /etc/nginx/sites-available/b2b.custom-demo.com`
2. `sudo rm -rf /etc/nginx/sites-enabled/site1.com /etc/nginx/sites-enabled/site2.com && sudo ln -s /etc/nginx/sites-available/custom-demo.com /etc/nginx/sites-enabled/custom-demo.com && sudo ln -s /etc/nginx/sites-available/b2b.custom-demo.com /etc/nginx/sites-enabled/b2b.custom-demo.com`
3. `sudo vim /etc/nginx/sites-available/custom-demo.com`, then update `site1.com` to be `custom-demo.com` (or a value of your choosing if you're customizing this for your needs). Save and quit with `Esc`, then `:wq` and `Enter`.
4. Repeat for the custom B2B site with: `sudo vim /etc/nginx/sites-available/b2b.custom-demo.com`

Next, we'll need to update the web server mappings so that the sites can be loaded via URLs in the browser.  This is done in `/etc/nginx/sites-available/conf/01-multisite.conf`.  At this point in the flow, this file has two `map` statements with four lines each.  Two of those lines in each map statement are placeholders which we'll repurpose.  The bottom of the file has four `include` statements, two of which are commented out.  We'll repurpose those, too:

````
map $http_host $MAGE_RUN_CODE {
    luma.com base;
    b2b.luma.com luma_b2b;
    #<site 1 url> <site 1 code;
    #<site 2 url> <site 2 code>;
}

map $MAGE_RUN_CODE $MAGE_RUN_TYPE {
    base website;
    luma_b2b website;
    #<site 1 code> <site 1 scope>;
    #<site 2 code> <site 2 scope>;
}

include /etc/nginx/sites-enabled/luma.com;
include /etc/nginx/sites-enabled/b2b.luma.com;
#include /etc/nginx/sites-enabled/site1.com;
#include /etc/nginx/sites-enabled/site2.com;
````

1. Edit `sudo vim /etc/nginx/sites-available/conf/01-multisite.conf` like so:

```
map $http_host $MAGE_RUN_CODE {
    luma.com base;
    b2b.luma.com luma_b2b;
    luma-custom.com custom_b2c;
    b2b.luma-custom.com custom_b2b;
}

map $MAGE_RUN_CODE $MAGE_RUN_TYPE {
    base website;
    luma_b2b website;
    custom_b2c website;
    custom_b2b website;
}

include /etc/nginx/sites-enabled/luma.com;
include /etc/nginx/sites-enabled/b2b.luma.com;
include /etc/nginx/sites-enabled/custom-demo.com;
include /etc/nginx/sites-enabled/b2b.custom-demo.com;
```

2. Restart the web server.  If you've got the VM CLI installed, you can use `web-start`.  If not, it's `sudo systemctl start nginx`

<a id="adding-custom-sites-to-the-cache-warmer"></a>
#### Adding Custom Sites to the Cache Warmer
Lastly, in case you want to generate a custom site map for your new custom websites, we'll need to update the cache warmer with the URLs we've chosen and also add them to the VM's `/etc/hosts` file:

1. `sudo vim /etc/hosts`
2. Replace the first line with `127.0.0.1       luma.com b2b.luma.com custom-demo.com b2b.custom-demo.com`

Next, let's update the cache warmer.  Depending on when you follow this guide, you may have different versions of the script to consider.

1. `vim ~/cli/scripts/cache-warmer.sh`
2. Ensure the contents are as follows:

```
#!/bin/bash
clear
printf "Warming the Luma cache...\n"
sleep 1
wget --quiet "http://luma.com/pub/luma.xml" --no-cache --output-document - | egrep -o "http://luma.com[^<]+" | while read line; do
    time curl -A 'Cache Warmer' -s -L $line > /dev/null 2>&1
    echo $line
done
printf "done."
sleep 1
clear
printf "Warming the Venia cache...\n"
sleep 1
wget --quiet "http://luma.com/pub/venia.xml" --no-cache --output-document - | egrep -o "http://luma.com[^<]+" | while read line; do
    time curl -A 'Cache Warmer' -s -L $line > /dev/null 2>&1
    echo $line
done
printf "done."
sleep 1
clear
printf "Warming the Custom B2C cache...\n"
sleep 1
wget --quiet "http://luma.com/pub/custom_b2c.xml" --no-cache --output-document - | egrep -o "http://luma.com[^<]+" | while read line; do
    time curl -A 'Cache Warmer' -s -L $line > /dev/null 2>&1
    echo $line
done
sleep 1
printf "done.\n"
clear
printf "Warming the Custom B2B cache...\n"
sleep 1
wget --quiet "http://b2b.luma.com/pub/custom_b2b.xml" --no-cache --output-document - | egrep -o "http://b2b.luma.com[^<]+" | while read line; do
    time curl -A 'Cache Warmer' -s -L $line > /dev/null 2>&1
    echo $line
done
sleep 1
printf "done.\n"
```

If you want to use the multisite approach for your demo, you'll need to update the URLs in the `wget` statements under the `Warming the Custom B2C cache` and `Warming the Custom B2B cache` sections respectively. Following our placeholder approach, those would read:

```
wget --quiet "http://custom-demo.com/pub/custom_b2c.xml" --no-cache --output-document - | egrep -o "http://custom-demo.com[^<]+" |
```

and

```
wget --quiet "http://b2b.custom-demo.com/pub/custom_b2b.xml" --no-cache --output-document - | egrep -o "http://b2b.custom-demo.com[^<]+" |
```

**NB:** Remember that `custom-demo.com` here is a placeholder value meant to guide you through the configuration.  You'll need to make sure to use the value that's relevant to your demo use case.

3. Save the cache warmer with `Esc`, then `:wq` and `Enter`

**NB:** A final reminder: If you're updating the cache warmer, remember that it runs on site maps which will likely need to be regenerated to reflect the right website/store-view assignment and custom URL.  You can address this in the admin at: `Marketing > SEO & Search > Site Map`.

<a id="b2b-demo-cases"></a>
## B2B Demo Cases

<a id="customers"></a>
### Customers
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
### Sales Representative Role and User
Next, we'll create another admin user and user role that we'll assign as the sales representative for our companies.

**Note:** For whatever reason, permissions for Quotes are not available to anyone except a user with complete access.

*User Role*

Navigate to `System > Permissions > User Roles`

1. Add a new role
2. Role Info > Role Name: `Sales Representative`
3. Role Info > Your Password: `<PASSWORD>`
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
6. User Info > Account Information > Password: `<PASSWORD>`
7. User Info > Account Information > Password Confirmation: `<PASSWORD>`
8. User Info > Account Information > Interface Locale: `English (United States)`
9. User Info > Account Information > This account is: `Active`
10. User Info > Current User Identity Verification > Your Password: `<PASSWORD>`
11. User Role: `Sales Representative`
12. Save the user

<a id="companies"></a>
### Companies
After the customers are imported, we'll create the two companies we're going to use to tell the B2B story, and then assign the proper customers to them.

Navigate to `Customers > Companies`

<a id="terra-outfitters"></a>
#### Terra Outfitters

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
#### Emily's Exercise Emporium

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
### Buyer Users
Once the users have been imported and the companies have been created, we can assign Jack Fitz and Jill Moorehouse to Terra Outfitters:

Navigate to `Customers > All Customers`

1. Find the desired customer in the grid
2. Customer Information > Account Information > Associate to Company: `Terra Outfitters`
3. Save the customer

<a id="buyer-teams"></a>
### Buyer Teams
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
### Buyer Roles and Permissions
Next, we'll edit the Default User role and rename it to Buyer.  Then, we'll customize its permissions.

Login as `John Smith` on the storefront and navigate to `John Smith > Roles and Permissions`

1. Edit the `Default User` role
2. Role Name: `Buyer`
3. Add `Use Pay On Account Method` permission
4. Remove `Company User Management` permission
5. Add `Company Credit` and `Company Credit > View` permissions


<a id="b2b-autofill"></a>
### B2B Autofill
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

<a id="company-content"></a>
### Company Content
Next, let's add a custom welcome message to personalize the My Account area for our Terra Outfitters buyers.

Navigate to `Content > Elements > Dynamic Blocks > Add Dynamic Block`

1. Enable Dynamic Block: `Yes`
2. Dynamic Block Name: `Terra Outfitters Welcome Message`
3. Dynamic Block Type: `Any Dynamic Block Type`
4. Customer Segment: `Company - Terra Outfitters Users`

*Row*

5. Appearance: `Contained`
6. Background > Background Color: `#f5f5f5`
7. Background > Background Image: `None`
8. Advanced > Margins and Padding:
	1. Top Margin: `0`
	2. Left Margin: `0`
	3. Right Margin: `0`
	4. Bottom Magin: `0`
	5. Top Padding: `15px`
	6. Left Padding: `15px`
	7. Right Padding: `15px`
	8. Bottom Padding: `15px`

9. Insert two columns into the row. Then, delete the right one so that the left one takes up the entire row.

*Row 1 > Column 1*

10. Grid Size: `12/12`
11. Appearance: `Centered`
12. Background > Background Color: `None`
13. Background > Background Image:
	1. Choose `Select from Gallery`
	2. Upload the `terra-outfitters.png` image to the `wysiwyg/b2b` folder and select it
	3. Background > Background Size: `Contain`
	4. Background > Background Position: `Center Left`
14. Layout > Minimum Height: `85px`
15. Layout > Verical Alignment: `Centered`
16. Advanced > Margins and Padding:
	1. Top Margin: `0`
	2. Left Margin: `0`
	3. Right Margin: `7.5px`
	4. Bottom Magin: `0`
	5. Top Padding: `0`
	6. Left Padding: `100px`
	7. Right Padding: `0`
	8. Bottom Padding: `0`

24. Next, insert a text element into the column.

*Text Element*

25. Content Line 1:
	1. Format: `Heading 2`
	2. Font Size: `24px`
	3. Line Height: `Line Height`
	4. Text: `Welcome to the **Terra Outfitters** Buyer Portal` (The double-asterisk here denotes **bold** text)
	5. Color: `Black`

26. Content Line 2:
	1. Format: `Paragraph`
	2. Font Size: `18px`
	3. Line Height: `26px`
	4. Text: `Your sales representative, **Mark Jones**, is eager to work with you!  You can reach him at **(323) 934-3456** with any questions, or place a quote and he'll be in touch!`

Finally, let's translate the welcome message into German:

26. Content Line 1:
	1. Text: `Willkommen auf dem **Terra Outfitters** Käuferportal`

27. Content Line 2:
	1. Text: `Ihr Vertriebsmitarbeiter, **Mark Jones**, ist bestrebt, mit Ihnen zusammenzuarbeiten! Sie können ihn unter **(323) 934-3456** bei Fragen erreichen oder ein Angebot machen und er wird sich melden!`

<a id="terra-welcome-message-widget"></a>
#### Terra Welcome Message Widget
Next, we'll need to place the welcome message content on the My Account page at the top.

Navigate to `Content > Elements > Widgets`

1. Settings > Type: `Dynamic Blocks Rotator`
2. Settings > Design Theme: `Magento Luma`
3. `Continue`
4. Storefront Properties > Widget Title: `My Account Welcome Message`
5. Storefront Properties > Assign to Store Views: `Luma B2C Website > Luma Store > US English, Deutsch`
6. `Layout Updates > Add Layout Update`
7. Layout Updates > Display on: `Specified Page`
	1. Page: `Customer My Account`
	2. Container: `After Page Header Top`
	3. Template: `Dynamic Blocks Template`
8. Widget Options > Dynamic Blocks to Display: `Specified Dynamic Blocks`
9. Widget Options > Restrict by Dynamic Block Types: `None`
10. Widget Options > Rotation Mode: `Display all instead of rotating`
11. Widget Options > Specify Dynamic Blocks: `Reset Filter` > `Terra Outfitters Welcome Message`

<a id="company-user-segments"></a>
### Company User Segments
Next, we'll segment our Terra Outfitters users and our Emily's Exercise Emporium users so we can create differentiation in their My Account area.

Navigate to: `Customers > Customer Segments > Add Segment`

1. General Properties > Segment Name: `Company - Terra Outfitters Users`
2. General Properties > Assigned to Website: `Luma Website` (This will change to B2B-specific website)
3. General Properties > Status: `Active`
4. General Properties > Apply To: `Registered Customers`
5. `Save and Continue Edit`
6. Conditions:
	1. If **ALL** of these conditions are **TRUE:**
		1. Customer Email **contains** **terraoutfitters.com**
7. Save the segment

<a id="catalogs"></a>
### Catalogs
In order to use the shared catalog functionality to show pricing, we need to set our product prices at `Website` scope. Navigate to: `Stores > Settings > Configuration > Catalog > Catalog > Price` and change Catalog Price Scope to `Website`.

<a id="b2b-call-outs"></a>
### B2B Call-outs
Next, we'll create some call-outs for guest B2C customers which advertise the B2B buyer portal.  We'll create two of them -- one red, the other, blue:

Navigate to: `Content > Elements > Dynamic Blocks`

1. Add a new block
2. Enable Dynamic Block: `Yes`
3. Dynamic Block Name: `Luma B2B Call-out (Blue)`
4. Dynamic Block Type: 	`Any Dynamic Block Type`
5. Customer Segment: `LUMA B2C Guest Customers`

*Row 1*
1. Appearance: `Full Width`
2. Background > Background Color: `#066bb4`
3. Layout > Vertical Alignment: `Center`
4. Advanced > Alignment: `Center`
5. Advanced > Margins and Padding:
	1. Top Margin: `0`
	2. Right Margin: `0`
	3. Bottom Margin: `0`
	4. Left Margin: `0`
	5. Top Padding: `10px`
	6. Right Padding: `0`
	7. Bottom Padding: `20px`
	8. Left Padding: `0`

*Text*
1. Content Line 1:
	1. Format: `Heading 2`
	2. Font Size: `26px`
	3. Text: `Looking for our **B2B Buyer Portal?**`
	4. Color: `White`

*Button*
1. Button Text: `Log in`
2. Button Type: `Secondary`
3. Button Link: `URL`: `http://b2b.luma.com`
4. Advanced > Alignment: `Center`

Next, switch store views to the German store view and make the following edit:

1. De-tick `Use Default Value`

*Text*
1. Content Line 1:
	1. Text: `Suchen Sie nach unserem Käuferportal?`

*Button*
1. Button Text: `Anmeldung`

Next, duplicate the blue call-out block and create a new, red one:

1. Dynamic Block Name: `Luma B2B Call-out (Red)`

*Row 1*
1. Background > Background Color: `#c54050`

<a id="home-page-updates"></a>
### Home Page Updates
Next, we need to add our B2B call-out to the B2B Home Page:

Navigate to: `Content > Elements > Pages`

1. Open `Luma B2C Home Page - US`

*Row 1*
1. Advanced > Margins and Padding:
	1. Top Margin: `10px`
	2. Right Margin: `0`
	3. Bottom Margin: `10px`
	4. Left Margin: `0`
	5. Top Padding: `10px`
	6. Right Padding: `10px`
	7. Left Padding: `10px`
	8. Bottom Padding: `10px`

Insert a new row beneath Row 1 for the call out:

*Call out Row*
1. Appearance: `Full Bleed`
2. Layout > Vertical Alignment: `Center`
3. Advanced > Alignment: `Center`
4. Advanced > Margins and Padding:
	1. Top Margin: `10px`
	2. Right Margin: `0`
	3. Bottom Margin: `20px`
	4. Left Margin: `0`
	5. Top Padding: `0`
	6. Right Padding: `0`
	7. Left Padding: `0`
	8. Bottom Padding: `0`	

Insert the `Luma B2B Call-out (Blue)` dynamic block into the row created for it.

<a id="b2b-staging-updates"></a>
### B2B Staging Updates
Next, make the same call-out updates to each of the staging campaigns.  Add the `Luma B2B Call-out (Red)` dynamic block instead of the blue one in the Holiday campaign.

<a id="b2b---b2c-menu-connection"></a>
### B2B - B2C Menu Connection
Next, let's create a connection back from our B2B Buyer Portal to our Retail site.

Navigate to: `Content > Elements > Hierarchy`

1. Switch scope to the `Luma B2B Website > US English` store view
2. De-tick: `Use the parent node hierarchy`
3. Add a node:
	1. Title : `LUMA Retail`
	2. URL Key: `retail`
	3. Main Navigation Menu Options > Show in navigation menu: `Yes`
4. Click `Add to Tree`

Refresh the cache when done.

Next, we need to create a redirect for this node:

Navigate to: `Marketing > SEO and Search > URL Rewrites`

1. Add URL Rewrite
2. Create URL Rewrite: `Custom`
3. Store: `Luma B2C Store > US English`
4. Request Path: `retail`
5. Target Path: `http://luma.com`
6. Redirect Type: `302 Temporary`

Save the redirect.

<a id="multi-source-inventory"></a>
## Multi-source Inventory
Next, we'll create some inventory sources and leave them disabled so that we can tell a convincing Multi-source Inventory story.

<a id="creating-sources"></a>
### Creating Sources

Navigate to: `Stores > Inventory > Sources`

1. Add New Source
2. Source 1:
	1. General > Name: `Luma US West Warehouse`
	2. General > Code: `luma_us_west_wh`
	3. General > Is Enabled: `No`
	4. General > Description: `Our west coast warehouse located in Commerce, CA.`
	5. General > Latitude: `33.98205`
	6. General > Longitude: `-118.13242`
	7. Address Data > Country: `United States`
	8. Address Data > State: `California`
	9. Address Data > City: `Commerce`
	10. Address Data > Street: `7250 Bandini Blvd`
	11. Address Data > Postcode: `90040` 
3. Source 2:
	1. General > Name: `Luma US Midwest Warehouse`
	2. General > Code: `luma_us_midwest_wh`
	3. General > Is Enabled: `No`
	4. General > Description: `Our midwestern warehouse located in Springfield, MO.`
	5. General > Latitude: `37.144958`
	6. General > Longitude: `-93.330978`
	7. Address Data > Country: `United States`
	8. Address Data > State: `Missouri`
	9. Address Data > City: `Springfield`
	10. Address Data > Street: `2215 W Chesterfield St`
	11. Address Data > Postcode: `65807`
4. Source 3:
	1. General > Name: `Luma US East Warehouse`
	2. General > Code: `luma_us_east_wh`
	3. General > Is Enabled: `No`
	4. General > Description: `Our east coast warehouse located in Hickory, NC.`
	5. General > Latitude: `35.71474`
	6. General > Longitude: `-81.38184`
	7. Address Data > Country: `United States`
	8. Address Data > State: `North Carolina`
	9. Address Data > City: `Hickory`
	10. Address Data > Street: `2349 SW 13TH Ave`
	11. Address Data > Postcode: `28602`
5. Source 4:
	1. General > Name: `Luma UK Warehouse`
	2. General > Code: `luma_eu_uk_wh`
	3. General > Is Enabled: `No`
	4. General > Description: `Our UK warehouse in Enfield, UK.`
	5. General > Latitude: `51.83518`
	6. General > Longitude: `-2.51216`
	7. Address Data > Country: `United Kingdom`
	8. Address Data > City: `Enfield`
	9. Address Data > Street: `Unit 1 Woodall Road, Redburn Industrial Estate`
	10. Address Data > Postcode: `EN3 4LF`
6. Source 5:
	1. General > Name: `Luma DE Warehouse`
	2. General > Code: `luma_eu_de_wh`
	3. General > Is Enabled: `No`
	4. General > Description: `Our German warehouse located in Hamburg, Germany.`
	5. General > Latitude: `53.514700`
	6. General > Longitude: `9.907060`
	7. Address Data > Country: `Germany`
	8. Address Data > State: `Hamburg`
	9. Address Data > City: `Hamburg`
	10. Address Data > Street: `Genter Ufer 2`
	11. Address Data > Postcode: `21129`
7. Source 6:
	1. General > Name: `Luma AU Warehouse`
	2. General > Code: `luma_apac_au_wh`
	3. General > Is Enabled: `No`
	4. General > Description: `Our Australian warehouse located in Miranda, New South Wales Australia.`
	5. General > Latitude: `-34.027310`
	6. General > Longitude: `151.105840`
	7. Address Data > Country: `Australia`
	8. Address Data > State: `New South Wales`
	9. Address Data > City: `Miranda`
	10. Address Data > Street: `215 Port Hacking Rd`
	11. Address Data > Postcode: `2228`
8. Source 7:
	1. General > Name: `Luma JP Warehouse`
	2. General > Code: `luma_apac_jp_wh`
	3. General > Is Enabled: `No`
	4. General > Description: `Our Japanese warehouse located in Koga City, Ibaraki Prefecture, Japan.`
	5. General > Latitude: `-34.027310`
	6. General > Longitude: `151.105840`
	7. Address Data > Country: `Japan`
	8. Address Data > State: `Ibaraki Prefecture`
	9. Address Data > City: `Koga City`
	10. Address Data > Street: `Kitatone`
	11. Address Data > Postcode: `306-0213`
9. Source 8:
	1. General > Name: `Luma BR Warehouse`
	2. General > Code: `luma_sa_br_wh`
	3. General > Is Enabled: `No`
	4. General > Description: `Our Brazilian warehouse located in Rio de Janeiro, Brazil.`
	5. General > Latitude: `-2.484740`
	6. General > Longitude: `-44.265600`
	7. Address Data > Country: `Brazil`
	8. Address Data > State: `Duque de Caxias`
	9. Address Data > City: `Rio de Janeiro`
	10. Address Data > Street: `Av. Litorânea, 2632 Bldg 200 - Vila São Luiz`
	11. Address Data > Postcode: `25056-075`
10. Source 9:
	1. General > Name: `Luma AR Warehouse`
	2. General > Code: `luma_sa_ar_wh`
	3. General > Is Enabled: `No`
	4. General > Description: `Our Argentine warehouse located in Buenos Aires, Argentina.`
	5. General > Latitude: `-34.803470`
	6. General > Longitude: `-58.378460`
	7. Address Data > Country: `Brazil`
	8. Address Data > State: `Buenos Aires`
	9. Address Data > City: `Buenos Aires`
	10. Address Data > Street: `San Martin`
	11. Address Data > Postcode: `1672`
11. Source 10:
	1. General > Name: `Manhatten Mall Store`
	2. General > Code: `luma_manhatten_mall_store`
	3. General > Is Enabled: `No`
	4. General > Description: `Our retail store in Manhatten, New York City, NY.`
	5. General > Latitude: `40.748900`
	6. General > Longitude: `-73.988660`
	7. Address Data > Country: `United States`
	8. Address Data > State: `New York`
	9. Address Data > City: `New York`
	10. Address Data > Street: `901 Avenue Of The Americas`
	11. Address Data > Postcode: `10001`
12. Source 11:
	1. General > Name: `Broadway Soho Store`
	2. General > Code: `luma_broadway_soho_store`
	3. General > Is Enabled: `No`
	4. General > Description: `Our retail store on Broadway in New York City, NY.`
	5. General > Latitude: `40.748900`
	6. General > Longitude: `-73.988660`
	7. Address Data > Country: `United States`
	8. Address Data > State: `New York`
	9. Address Data > City: `New York`
	10. Address Data > Street: `565 Broadway`
	11. Address Data > Postcode: `10012`