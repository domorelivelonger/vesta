sed -i 's/8083;/8383;/' /usr/local/vesta/nginx/conf/nginx.conf
/usr/local/vesta/bin/v-add-firewall-rule ACCEPT 0.0.0.0/0 8383 TCP gVestaCP

sed -i -e '/8083/ s/ACCEPT/DROP/' /usr/local/vesta/data/firewall/rules.conf 
cat /usr/local/vesta/data/firewall/rules.conf

systemctl restart fail2ban.service
v-update-firewall
systemctl restart vesta
iptables -L -nv | grep 8383 
