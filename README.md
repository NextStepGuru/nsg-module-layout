Coldbox Module providing Enhanced Layouts & Basic Site Setup
================

The basic idea for this module is to drop it into a new project. Point the default event & default layout to this module and start tuning your app within a few minutes.

This module provides a way to add layout specific commands on the file per handler/action.

For example, lets say you want to add a new style on a specific event. Just announce it

    announceInterception( state='addPageHeadStyle', 
        interceptData={"href":"mySpecialStyle.css","tag":"link","rel":"stylesheet"});

Or maybe you want to override the pageDefaults with a new title

    announceInterception('addPageHead',{
            'title': "My Cool Title",
            'Description': "This is my awesome page description"
        });

Currently there are nearly a dozen custom interception points preconfigured with more to come. This is my first stab at turning html pages into pure objects that can be manipulated at any point during the request.

*   **addPageHead** - Allows appending or overriding pageDefaults of any meta or other related head tags.
*   **addPageHeadStyle** - Allows appending a new style to the event on the fly.
*   **addBodyTag** - Allows injection of any string into the Body tag.
*   **addHTMLTag** - Allows injection of any string into the HTML tag.
*   **addHeadTag** - Allows injection of any string into the Head tag.
*   **addPageHeadScript** - Allows appending to the scripts within the head. This isn't recommended doing however there are cases where older IE support requires conditional script comment tags. Or perhaps you require jquery to be loaded before anything else on the page. 
*   **addPageBodyScript** - Allows appending scripts at the end of the page. This is a best practice for page loading and async usage.
*   **addPageBeforeEnd** - Allows appending any string to the page before the end of the body content. Great for tracking code.

Setup & Installation
---------------------

###Add the pageDefaults to your Coldbox.cfc's Setting

    settings = {
        // Page Default Setting
        pageDefaults = {
            "styles":[
                {"href":"/modules/nsg-module-layout/assets/css/bootstrap.css","tag":"link","rel":"stylesheet"},
                {"href":"/modules/nsg-module-layout/assets/css/bootstrap-theme.css","tag":"link","rel":"stylesheet"},
                {"href":"/modules/nsg-module-layout/assets/css/bootstrap-social.css","tag":"link","rel":"stylesheet"},
                {"href":"/modules/nsg-module-layout/assets/css/font-awesome.css","tag":"link","rel":"stylesheet"},
                {"href":"/modules/nsg-module-layout/assets/css/font-awesome-social.css","tag":"link","rel":"stylesheet"},
                {"href":"/assets/css/sitewide.css","tag":"link","rel":"stylesheet"}
            ],
            "scripts":[
                {'ifComment'="lt IE 9",'tag':'script','src':"/modules/nsg-module-layout/assets/html5shiv.js"},
                {'ifComment'="lt IE 9",'tag':'script','src':"/modules/nsg-module-layout/assets/respond.js"}
            ],
            "head":[
                {"content":"defaultTitle","tag":"title"},
                {"content":"defaultDescription","tag":"meta","name":"description"},
                {"charset":"utf-8","tag":"meta"},
                {"content":"IE=edge","tag":"meta","http-equiv":"X-UA-Compatible"},
                {"content":"on","tag":"meta","http-equiv":"cleartype"},
                {"content":"width=device-width, initial-scale=1","tag":"meta","name":"viewport"},
                {"href":"//res.cloudinary.com/nextstepguru/image/upload/c_pad,fl_force_strip,g_center,h_16,w_16/nextstepguru-icon.ico","tag":"link","type":"image/x-icon","rel":"shortcut icon"},
                {"href":"https://www.nextstep.guru/","tag":"link","rel":"canonical"}
            ],
            "body":{
                "scripts":[
                    {'tag':'script','src':"/modules/nsg-module-layout/assets/js/jquery-2.1.3.js"},
                    {'tag':'script','src':"/modules/nsg-module-layout/assets/js/bootstrap.js",'async':true},
                    {'tag':'script','src':"/modules/nsg-module-layout/assets/js/modernizr.js",'async':true},
                    {'tag':'script','src':"/assets/js/sitewide.js",'async':true}
                ],
                "end":[]
            }
        }
    };


###Changelog

v1.0.3 - updated menu structure and made it a series of arrays with support for multiple menu locations, role & user logged in support and more.
v1.0.0 - current release - still kinda buggy but I am working to resolve a few issues and I will expand the documentation shortly.