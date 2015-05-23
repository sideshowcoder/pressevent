[![Build Status](https://travis-ci.org/sideshowcoder/pressevent.png)](https://travis-ci.org/sideshowcoder/pressevent)

Pressevent
==========

Get notifications for your running wordpress instances, and never miss an
important update again. [Pressevent](http://pressevent.herokuapp.com) is hosted
on heroku.

How?
----
Pressevent will monitor registered wordpress installations for updates and sent
out email reports once a day. Since It's not nice to give away the keys to the
kingdom pressevent works with [WP Updater
API](http://wordpress.org/plugins/wp-updater-api/) which allows access to just
the information about updates via an API key. It's easily installed and
configured like any other Wordpress Plugin.

Getting started with development
--------------------------------
Install all the dependencies via bundler first

    $ bundle install

Create the needed configuration files

    $ cp sample.env .env

Now run the tests via

    $ RAILS_ENV=test rake test:all

Everything should work fine, and you can start a [development
server](http://localhost:3000) and [mailcatcher](http://localhost:1080) via

    $ rake development:server

Deploying
---------
Pressevent runs on heroku, so you just need to create the app with Sendgrid as a
plugin activated, and then

    $ git push heroku master

takes care of deploy. To have the daily report emails sent just setup a cronjob
via Heroku Scheduler to run

    $ rake pressevent:automatic_update_report

Just to be save set a secret token as well

    $ heroku config:set SECRET_KEY_BASE=`rake secret`

Info
----
Licensed under MIT License. Copyright (c) 2015 Sideshowcoder. See LICENSE.txt for
further details.
