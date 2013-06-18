[![Build Status](https://magnum.travis-ci.com/sideshowcoder/pressevent.png?token=eWqyYZsYyfqua9PJ9ddd&branch=master)](https://magnum.travis-ci.com/sideshowcoder/pressevent)

Pressevent
==========

Get notifications for your running wordpress instances

Getting started with development
--------------------------------
Start by running

    $ ./setup.sh

this will setup a postgress user and create the needed databases. It also copies
the needed env (.env, config/database.yml) files in place for you to edit.

Now run the tests via

    $ rake test

Everything should work fine, and you can start a development server via

    $ foreman start -f Procfile.development

Deploying
----------
Pressevent runs on heroku, so

    $ git push production master

takes care of deploy

