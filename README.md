# MongoDB Doc Transalation

## 服务器选型

Server: Ubuntu 14.04， 4 core以上 （build takes time)
Docker installed

## 安装MongoDB文档工具

	cd ~
	git clone http://github.com/mongodb-china/docs
	sudo docker run -d -v ~/docs:/opt/docs -p 80:80 -p 8080:8080 tjworks/mongodb-chinese-docs
	



### 1. 系统编码设置
Add following line to **/etc/python2.7/sitecustomze.py**

	import sys
	reload(sys)
	sys.setdefaultencoding('utf-8')

### 2. 安装编译工具

	sudo apt-get update
	sudo apt-get install python-sphinx python-yaml python-argparse inkscape python-pip  
	sudo pip install droopy fabric
	sudo apt-get install git
	sudo pip install giza
	
	
	git clone https://github.com/tjworks/docs
	python bootstrap.py

### 3. 编译英文文档
	
	make html

Note:
  pip show requests
  sudo pip install requests==2.6.0

## 关于Web服务器

我们需要一个web服务器来服务生成好的文档页面
	
	sudo apt-get install apache2
	sudo ln -s ~/docs/build/master_cn/html /var/www/html/manual
	sudo /etc/init.d/apache2 restart


## Setup auto build using flask webhook

  
     git clone https://github.com/razius/flask-github-webhook.git
     cd flask-github-webhook
     sudo pip install -r requirements.txt 
     # edit index.py/repos.json 
     # start flask daemon on port 8081
     nohup python index.py 8001 > flask.log &

## 常见问题

#### Fix build error caused by invalid PO file
-------------------------------------------

The current build process may halt if there is an error in the PO file. When that happens, the error message does not indicate what exactly is wrong. If you suspect the build process is not working, use following process to diagnose:

1. Log onto docs.mongoing.com using SSH
2. Check if flask webhook daemon is running:  
   ``curl localhost:8001``
3. Check ~/flask-github-webhook/flask.log for errors. You might find something like this::

::

  INFO:giza.content.examples:wrote example: /home/ubuntu/docs/build/master/source/includes/examples/example-gs-remove.rst
  Traceback (most recent call last):
  File "/usr/local/bin/giza", line 9, in <module>
    load_entry_point('giza==0.2.6', 'console_scripts', 'giza')()
  File "/usr/local/lib/python2.7/dist-packages/giza/cmdline.py", line 124, in main
    argh.dispatch(parser, namespace=args)
  File "/usr/local/lib/python2.7/dist-packages/argh/dispatching.py", line 125, in dispatch
    for line in lines:
  File "/usr/local/lib/python2.7/dist-packages/argh/dispatching.py", line 202, in _execute_command
    for line in result:
  File "/usr/local/lib/python2.7/dist-packages/argh/dispatching.py", line 158, in _call
    result = args.function(args)
  File "/usr/local/lib/python2.7/dist-packages/giza/operations/sphinx.py", line 40, in sphinx
    sphinx_publication(c, args, app)
  File "/usr/local/lib/python2.7/dist-packages/giza/operations/sphinx.py", line 78, in sphinx_publication
    app.run()
  File "/usr/local/lib/python2.7/dist-packages/giza/core/app.py", line 251, in run
    self._run_mixed_queue()
  File "/usr/local/lib/python2.7/dist-packages/giza/core/app.py", line 240, in _run_mixed_queue
    self.results.extend(task.run())
  File "/usr/local/lib/python2.7/dist-packages/giza/core/app.py", line 249, in run
    self._run_single(self.queue[0])
  File "/usr/local/lib/python2.7/dist-packages/giza/core/app.py", line 210, in _run_single
    self.results.append(j.run())
  File "/usr/local/lib/python2.7/dist-packages/giza/core/task.py", line 150, in run
    r = self.job(*self.args)
  File "/usr/local/lib/python2.7/dist-packages/giza/content/sphinx.py", line 174, in run_sphinx
    command('sphinx-intl build --language=' + sconf.language)
  File "/usr/local/lib/python2.7/dist-packages/giza/tools/command.py", line 138, in command
    raise CommandError('[ERROR]: "{0}" returned {1}'.format(out.cmd, out.return_code))
  giza.tools.command.CommandError: [ERROR]: "sphinx-intl build --language=zh" returned 1
  make: *** [html-zh] Error 1


