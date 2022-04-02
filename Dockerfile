FROM centos:7

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
# centos设置环境变量会报/bin/sh: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8)
ENV LANG zh_CN.UTF-8
ENV LC_ALL zh_CN.UTF-8
# 所以需要在设置环境变量之后使用localedef创建一个字符集
RUN localedef -c -f UTF-8 -i zh_CN zh_CN.utf8

RUN set -ex \
	&& yum -y install zlib-devel bzip2-devel libffi-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel git gcc make wget \
	&& yum clean all \
	&& mkdir /usr/local/python3 \
	&& wget https://www.python.org/ftp/python/3.6.8/Python-3.6.8.tar.xz \
	&& tar -xvJf  Python-3.6.8.tar.xz && rm -f Python-3.6.8.tar.xz \
	&& cd Python-3.6.8 \
	&& ./configure prefix=/usr/local/python3 \
	&& make && make install \
	&& cd .. \
	&& rm -rf Python-3.6.8 \
	&& ln -s /usr/local/python3/bin/python3.6 /usr/local/bin/python3 \
	&& ln -s /usr/local/python3/bin/pip3 /usr/local/bin/pip3 \
