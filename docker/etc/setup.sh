#!/bin/sh



# checkout source codes
echo "cloning source"
git clone http://github.com/mongodb-china/docs.git /opt/docs
git clone http://github.com/mongodb-china/docs-addon.git /opt/docs-addon

# create symbol link for web
mkdir -p /opt/docs/build/master/html-zh
ln -sf /opt/docs/build/master/html-zh /var/www/html/manual-zh
/etc/init.d/apache2 restart

# start github-webhook
echo "Stating github-webhook 8001"
cd /opt/docs-addon/github-hook
nohup python index.py 8001 > hook.log &

# start direct push script
echo "Starting direct push script 8080"
cd /opt/docs

# edit index.py/repos.json 
# start flask daemon on port 8081