If you see this error, this most likely means there is a PO file with invalid format. You can then look for error string "Syntax error in po file" in the earlier log, like this:

::

  locale/zh/LC_MESSAGES/tutorial/manage-mongodb-processes.po

  Traceback (most recent call last):
  File "./mongodb-docs-translation/checkpo", line 31, in <module>
    missing = tuple(check_files([line]))
  File "/usr/local/lib/python2.7/dist-packages/po_file_checker/base.py", line 51, in check_files
    for key in missing_keys(polib.pofile(filename)):
  File "/usr/local/lib/python2.7/dist-packages/polib.py", line 138, in pofile
    return _pofile_or_mofile(pofile, 'pofile', **kwargs)
  File "/usr/local/lib/python2.7/dist-packages/polib.py", line 86, in _pofile_or_mofile
    instance = parser.parse()
  File "/usr/local/lib/python2.7/dist-packages/polib.py", line 1292, in parse
    self.process(keywords[tokens[0]])
  File "/usr/local/lib/python2.7/dist-packages/polib.py", line 1436, in process
    self.current_line)
  IOError: Syntax error in po file (line 254)
 
Above error message indicates there is an error in line 254 of ``manage-mongodb-processes.po`` file. Fix it in local repo, commit & push it to github and it should(hopefully) resume the auto-build process. 





cd ~
git clone git@github.com:tjworks/docs
cd build/
mv docs-tools docs-tools-backup
 git clone git@github.com:tjworks/docs-tools
cd ~/docs




# docs-addon


Additional doc tools specifically for Chinese doc




### docker script

FROM     ubuntu:14.04
MAINTAINER TJ Tang "jianfa.tang@mognodb.com"

RUN apt-get update
RUN apt-get install -y git inkscape python-pip 
RUN pip install giza
RUN pip install --upgrade six

RUN mkdir -p /opt/docs
WORKDIR /opt/docs

ENV TESTENV TESTVAL
ADD etc/sitecustomize.py /etc/python2.7/sitecustomize.py
ADD etc/setup.sh /opt/setup.sh

CMD ["/bin/bash"]

### docker script old



FROM     ubuntu:14.04
MAINTAINER TJ Tang "jianfa.tang@mognodb.com"


RUN apt-get update 
RUN apt-get install -y git curl python
RUN apt-get install -y python-sphinx python-yaml python-argparse inkscape python-pip 
RUN pip install giza
RUN apt-get install -y python droopy fabric

RUN mkdir -p /opt/mongo-docs
WORKDIR /opt/mongo-docs

ENV TESTENV TESTVAL
ADD etc/sitecustomize.py /etc/python2.7/sitecustomize.py
ADD etc/setup.sh /opt/setup.sh

CMD ["/bin/bash"]
#ENTRYPOINT ["/bin/bash"]


##### Build ####
#  docker build --rm=true -t tjworks/mongo-docs .

#####  Local test run ###
# docker run -i -v /home/docker/osx/docs:/opt/mongo-docs -t tjworks/mongo-docs 

#### init
#	git clone https://github.com/tjworks/docs
#	python bootstrap.py

#### Install ###
#	install docker
#	docker run -i -t tjworks/mongo-docs -v /home/docker/osx/mongo-docs:/opt/mongo-docs	/opt/setup.sh
# 	docker run -i -t tjworks/mongo-docs -v /home/docker/osx/mongo-docs:/opt/mongo-docs