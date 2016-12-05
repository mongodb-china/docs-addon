#!/bin/sh

#/etc/init.d/apache2 restart

# checkout source codes
git clone http://github.com/mongodb-china/docs.git /opt/docs
git clone http://github.com/mongodb-china/docs-addon.git /opt/docs-addon

# start github-webhook
cd /opt/docs-addon/github-hook
nohup python index.py 8001 > hook.log &

# start direct push script
cd /opt/docs

# edit index.py/repos.json 
# start flask daemon on port 8081

