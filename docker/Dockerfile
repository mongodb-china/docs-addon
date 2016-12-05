FROM     ubuntu:14.04
MAINTAINER TJ Tang "jianfa.tang@mognodb.com"

# Install dependency packages
RUN apt-get update
RUN apt-get install -y git inkscape python-pip apache2
RUN pip install giza
RUN pip install --upgrade six

# used by github-webhook
RUN pip install Flask==0.10.1
RUN pip install ipaddress==1.0.6
RUN pip install requests==2.2.1

# create symbol link for web
RUN mkdir -p /opt/docs/build/master/html-zh
RUN ln -s /opt/docs/build/master/html-zh /var/www/html/manual-zh

WORKDIR /opt/docs

ADD etc/sitecustomize.py /etc/python2.7/sitecustomize.py
ADD etc/setup.sh /opt/setup.sh

# init script to run
ENTRYPOINT ["/opt/setup.sh"]
CMD ["/bin/bash"]


# ENV TESTENV TESTVAL

##### Build ####
#  docker build --rm=true -t tjworks/mongodb-chinese-docs .

#####  Local test run ###
# docker run -i -v /home/docker/osx/docs:/opt/mongo-docs -t tjworks/mongo-docs 

#### init
#	git clone https://github.com/tjworks/docs
#	python bootstrap.py

#### Install ###
#	install docker
#	docker run -i -t tjworks/mongo-docs -v /home/docker/osx/mongo-docs:/opt/mongo-docs	/opt/setup.sh
# 	docker run -i -t tjworks/mongo-docs -v /home/docker/osx/mongo-docs:/opt/mongo-docs

