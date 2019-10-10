# Magento Demo VM Documentation

## Table of Contents
- [VM Setup and Usage](VM-SETUP.md)
- [How Do I...](HOW-DO-I.md)
- [Building the VM](BUILDING-THE-VM.md)
- [Building the B2C Demo Cases](BUILDING-THE-B2C-DEMO-CASES.md)
- [Building the B2B, Multisite, and MSI Demo Cases](BUILDING-THE-B2B-MULTISITE-MSI-DEMO-CASES.md)

# Building the B2C Demo Cases

<!-- MarkdownTOC autolink="true" autoanchor="true" markdown_preview="github" -->

- [Demo Environments Overview](#demo-environments-overview)
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
		- [Configure Indexers To Update On Schedule](#configure-indexers-to-update-on-schedule)
	- [General Content Updates](#general-content-updates)
		- [Luma Home Page \(US\)](#luma-home-page-us)
			- [Page Setup](#page-setup)
			- [Remove Home Page Block](#remove-home-page-block)
			- [Create Page Builder Content](#create-page-builder-content)
		- [Luma Home Page \(DE\)](#luma-home-page-de)
			- [Page Setup](#page-setup-1)
			- [Page Builder Content](#page-builder-content)
		- [Venia Home Page](#venia-home-page)
			- [Page Setup](#page-setup-2)
			- [Page Builder Content](#page-builder-content-1)
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
		- [Add Additional Language Packs](#add-additional-language-packs)
	- [Products](#products)
		- [Re-arrange Gear > Bags Category](#re-arrange-gear--bags-category)
		- [Re-arrange the Womens > Hoodies and Sweatshirts Category](#re-arrange-the-womens--hoodies-and-sweatshirts-category)
		- [Add Running As An Attribute to Select Products](#add-running-as-an-attribute-to-select-products)
		- [Add Stock for Mailed Gift Card](#add-stock-for-mailed-gift-card)
		- [Remove Manual Up-sells from Cronus Yoga Pant](#remove-manual-up-sells-from-cronus-yoga-pant)
		- [Add a Monogram as a Custom Option to the Strive Shoulder Pack](#add-a-monogram-as-a-custom-option-to-the-strive-shoulder-pack)
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
			- [20% Off Every $200-plus Purchase \(3000 Reward points\)](#20-off-every-200-plus-purchase-3000-reward-points)
			- [Free Shipping](#free-shipping)
		- [Targeted Content \(Dynamic Blocks\)](#targeted-content-dynamic-blocks)
			- [Featured Products \(All Customers\)](#featured-products-all-customers)
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
	- [Additional Page Builder Content](#additional-page-builder-content)
		- [Category Landing Page Template](#category-landing-page-template)
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
	- [Fixes](#fixes)
		- [Staging and Preview "Preview" Link and Share URL Broken](#staging-and-preview-preview-link-and-share-url-broken)
		- [Pickup In Store Quantity is Mis-Aligned](#pickup-in-store-quantity-is-mis-aligned)
		- [Pickup In Store Extension Breaks B2B Checkout](#pickup-in-store-extension-breaks-b2b-checkout)
		- [Image Gallery Uses Prepend Instead of Replace](#image-gallery-uses-prepend-instead-of-replace)
		- ["Find Your Local Store" String Isn't Translated](#find-your-local-store-string-isnt-translated)
		- [Hide the Venia Lookbook Category](#hide-the-venia-lookbook-category)
		- [Fix the Venia Tops Category](#fix-the-venia-tops-category)
		- [Email "From" Doesn't Show Properly](#email-from-doesnt-show-properly)

<!-- /MarkdownTOC -->

<a id="demo-environments-overview"></a>
## Demo Environments Overview
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
	"magentoese/module-productbadge-sample-data": "dev-master",
	"magentoese/module-sctools": "dev-master",
	"magentoese/module-switcherlogos": "dev-master",
	"magentoese/module-themecustomizer": "dev-master",

	"classyllama/module-owlcarousel":"dev-master",
	"magentoese/module-lookbook": "dev-master",
	"magentoese/module-product-image-switcher": "dev-master",
	"magentoese/module-luma-de-attributes": "dev-master",
	"magentoese/module-luma-de-categories": "dev-master",
	"magentoese/module-luma-de-cms": "dev-master",
	"magentoese/module-luma-de-products": "dev-master",
	"magentoese/module-luma-de-setup": "dev-master",
	"magentoese/module-luma-de-widget": "dev-master",
	"splendidinternet/mage2-locale-de-de": "dev-master",

	"magentoese/module-venia-setup": "dev-master",
	"magentoese/theme-frontend-venia": "dev-master",
	"magentoese/module-venia-catalog-sample-data": "dev-master",
	"magentoese/module-venia-cms-sample-data": "dev-master",
	"magentoese/module-venia-media-sample-data": "dev-master",
	"magentoese/module-vimeo": "dev-master",
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
	Website Name: `Luma B2C Website`
	Website Code: `base`
2. Store:
	Store Name: `Luma B2C Store`
	Store Code: `luma_b2c_store`

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

`AIzaSyCeZ8dVvWraRuKMVDl1ISAcfuYHdp7ZBgE`

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

Next, we'll translate that into German and apply it to the `Luma Store > Deutsch` store view:

1. Default Page Title: `Offizieller LUMA Online-Shop`
2. Default Meta Description: `Luma ist ein landesweit anerkannter Hersteller und Händler von Sportbekleidung mit über 230 Filialen in 43 Bundesstaaten. Ein aktiver Lebensstil ist unsere Leidenschaft – und das längst nicht nur in puncto Kleidung.`
3. Default Meta Keywords: `yoga,sport,bekleidung,kleidung,training,fitness`

Next, use the following for the `Custom Store > US English` store view:

1. Default Page Title: `Custom Official Online Store`
2. Default Meta Description: `Custom description goes here.`
3. Default Meta Keywords: `custom,keywords`

Next, use the following for the `Venia Store > US English` store view scope:

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
	1. Website: `Luma B2C Website`
	2. Customer Group: `All Customer Groups`
	3. Direction: `Points to Currency`
	4. Rate: `1 / 1`
4. Add a new rate for currency to points:
	1. Website: `Luma B2C Website`
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

<a id="configure-indexers-to-update-on-schedule"></a>
#### Configure Indexers To Update On Schedule
Magento's indexers can operate in two modes: a manual mode, *Update On Save*, and a mode designed to run via a cron job process, *Update By Schedule*.  Let's ensure all indexers are set to run on schedule:

Navigate to `System > Tools > Index Management`

1. Select all of the indexers
2. Use the Mass Actions dropdown to set their mode to *Update By Schedule* 

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

<a id="remove-home-page-block"></a>
##### Remove Home Page Block
By default, the home page content is contained within blocks which are then placed onto the home page itself using a widget.  This approach has pros and cons, but in general, it violates the reason content is generally split into blocks: easy reuse.  The content is not reused anywhere else and so, ought not to need block approach.  We'll use a CMS page for our home page and thus, we need to de-activate our Home Page CMS Block widget.

Navigate to `Content > Elements > Widgets > Home Page`

1. Layout Updates: `Delete Layout Update`
2. Save

Next, we'll also deactivate the Home Page CMS block.

Navigate to `Content > Elements > Blocks > Home Page Block`

1. Enable Block: `No`
2. Save

Clear the cache when done

Repeat this process for the `Home Page - DE` widget and `Home Page Block - DE`, respectively.

<a id="create-page-builder-content"></a>
##### Create Page Builder Content

Navigate to `Content > Elements > Pages > Luma Home Page - US`

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
		1. Top Margin: `10px`
		2. Right Margin: `0`
		3. Bottom Margin: `0`
		4. Left Margin: `0`
		5. Top Padding: `10px`
		6. Right Padding: `10px`
		7. Bottom Padding: `10px`
		8. Left Padding: `10px`

2. Next, add a banner to the top row so that the row has a perceived second column.

3. **Row 1 > Banner:**
	1. Appearance: `Collage Right`
	2. Minimum Height: `300px`
	3. Background > Background Color: `rgba(255, 255, 255, 0)` (This makes the banner transparent)
	4. Background > Background Image: `None`
	5. Background > Background Size: `Cover`
	6. Background > Background Position: `Top Left`
	7. Background > Background Attachment: `Scroll`
	8. Background > Background Repeat: `No`
	9. Content > Message Text:
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
	10. Content > Link: `Category` > `What's New`
	11. Content > Link > Open in new tab: `Deselected`
	12. Content > Show Button: `Always` 
	13. Content > Button Text: `Shop New Yoga`
	14. Content > Button Type: `Primary`
	15. Content > Show Overlay: `Always`
	16. Content > Overlay Color: `rgba(255, 255, 255, 0.9)`
	17. Advanced > Alignment: `Default`
	18. Margins and Padding:
		1. Top Margin: `0`
		2. Right Margin: `0`
		3. Bottom Margin: `0`
		4. Left Margin: `0`
		5. Top Padding: `40px`
		6. Right Padding: `40px`
		7. Bottom Padding: `40px`
		8. Left Padding: `40px`

**Note:** You *could* use a two-column approach; however, I find that banner element shows nicely given the appearance modes are built for this use case.

4. Duplicate the first row and remove the banner.

5. **Row 2:**
	1. Background Image: `None`
	2. Layout > Minimum Height: `None`

6. **Row 2 > Left Column:**
	1. Grid Size: `4/12`
	2. Appearance: `Centered`
	3. Background Color: `None`
	4. Background Image: `hp-guy-left.jpg`
	5. Background Size: `Cover`
	6. Background Position: `Top Left`
	7. Background Attachment: `Scroll`
	8. Background Repeat: `No`
	9. Paralax > Enable Paralax Background: `No`
	10. Layout > Minimum Height: `400px`
	11. Layout > Vertical Alignment: `Center`
	12. Advanced > Alignment: `Right`
	13. Margins and Padding:
		1. Top Margin: `10px`
		2. Right Margin: `15px`
		3. Bottom Margin: `10px`
		4. Left Margin: `15px`
		5. Top Padding: `20px`
		6. Right Padding: `20px`
		7. Bottom Padding: `20px`
		8. Left Padding: `20px`

7. Inside the Left Column, add a text element.

8. **Row 2 > Left Column > Text:**
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

8. Duplicate the left column.

9. **Row 2 > Center Column:**
	1. Background Image: `hp-erin-center.jpg`
	2. Advanced > Alignment: `Left`

10. **Row 2 > Center Column > Text:**
	1. Content Line 1: 
		1. Text: `Take it from Erin`
		2. Color: `Black`
	2. Content Line 2:
		1. Text: `Luma founder Erin Renney shares her favorites`
		2. Color: `Black`

11. Duplicate the center column.

12. **Row 2 > Right Column:**
	1. Background Image: `hp-girl-right.jpg`
	2. Advanced > Alignment: `Right`

13. **Row 2 > Right Column > Text:**
	1. Content Line 1: 
		1. Text: `All Shirts`
		2. Color: `Black`
	2. Content Line 2:
		1. Text: `Buy 3 Luma tees and get a 4th free`
		2. Color: `Black`

14. Duplicate the first row and drag it beneath the second row.

15. **Row 3:**
	1. Background Image: `hp-woman-on-fence.jpg`

16. **Row 3 > Banner:**
	1. Content > Message Text > Line 1: `Twice around, twice as nice`	
	2. Content > Message Text > Line 2: `Find conscientious, comfy clothing in our eco-friendly collection`
	3. Content > Link: `Category` > `Collections > Eco Friendly`
	4. Content > Button Text: `Shop the Collection`


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
		3. Bottom Margin: `0`
		4. Left Margin: `0`
		5. Top Padding: `10px`
		6. Right Padding: `10px`
		7. Bottom Padding: `10px`
		8. Left Padding: `10px`

26. Save the page (we'll add more to it later).

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

<a id="page-builder-content"></a>
##### Page Builder Content
Next, re-create the `Luma Home Page (US)` above (or delete the existing DE block and duplicate `Luma Home Page (US)`) and make the following updates:

1. **Row 1 > Banner:**
	1. Content > Message Text > Line 1: `Neue Yoga Kollektion`	
	2. Content > Message Text > Line 2: `Get fit and look fabulous mit unseren neuen seasonal Styles`
	3. Content > Button Text: `Jetzt Yoga shoppen`

3. **Row 2 > Left Column > Text Element:**
	1. Content Line 1: `20% Rabatt`
	2. Content Line 2: `auf unsere Luma Hoodies, wenn Sie heute bestellen`

4. **Row 2 > Center Column > Text Element:**
	1. Content Line 1: `Hören Sie von Erin`
	2. Content Line 2: `Luma-Gründerin Erin Renney teilt ihre Favoriten`

5. **Row 2 > Right Column > Text Element:**
	1. Content Line 1: `Alle Hemden`
	2. Content Line 2: `Kaufe 3 T-Shirts und erhalte eine Viertes gratis dazu`

6. **Row 3 > Banner**
	1. Content > Message Text > Line 1: `Zweimal herum, doppelt so schön`	
	2. Content > Message Text > Line 2: `Schauen Sie sich unsere nachhaltige, komfortable und umweltfreundliche Kollektion an`
	3. Content > Button Text: `Shop the Collection`

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

<a id="page-builder-content-1"></a>
##### Page Builder Content
TBD

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
The theme customizer is an extension that attaches a CSS-based skin to an existing theme.  It ships with a collection of base skins that an SC can duplicate, customize, and then apply to a custom theme in order to apply a custom look and feel.  The VM ships with a Custom theme specifically for this purpose.  Unfortunately, the "Luma" skin does not fully map to all the necessary styles in the theme and requires the SC to add additional CSS styles to control the look and feel.

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
7. Button Background Color:`#ffffff`

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
/* Forgot Password and Cancel Links (These are tricky, trust me) */
.actions-toolbar .secondary a.action.remind,
.modal-popup .actions-toolbar .secondary .action,
.field-attachment label,
.field-attachment label:before,
.quote-grid-filters-wrap .action { 
    background-color: white !important;
    color: #264294 !important;
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
    border-color: #ff5501;
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
    color: #575757 !important;
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

/* Product Detail Page */

/* Photo Gallery Outlines */
.fotorama__thumb-border { 
    border-color: #ff5501;
}
/* Swatch Borders */
.swatch-option.image:not(.disabled):hover,
.swatch-option.color:not(.disabled):hover,
.swatch-option.selected { 
    outline: #ff5501; 
}
/* Add to Wishlist */
.bundle-options-container .block-bundle-summary .product-addto-links>.action, .product-item-actions .actions-secondary>.action, .product-social-links .action.tocompare, .wishlist.split.button>.action.split, .product-social-links .action.mailto.friend, .product-social-links .action.towishlist, .block-bundle-summary .action.towishlist, .product-item .action.towishlist, .table-comparison .action.towishlist {
	color: #1979c3;
}

/* Shopping Cart Styles */
.cart.table-wrapper .wishlist.split.button>.action.split, .cart.table-wrapper .wishlist.split.button>.action.toggle,
.gift-item-block .title,
.paypal-review-discount .block>.title strong, .cart-discount .block>.title strong {
	color: #1979c3;	
}
.gift-options .actions-toolbar .secondary .action-cancel {
	background-color: white !important;
        color: #575757 !important;
}

/* Checkout Styles  - Orange Progress Bars, etc */
.opc-progress-bar-item._active:before,
.opc-progress-bar-item._active>span:before {
	background: #ff5501;
	border-color: #ff5501;
}
.opc-progress-bar-item._active>span:after,
.opc-wrapper .shipping-address-item.selected-item {
	border-color: #ff5501;
}
.opc-wrapper .shipping-address-item.selected-item:after {
	background: #ff5501;
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
	color: #1979c3 !important;
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
	background: #1979c3 !important; 
}
/* Page Builder Slider Arrows */
.slick-prev:before,
.slick-next:before,
.slick-prev:after,
.slick-next:after { 
	color: #1979c3 !important; 
}
```
<a id="add-additional-language-packs"></a>
#### Add Additional Language Packs
At this point, the code base contains language packs for US English and German.  Since our SC colleagues are dispersed throughout the world, we'll include some additional language packs so that our colleagues can use them in their custom demos.  For now, we'll include:

1. Brazilian Portuguese
2. Argentine Spanish
3. Hindi
4. Japanese
5. Korean
6. Traditional Chinese

1. Add the following lines to the `require` section of `composer.json`:

```
"community-engineering/language-es_ar": "dev-master",
"community-engineering/language-hi_in": "dev-master",
"community-engineering/language-ja_jp": "dev-master",
"community-engineering/language-ko_kr": "dev-master",
"community-engineering/language-pt_br": "dev-master",
"community-engineering/language-zh_cn": "dev-master"
```

2. Since these are just language packs, we can use: `add-key && composer update && clean`

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

<a id="add-a-monogram-as-a-custom-option-to-the-strive-shoulder-pack"></a>
#### Add a Monogram as a Custom Option to the Strive Shoulder Pack
In order to demonstrate product custom options, we'll create a monogram option on the `Strive Shoulder Pack` product.

Navigate to `Catalog > Products > Strive Shoulder Pack`

*All Store Views*

1. Expand `Customizable Options`
2. Add an option
3. Option Title: `Add Your Initials`
4. Input: `Text Field`
5. Required: `No`
6. Price: `25%`
7. SKU: `engraving`
8. Max Characters: `5`

*Luma Website > Luma Store > Deutsch Store View*

1. Option Title: `Fügen Sie Ihre Initialen`

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
3. In order to demo the rearrangement of products via drag-and-drop, we can't have rules active (for some odd reason), so be sure to turn the rule off after the category is populated.  (This will collapse the rule interface, but if you re-enable the rule during a demo, the rule is still present and shows well.)

Once saved, verify the products have been added to the category as shown above.

<a id="sale-category"></a>
#### Sale Category
*Populating the Category*
We'll use a similar approach to the Featured Products category to populate the sale category:

Navigate to `Stores > Settings > Configuration > Catalog > Visual Merchandiser`

1. Find the `Sale` attribute in the `Visible Attributes for Category Rules` multi-select
2. Hold `Command` (Mac) to maintain the attributes which are already selected and click the `Sale` attribute to add it
3. Save the change

Next, we'll populate our Featured Products category using a Visual Merchandiser rule:

Navigate to `Catalog > Categories > Luma Catalog > Promotions > Featured Products`

1. Products in Category:
	1. Match products by rule: `Yes`
	2. Click `Add Condition`
		1. Attribute: `Sale`
		2. Operator: `Equal`
		3. Value: `Yes`
2. Save the category
3. In order to demo the rearrangement of products via drag-and-drop, we can't have rules active (for some odd reason), so be sure to turn the rule off after the category is populated.  (This will collapse the rule interface, but if you re-enable the rule during a demo, the rule is still present and shows well.)

Once saved, verify the products have been added to the category as shown above.

*Setting Up Category Permissions*
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
		3. Customer Group **is not** **VIP**
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
		3. Customer Group **is not** **VIP**
7. Save the segment

Once saved, use the `clean` command to reindex and refresh cache.

<a id="gold-tier"></a>
###### Gold Tier
Navigate to: `Customers > Customer Segments > Add Segment`

1. General Properties > Segment Name: `LUMA Rewards - Gold ($1000 - $2000)`
2. General Properties > Assigned to Website: `Luma Website`
3. General Properties > Status: `Active`
4. General Properties > Apply To: `Registered Customers`
5. Save and Continue
6. Conditions:
	1. If **ALL** of these conditions are **TRUE**:
		1. **Total** Sales Amount **equals or greater than** **1000** while **ALL** of these Conditions match:
		2. **Total** Sales Amount **equals or less than** **2000** while **ALL** of these Conditions match:
		3. Customer Group **is not** **VIP**
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
	2. Customer Group **is** **VIP**
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

Next we'll set up **Lisa Firey** so that she fits this segment:

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

<a id="20-off-every-200-plus-purchase-3000-reward-points"></a>
##### 20% Off Every $200-plus Purchase (3000 Reward points)
Navigate to `Marketing > Promotions > Cart Price Rules`

1. By default, the grid is strangely sorted.  Sort it by ID
2. Rename `20% OFF Ever $200-plus purchase!*` to `3000 Reward Points for $200-plus purchase of Women's Tops`
3. Update the description: `Award 3,000 reward points for orders totaling $200 or more which contain products from the Women > Tops sub-categories. Do not apply to Platinum Reward Members or VIP Members. Do not apply to items in the Sale category.`
4. Conditions:
	1. If **ALL** of these conditions are **TRUE:**
		1. Subtotal **equals or greater than** **200**
		2. If Customer Segment **is not one of** **6, 9** (Don't offer to VIP customers or Platinum Reward members)
5. Actions:
	1. Apply: `Percent of product price discount`
	2. Discount Amount: `0`
	3. Maximum Qty Discount is Applied To: `0`
	4. Discount Qty Step (Buy X): `0`
	5. Apply to Shipping Amount: `No`
	6. Discard subsequent rules: `No`
	7. If **ALL** of these conditions are **TRUE:**
		1. If **ALL** of these conditions are **FALSE:**
			1. Category **is** **6**
			2. Sale **is** **Yes**
		2. Category **is one of** **24, 25, 26, 27**
	8. Free Shipping: `No`
	9. Add Reward Points: `3000`

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

<a id="featured-products-all-customers"></a>
##### Featured Products (All Customers)
First, we'll create a featured products list for guest and registered customers, starting with the US Market:

Navigate to `Content > Elements > Dynamic Blocks`

1. Add a new Dynamic Block and use the following settings:
	1. Enable Dynamic Block: `Yes`
	2. Dynamic Block Name: `Featured Products (All Customers)`
	3. Dynamic Block Type: `Any Dynamic Block Type`
	4. Customer Segment: `All Segements`

Content will consist of one row containing some headings and a products list element which refers to the `Featured Products` category.  We'll also show off the *hide* feature by including a hidden HTML element containing a different appearance for the headings.

1. Drag a `text` element into the first row
	1. Content Line 1:
		1. Format: `Heading 2`
		2. Font Size: `36px`
		3. Line Height: `Line Height`
		4. Text: `Hot Sellers`
		5. Color: `Black`
	2. Content Line 2:
		1. Format: `Heading 2`
		2. Font Size: `26px`
		3. Line Height: `Line Height`
		4. Text: `Here's what's trending on Luma right now`
		5. Color: `Black`

2. Drag an `HTML Code` element into the row beneath the text element
3. Paste the following

```
<div class="content-heading">
    <h2 class="title">Hot Sellers</h2>
    <p class="info">Here is what`s trending on Luma right now</p>
</div>
```

4. Hide the HTML element
5. Drag products list element into the row beneath the hidden HTML element
6. Advanced > Alignment: `Center` (Optional, but useful to illustrate the expected result)
7. Add a `Products List` element and use the following settings:
	1. Condition:
		1. If **ALL** of these conditions are **TRUE**
			1. Category **is** **62**
	2. Number of Products to Display: `5`
	3. Advanced > Alignment: `Center`
8. Save the Dynamic Block

**Note:** Creating the dynamic block using `All Store Views` first is mandatory.  For some reason, Magento doesn't render store view specific dynamic blocks which are nested inside of static blocks, but it *does* render the content assigned to *All Store Views*.  By assigning the block to *All Store Views*, we ensure we can see it render in the home page content block which we'll use to demo most often.

Next, open the same Dynamic Block and repeat for the German store view:

1. Switch the store view scope to `Luma > Luma Store > Deutsch`
2. Deselect `Use Default Value`
3. Drag a `text` element into the first row
	1. Content Line 1:
		1. Text: `Hot Sellers`
	2. Content Line 2:
		1. Text: `Favoriten von Luma Shoppers`
4. Update the HTML to:
```
<div class="content-heading">
   <h2 class="title">Hot Sellers</h2>
   <p class="info">Favoriten von Luma Shoppers</p>
</div>
```
5. Hide the HTML element

Once the dynamic block is created, we need to add it to the Home Page blocks for the US and German store views:

Navigate to `Content > Elements > Blocks > Home Page Block - US`

1. Add the `Featured Products (All Customers)` dynamic block to the empty fourth row in the page we created earlier
2. Save

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

1. Drag a `text` element into the first row
	1. Content Line 1:
		1. Format: `Heading 2`
		2. Font Size: `36px`
		3. Line Height: `Line Height`
		4. Text: `Because You Love Running`
		5. Color: `Black`
	2. Content Line 2:
		1. Format: `Heading 2`
		2. Font Size: `26px`
		3. Line Height: `Line Height`
		4. Text: `#RunningIsLife`
		5. Color: `Black`

2. Drag an `HTML Code` element into the row beneath the text element
3. Paste the following

```
<div class="content-heading">
    <h2 class="title">Because You Love Running</h2>
    <p class="info">#RunningIsLife</p>
</div>
```

4. Hide the HTML element
5. Drag products list element into the row beneath the hidden HTML element
6. Advanced > Alignment: `Center` (Optional, but useful to illustrate the expected result)
7. Add a `Products List` element and use the following settings:
	1. Condition:
		1. If **ALL** of these conditions are **TRUE**
			1. Activity **contains** **Running**
			2. Visibility **is** **Catalog, Search**
	2. Number of Products to Display: `5`
	3. Advanced > Alignment: `Center`
8. Save the Dynamic Block

Next, open the same Dynamic Block and repeat for the German store view:

1. Switch the store view scope to `Luma > Luma Store > Deutsch`
2. Deselect `Use Default Value`
3. Update the content to:
	1. Content Line 1:
		1. Text: `Weil Du Gerne Läufst`
	2. Content Line 2:
		1. Text: `#LaufenIstLeben`
4. Update the HTML to:
```
<div class="content-heading">
    <h2 class="title">Weil Du Gerne Läufst</h2>
    <p class="info">#LaufenIstLeben
</p>
</div>
```
Once the dynamic block is created, we need to add it to the Home Page blocks for the US and German store views:

Navigate to `Content > Elements > Blocks > Home Page Block - US`

1. Duplicate the `Featured Products (All Customers)` dynamic block, change the newly-added dynamic block to the `Featured Products (Runners)` block, and then drag the `Featured Products (Runners)` block into the *second* row, beneath the three columns
2. Add 10px top margin to the Dynamic Block element
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

1. Drag a `text` element into the first row
	1. Content Line 1:
		1. Format: `Heading 2`
		2. Font Size: `36px`
		3. Line Height: `Line Height`
		4. Text: `Just For You`
		5. Color: `Black`
	2. Content Line 2:
		1. Format: `Heading 2`
		2. Font Size: `26px`
		3. Line Height: `Line Height`
		4. Text: `Here are some items to go with your new jacket!`
		5. Color: `Black`

2. Drag an `HTML Code` element into the row beneath the text element
3. Paste the following

```
<div class="content-heading">
    <h2 class="title">Just For You</h2>
    <p class="info">Here are some items to go with your new jacket!</p>
</div>
```

4. Hide the HTML element
5. Drag products list element into the row beneath the hidden HTML element
6. Advanced > Alignment: `Center` (Optional, but useful to illustrate the expected result)
7. Add a `Products List` element and use the following settings:
	1. Condition:
		1. If **ANY** of these conditions are **TRUE**
			1. **SKU** **contains** **WH08**
			2. **SKU** **contains** **WJ11**
			3. **SKU** **is** **24-UG06**
			4. **SKU** **contains** **MJ06**
			5. **SKU** **contains** **MS08**
	2. Number of Products to Display: `5`
	3. Advanced > Alignment: `Center`
8. Save the Dynamic Block

Next, open the same Dynamic Block and repeat for the German store view:

1. Switch the store view scope to `Luma > Luma Store > Deutsch`
2. Deselect `Use Default Value`
3. Update the content to:
	1. Content Line 1:
		1. Text: `Nur Für Dich`
	2. Content Line 2:
		1. Text: `Hier sind einige passende Artikel zu Ihrer neuen Jacke!`
4. Update the HTML to:

```
<div class="content-heading">
    <h2 class="title">Nur Für Dich</h2>
    <p class="info">Hier sind einige passende Artikel zu Ihrer neuen Jacke!</p>
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

1. Drag a `text` element into the first row
	1. Content Line 1:
		1. Format: `Heading 2`
		2. Font Size: `36px`
		3. Line Height: `Line Height`
		4. Text: `For Your Eyes Only, VIP`
		5. Color: `Black`
	2. Content Line 2:
		1. Format: `Heading 2`
		2. Font Size: `26px`
		3. Line Height: `Line Height`
		4. Text: `Here are some of our newest products`
		5. Color: `Black`

2. Drag an `HTML Code` element into the row beneath the text element
3. Paste the following

```
<div class="content-heading">
    <h2 class="title">For Your Eyes Only, VIP</h2>
    <p class="info">Here are some of our newest products</p>
</div>
```

4. Hide the HTML element
5. Drag products list element into the row beneath the hidden HTML element
6. Advanced > Alignment: `Center` (Optional, but useful to illustrate the expected result)
7. Add a `Products List` element and use the following settings:
	1. Condition:
		1. If **ALL** of these conditions are **TRUE**
			1. New **is** **Yes**
	2. Number of Products to Display: `5`
	3. Advanced > Alignment: `Center`
8. Save the Dynamic Block

Next, open the same Dynamic Block and repeat for the German store view:

1. Switch the store view scope to `Luma > Luma Store > Deutsch`
2. Deselect `Use Default Value`
3. Update the content to:
	1. Content Line 1:
		1. Text: `Nur Für Deine Augen, VIP`
	2. Content Line 2:
		1. Text: `Hier sind einige unserer neuesten Produkte`
4. Update the HTML to:
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

Next, we'll translate this block for the German store view.  

2. Switch the store view scope to `Luma > Luma Store > Deutsch`
3. Deselect `Use Default Value`
4. `Save and continue`
5. Update the text element:
	1. Content Line 1:
		1. Text: `Sie sind fast da!` 
	2. Content Line 2:
		1. Text: `Shoppen Sie für 100 € oder mehr, um` (`Shift+Enter`)
	3. Content Line 3:
		1. Text: `KOSTENLOSEN VERSAND` (`Shift+Enter`)
	4. Content Line 4:
		1. Text: `zu erhalten`
6. Save the dynamic block

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
	6. Background > Background Color: `#006bb4`
	7. Background Image: `None`
	8. Layout > Minimum Height: `None`
	9. Vertical Alignment: `Top`
	10. Advanced > Margins and Padding:
		1. Top Margin: `-45px`
		2. Left Margin: `0`
		3. Right Margin: `0`
		4. Bottom Magin: `0`
		5. Top Padding: `15px`
		6. Left Padding: `15px`
		7. Right Padding: `15px`
		8. Bottom Padding: `15px`

2. Add two columns

**Row 1 > Column 1**
1. Grid Size: `12/12`
2. Appearance: `Centered`
3. Background > Background Color: `None`
4. Background > Background Image:
	1. Choose `Select from Gallery`
	2. Create an `icons` folder in `wysiwyg`
	2. Upload the `free-shipping-white-icon.png` image to the `wyiwyg/icons` folder and select it
5. Background > Background Size: `Contain`
6. Background > Background Position: `Center Left`
9. Layout > Minimum Height: `None`
10. Layout > Vertical Alignment: `Center`
11. Advanced > Margins and Padding:
	1. Top Margin: `0`
	2. Left Margin: `0`
	3. Right Margin: `0`
	4. Bottom Magin: `0`
	5. Top Padding: `10px`
	6. Right Padding: `10px`
	7. Bottom Padding: `10px`
	8. Left Padding: `80px`
2. Add a `Text` element to the right column
	1. Content Line 1:
		1. Format: `Paragraph`
		2. Font Size: `18px`
		3. Line Height: `Line Height`
		4. Text Color: `White`
		4. Text: `Free Shipping applied!`
	2. Advanced > Margins and Padding: 
		1. Top Margin: `0`
		2. Left Margin: `0`
		3. Right Margin: `0`
		4. Bottom Magin: `0`
		5. Top Padding: `0`
		6. Left Padding: `0`
		7. Right Padding: `0`
		8. Bottom Padding: `0`
3. Related Promotions > Add Cart Price Rules > `Spend $100 or more - shipping is free!`
4. Save the Dynamic Block

**Note:** The reason for the -45px top margin above has to do with how Magento displays Dynamic Block rotator widgets. In our example, we'll be displaying two separate dynamic block rotator widgets on the same shopping cart page.  Each of these rotators is contained within its own `div` element which is still *visible* on the page (only its *content* is hidden and displayed based on segmentation). Therefore, each Dynamic Block Rotator widget's containing `div` is still affected by padding and margin.

Next, we'll translate this block for the German store view.  

5. Switch the store view scope to `Luma > Luma Store > Deutsch`
6. Deselect `Use Default Value`
7. `Save and continue`
8. Update the text element:
	1. Content Line 1:
		1. Text: `Kostenloser Versand beantragt!` 
9. Save the dynamic block

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
1. Change the top row background image to `promotions/valentineshero.png`
2. Text:
	1. Line 1: `From LUMA with Love`
	2. Line 2: `New for Valentine's Day!`
	3. Button: `Shop New Yoga`

<a id="summer-sale-lead-in"></a>
##### Summer Sale Lead-in
1. Change the top row background image to `promotions/summersunset.jpg`
2. Text:
	1. Line 1: `Summer's Here`
	2. Line 2: `Wow your friends and hit the beach in style!`
	3. Button: `Shop New Yoga`


<a id="fourth-of-july-sale"></a>
##### Fourth of July Sale
1. Change the top row background image to `promotions/fireworks.jpg`
2. Text:
	1. Line 1: `Fourth of July Sale`
	2. Line 2: `Today only, get 25% off every one of our world-class bags!`
	3. Button: `Shop Bags`

<a id="summer-sale-lead-out"></a>
##### Summer Sale Lead-out
1. Change the top row background image to `promotions/summersunset.jpg`
2. Text:
	1. Line 1: `Summer's Here`
	2. Line 2: `Wow your friends and hit the beach in style!`
	3. Button: `Shop New Yoga`

<a id="black-friday-lead-in"></a>
##### Black Friday Lead-in
1. Change the top row background image to `promotions/blackfridayleadinhero.jpg`
2. Text:
	1. Line 1: `It's Almost Here`
	2. Line 2: `We've got your covered for Black Friday!`
	3. Button: `Shop New Yoga`

<a id="black-friday-sale"></a>
##### Black Friday Sale
1. Change the top row background image to `promotions/blackfridayweekendhero.jpg`
2. Text:
	1. Line 1: `Today Only`
	2. Line 2: `Get 30% off ALL THE THINGS for Black Friday!`
	3. Button: `Shop Now`

<a id="holiday-campaign"></a>
##### Holiday Campaign
1. Change the top row background image to `promotions/holidayhero.png`
2. Text:
	1. Line 1: `Welcome the season in style`
	2. Line 2: `Happy Holidays from LUMA!`
	3. Button: `Shop New Yoga`

<a id="additional-page-builder-content"></a>
### Additional Page Builder Content

<a id="category-landing-page-template"></a>
#### Category Landing Page Template

<a id="gear-category-landing-page"></a>
#### Gear Category Landing Page
Initially, the Gear category is set to show a static block of content via a Static Block widget, and the category's display mode is set to *Static Block Only*.  We'll change the display to show *Products Only* so that the SC can use it as part of a landing page creation use case.

Navigate to `Content > Elements > Widgets > Gear Category Content`

1. Layout Updates: `Delete Layout Update`
2. Save

Next, let's also remove the Gear category left navigation.  This is not layered navigation - it's a separate CMS block/widget pair `Gear Left Menu`.

Navigate to `Content > Elements > Widgets > Gear Left Menu`

1. Layout Updates: `Delete Layout Update`
2. Save

When done, clear cache

Navigate to `Catalog > Categories > Gear`

1. Display Settings > Display Mode: `Products only`
2. Layout Updates:

```
<referenceContainer name="catalog.leftnav" remove="true"/>
<referenceContainer name="sidebar.main" remove="true"/>
<referenceContainer name="sidebar.additional" remove="true"/>
```

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
4. Deselect `Strive Shoulder Pack`, `Savvy Shoulder Tote`, `Endeavor Daytrip Backpack`, `Dual Handle Cardio Ball`
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

*See the following: [Kukla VM and B2B](B2B.md)*

<a id="fixes"></a>
### Fixes
*TODO: Convert the core file changes listed in the following sections to legitimate patches that can then be applied via composer.*

Sources: [CWeagans Composer Patching Plugin](https://github.com/cweagans/composer-patches/)

<a id="staging-and-preview-preview-link-and-share-url-broken"></a>
#### Staging and Preview "Preview" Link and Share URL Broken
A small break in javascript prevents an admin user from selecting a different date in the staging calendar and previewing it with the big orange "Preview" button.  The same issue also prevents the share URL from being shown where expected.  

To fix:

In `vendor/magento/module-staging/view/adminhtml/web/js/preview/preview.js`, on line 331, change:

```
return -store.baseUrl.length;
```
to
``` 
return -store.baseUrl;
```

Then, remove the adminhtml area's deployed static content, update permissions, recompile dependencies, and deploy german and other static content:

```
www
rm -rf pub/static/*
add-modules
```

Finally, clear your browser cache for good measure.

<a id="pickup-in-store-quantity-is-mis-aligned"></a>
#### Pickup In Store Quantity is Mis-Aligned
For some reason, the quantity statement in the Pick Up In Store Module overlay is mis-aligned and needs to be adjusted:

1. In `vendor/magentoese/module-instorepickup/view/frontend/web/js/templates/result.html`, on line 12, add CSS margin to move the "Available" string: `span style="float: right; margin-right: 20%;"`
2. Save with `Esc`, then `:wq` and `Enter`
3. Clear `pub/static`, then clear the cache.  After, re-deploy static content for US and German store views: `rm -rf pub/static/ && rm -rf var/cache/* var/page_cache/* && deploy-content && deploy-content-de`
4. Note: You may need to clear browser cache to see the change

<a id="pickup-in-store-extension-breaks-b2b-checkout"></a>
#### Pickup In Store Extension Breaks B2B Checkout

1. `vim vendor/magento/module-negotiable-quote/Block/Checkout/LayoutProcessor.php`
2. Comment out line 56: `$cartItemsComponent['template'] = self::TEMPLATE_CART_ITEMS;`
3. Recompile classes, deploy static content, reindex and clear cache with: `di-compile && deploy-content && deploy-content-de && clean`

<a id="image-gallery-uses-prepend-instead-of-replace"></a>
#### Image Gallery Uses Prepend Instead of Replace

1. `vim vendor/magento/theme-frontend-luma/etc/view.xml`, 
2. Use the `/` key and search for the word `prepend`.  
3. Change it from `prepend` to `replace`
4. Save with `Esc`, then `:wq` and `Enter`
5. Clear the cache with: `cache`

<a id="find-your-local-store-string-isnt-translated"></a>
#### "Find Your Local Store" String Isn't Translated

1. `vim vendor/magentoese/module-instorepickup/view/frontend/web/js/store_selector.js`
2. Use `set number` to view line numbers
3. In the `translate_` function, on line 40, (after the comment), add: `var nothing = $.mage.__('Find your local store');`
4. Save and exit with `:wq`
5. Compile dependencies and deploy static content, clear cache and reindex with: `di-compile && deploy-content && clean`

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
At the moment, there's a known issue which causes emails sent from Magento to use the wrong email sender value.  The source thread below explains how we might look at fixing this by modifying the core code.  

Sources: [Confirmation emails have no FROM or FROM email address 2.2.4 #14952](https://github.com/magento/magento2/issues/14952)
