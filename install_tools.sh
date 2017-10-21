#!/bin/bash
#apt-get install docker docker.io -y
apt-get install libxml2-dev libxslt1-dev build-essential chrpath libxft-dev libssl-dev libffi-dev libreadline6 libreadline6-dev -y
apt-get install libmysqlclient-dev mysql-server -y
apt-get install global ctags w3m xsel aspell emacs -y
apt-get install curl git automake -y
apt-get install ssmtp libsasl2-modules postfix -y
apt-get install lua5.1 -y
#echo "ClientAliveInterval 1800" >> /etc/ssh/sshd_config
#echo "alias ec='emacsclient -t -a=""'" >>~/.bashrc
#echo "alias se='SUDO_EDITOR="emacsclient -t" sudo -e'" >>~/.bashrc
echo "alias python='python3'" >>~/.bashrc
echo "alias pip='pip3'" >> ~/.bashrc

curr_dir=`pwd`
cd ~/
source ~/.bashrc
cd $curr_dir
sh install_py.sh 
#pip3 install requests==2.17.1

#################################
# backup
################################
#echo "0 5    *   *   *   sh /root/backup.sh" > /root/crontab_config
#crontab /root/crontab_config
#/etc/init.d/crond restart

################################
# firewall
##############################
#iptables-restore /root/iptables.rule.1


cd ~; git clone https://github.com/redguardtoo/emacs.d.git .emacs.d; cd .emacs.d; git reset --hard stable

