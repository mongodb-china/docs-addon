#!/bin/sh

if [ -d "/opt/docs/.git" ]; then
	# mounted host folder
	cd /opt/docs 
	git pull origin master
else
	#empty
	mkdir -p /opt/docs/build
	git clone http://github.com/mongodb-china/docs.git /opt/docs
	git clone http://github.com/mongodb/docs-tools.git /opt/docs/build/docs-tool
fi

cd /opt/docs-addon
git pull origin master

# create shortcut for manual file 
mkdir -p /opt/docs/build/master/html-zh
ln -sf /opt/docs/build/master/html-zh /var/www/html/manual-zh

# user manual-cn theme
sed -i "s/name: 'manual'/name: 'manual-cn'/"  /opt/docs/config/sphinx_local.yaml  

# start direct push script
echo "Starting direct push script 8080"
echo "TBD"

# start github-webhook
echo "Stating github-webhook 8001"
cd /opt/docs-addon/github-hook
python index.py 8080 
