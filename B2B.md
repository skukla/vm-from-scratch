# Magento Demo VM From Scratch

## Table of Contents
- [Building the VM](BUILDING-THE-VM.md)
- [Kukla VM Demo Setup](DEMO-SETUP.md)
- [Kukla VM and B2B](B2B.md)
- [How Do I...](HOW-TO.md)

# Kukla VM and B2B

<!-- MarkdownTOC autolink="true" autoanchor="true" markdown_preview="github" -->

- [B2B Configuration](#b2b-configuration)
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

<!-- /MarkdownTOC -->

<a id="b2b-configuration"></a>
## B2B Configuration

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
	2. Code: `luma_b2b`
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
6. User Info > Account Information > Password: `admin4tls`
7. User Info > Account Information > Password Confirmation: `admin4tls`
8. User Info > Account Information > Interface Locale: `English (United States)`
9. User Info > Account Information > This account is: `Active`
10. User Info > Current User Identity Verification > Your Password: `admin4tls`
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

Finally, let's translate the welcome message into German:

26. Content Line 1:
	1. Text: `Willkommen auf dem **Terra Outfitters** Buyer Portal`

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



2. Price scope per website
2. Update B2B welcome message
