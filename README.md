[![Build Status](https://magnum.travis-ci.com/sideshowcoder/pressevent.png?token=eWqyYZsYyfqua9PJ9ddd&branch=master)](https://magnum.travis-ci.com/sideshowcoder/pressevent)

Pressevent
==========

Get notifications for your running wordpress instances

Getting started with development
--------------------------------
Start by running

    $ ./setup.sh

this will setup the postgres user and create the needed databases. It also copies
the needed .env file in place for you to edit.

Now run the tests via

    $ rake minitest:all

Everything should work fine, and you can start a development server via

    $ foreman start -f Procfile.development

Deploying to Production
-----------------------
Pressevent runs on heroku, so

    $ git push production master

takes care of deploy

Deploying to Staging
--------------------
As for production this is run on heroku

    $ git push staging master

CI
--
CI builds are done via Travis, so if you don't need to build make sure you
include [ci skip] in your commit message

