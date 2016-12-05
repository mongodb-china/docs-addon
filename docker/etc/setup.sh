#!/bin/sh

cd /opt/docs-addon 
git pull origin master

cd /opt/docs
git pull origin master

# start direct push script
echo "Starting direct push script 8080"
cd /opt/docs

# start github-webhook
echo "Stating github-webhook 8001"
cd /opt/docs-addon/github-hook
python index.py 8001 
