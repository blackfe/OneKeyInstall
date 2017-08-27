#!/bin/bash
apt-get install docker docker.io  libxml2-dev libxslt1-dev python-dev python-lxml libmysqlclient-dev python3-pip python3 python3-lxml build-essential libssl-dev libffi-dev python3-dev nano emacs curl git automake libreadline6 libreadline6-dev mysql-server lua5.1 -y

pip3 install asn1crypto attrs Automat beautifulsoup4 bs4 certifi cffi chardet colorama configparser constantly cryptography cssselect dropbox html5lib hyperlink idna incremental jieba lxml mysqlclient parsel pip pyasn1 pyasn1-modules pycparser pycrypto PyDispatcher pyOpenSSL queuelib requests schedule Scrapy scrapy-splash selenium service-identity setuptools six Twisted urllib3 w3lib wheel zope.interface


echo "ClientAliveInterval 1800" >> /etc/ssh/sshd_config
echo "alias ec='emacsclient -t -a=""'" >>~/.bashrc
echo "alias se='SUDO_EDITOR="emacsclient -t" sudo -e'" >>~/.bashrc
echo "alias python='python3'" >>~/.bashrc
echo "alias pip='pip3'" >> ~/.bashrc

source ~/.bashrc

pip3 install requests==2.17.1

#################################
# backup
################################
echo "0 5    *   *   *   sh /root/backup.sh" > /root/crontab_config
crontab /root/crontab_config
/etc/init.d/crond restart

################################
# firewall
##############################
iptables-restore /root/iptables.rule.1
