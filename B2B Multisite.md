<a id="creating-the-luma-b2b-website"></a>
#### Creating the Luma B2B Website
In order to realistically and effectively show Magento's B2B capabilities, we'll convert Luma into a B2C and B2B merchant by adding a B2B website.  This helps with a few things -- first, it elegantly demonstrates multi-site capabilities beyond the shared cart scenario that Venia provides.  Second, it helps us get around the need to avoid shared catalogs; we can simply apply those cases to the separated website.  And third, it allows us to tell a B2B story without using a copy or snapshot of the VM.

<a id="adding-the-luma-b2b-website"></a>
##### Adding the Luma B2B Website
First, we'll need to create the website, store, and store views we'll use for B2B.

Navigate to: `Stores > Settings > All Stores`

1. `Create Website`
2. Website Information:
	1. Name: `Luma B2B Website`
	2. Code: `luma_b2b`
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
9. Save the store view

Next, let's add a B2B German store view for the Luma B2B Store:

1. `Create Store View`
2. Store View Information:
	1. Store: `Luma B2B Store`
	2. Name: `Deutsch`
	3. Code: `luma_b2b_de`
	4. Status: `Enabled`
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
3. Save the store view

Reindex and clear the cache.

<a id="configuring-the-luma-b2b-website"></a>
##### Configuring the Luma B2B Website

*Configuring Luma B2B US English Store View*

Navigate to `Content > Design Configuration > Luma B2B Website > Luma B2B Store > US English`

1. Default Page Title: `LUMA B2B Official Online Store`
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
2. HTML Head > Default Page Title: `Offizieller LUMA B2B Online-Shop`
3. HTML Head > Default Meta Description: `Luma ist ein landesweit anerkannter Hersteller und Händler von Sportbekleidung mit über 230 Filialen in 43 Bundesstaaten. Ein aktiver Lebensstil ist unsere Leidenschaft – und das längst nicht nur in puncto Kleidung.`
4. HTML Head > Default Meta Keywords: `yoga,sport,bekleidung,kleidung,training,fitness`

When done, refresh the cache.

Next, let's update the meta information for the custom B2B store view.

Navigate to: `Content > Design Configuration > Luma B2B Website > Luma B2B Store > Custom US English`

1. Applied Theme: `Blank Custom Theme`
2. HTML Head > Favicon: Upload `favicon.png`
3. HTML Head > Default Page Title: `Custom Official Online Store`
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
##### Configuring CMS Content for Luma B2B
Since we're adding a new B2B website with the intention of possibly demoing the same stories as for B2C from a content perspective (aside from the home page), we'll need to update all of our CMS blocks and widgets to refer to both the Luma B2C and B2B websites. We can find the blocks we need to update by filtering for them:

Navigate to: `Content > Elements > Blocks` and filter `Store View` on `Luma B2C Website > Luma B2C Store > US English`

Update the blocks accordingly.

Next, use the following filter for the German blocks: `Luma B2C Website > Luma B2C Store > US English`

Do the same for all necessary dynamic blocks and pages.

<a id="configuring-the-urls"></a>
##### Configuring the URLs
Next, we'll need to configure the url for the Luma B2B Website in the Magento admin before moving on to the web server configuration.

Navigate to: `Stores > Settings > Configuration`

1. Switch the store view switch to: `Luma B2B Website`
2. General > Web > Base URLs > Base URL: `http://b2b.luma.com/`
3. General > Web > Base URLs > Base Link URL: `http://b2b.luma.com/`
4. General > Web > Base URLs (Secure) > Base URL: `http://b2b.luma.com/`
5. General > Web > Base URLs (Secure) > Base Link URL: `http://b2b.luma.com/`

Save the configuration and then refresh the cache.

<a id="adding-the-virtual-host"></a>
##### Adding the Virtual Host
First, we'll need to add a virtual host definition for the new website.  We'll copy the existing luma.com virtual host file and use it as a base to tweak for our b2b virtual host.

`ssh` into the VM using `ssh vagrant@luma.com` and `vagrant` as the password at a terminal.

1. `sudo cp /etc/nginx/sites-available/luma.com /etc/nginx/sites-available/b2b.luma.com`
2. `sudo vim /etc/nginx/sites-available/b2b.luma.com`
3. Change the server name to `b2b.luma.com`
4. Save the virtual host file

<a id="configuring-the-virtual-host"></a>
##### Configuring the Virtual Host
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