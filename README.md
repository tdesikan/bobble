BOBBLE
======

Bobble is a ruby gem for pinging your favorite web services &amp; freely or cheaply getting email/SMS notifications when they&#39;re down.

Currently Bobble supports Google Voice, Gmail, and Twilio. Google Voice and Gmail are recommended - they're free!


Usage
-----

Just call this function and you will immediately get an email or text if the URL does not respond. (Assuming you have configured Bobble as below)

    require 'bobble'
    Bobble.check("http://exampleurl.com")

If you want your checks running all the time - use the [bobble template](http://github.com/ahfarmer/bobble-template) to get your bobble checks running on heroku!


Configuration
------------

Currently bobble can be configured by setting environment variables. Pick how you would like to be notified and then set the appropriate environment variables.


1. Gmail
--------

    export BOBBLE_GMAIL_USERNAME=<i.e. example@gmail.com>
    export BOBBLE_GMAIL_PASSWORD=<your gmail password>
    export BOBBLE_GMAIL_TO_EMAIL=<email to receive the notifications>


2. Google Voice
---------------

    export BOBBLE_GVOICE_USERNAME=<i.e. example@gmail.com>
    export BOBBLE_GVOICE_PASSWORD=<your gmail password>
    export BOBBLE_GVOICE_TO_PHONENUMBER=<mobile number to receive notifications, i.e. +14155555555>


3. Twilio
---------

    export BOBBLE_TWILIO_SID=<your twilio SID>
    export BOBBLE_TWILIO_TOKEN=<your twilio auth token>
    export BOBBLE_TWILIO_FROM_PHONENUMBER=<your twilio phone number, i.e. +14155555555>
    export BOBBLE_TWILIO_TO_PHONENUMBER=<mobile number to receive notifications, i.e. +14155555555>


Bobble will determine how you want to be notified based on which environment variables you have set.

But remember - the best way to run bobble is probably by using the [bobble template](http://github.com/ahfarmer/bobble-template) and pushing it to heroku!
