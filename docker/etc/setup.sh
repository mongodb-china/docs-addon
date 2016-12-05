#!/bin/sh

if [ -d "/opt/docs/.git" ]; then
	# mounted host folder
	cd /opt/docs 
	git pull origin master
else
	#empty	
	echo "### Cloning docs repo"
	git clone http://github.com/mongodb-china/docs.git /opt/docs
	mkdir -p /opt/docs/build
	git clone http://github.com/mongodb/docs-tools.git /opt/docs/build/docs-tool
fi

# workaround for download error with objects.inv 
cp /opt/objects.inv /opt/docs/build

cd /opt/docs-addon
git pull origin master


# create shortcut for manual file 
mkdir -p /opt/docs/build/master/html-zh
ln -sf /opt/docs/build/master/html-zh /var/www/html/manual-zh

# link the chinese theme
ln -sf /opt/manual-cn /opt/docs/build/docs-tool/themes/manual-cn 

# user manual-cn theme
sed -i "s/name: 'manual'/name: 'manual-cn'/"  /opt/docs/config/sphinx_local.yaml  

# restart apache
/etc/init.d/apache2 restart

# start direct push script
echo "Starting direct push script 8080"
echo "TBD"

# start github-webhook
echo "Stating github-webhook 8080"
cd /opt/docs-addon/github-hook
python index.py 8080 
