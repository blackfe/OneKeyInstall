#!/bin/bash

wget --no-check-certificate -O appex.sh https://raw.githubusercontent.com/0oVicero0/serverSpeeder_Install/master/appex.shmaster/appex.sh && chmod +x appex.sh && bash appex.sh Install

wget --no-check-certificate -O ./.dircolorshttps://raw.githubusercontent.com/onekeyshell/kcptun_for_ss_ssr/master/kcptun_for_ss_ssr-install.sh

chmod 700 ./kcptun_for_ss_ssr-install.sh

sed -i 's/def_ssr_pwd=`fun_randstr`/def_ssr_pwd=\"62544872\"/g' ./kcptun_for_ss_ssr-install.sh
sed -i 's/def_ssr_pwd=`fun_randstr`/def_ssr_pwd=\"62544872\"/g' ./kcptun_for_ss_ssr-install.sh
./kcptun_for_ss_ssr-install.sh install

sed -i 's/echo \"sh \/root\/install_ssr_kcp.sh\"//g' /root/.profile
