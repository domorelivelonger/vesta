
yum -y install pptpd

cat >>/etc/pptpd.conf<<EOF
localip 10.10.0.1
remoteip 10.10.0.100-200
EOF

cat >>/etc/ppp/chap-secrets<<EOF
user1 pptpd password1 *
EOF

cat >>/etc/ppp/pptpd-options<<EOF
ms-dns 8.8.8.8
ms-dns 8.8.4.4
EOF

cat >>/etc/sysctl.conf<<EOF
net.core.wmem_max = 12582912
net.core.rmem_max = 12582912
net.ipv4.tcp_rmem = 10240 87380 12582912
net.ipv4.tcp_wmem = 10240 87380 12582912
net.core.wmem_max = 12582912
net.core.rmem_max = 12582912
net.ipv4.tcp_rmem = 10240 87380 12582912
net.ipv4.tcp_wmem = 10240 87380 12582912
net.core.wmem_max = 12582912
net.core.rmem_max = 12582912
net.ipv4.tcp_rmem = 10240 87380 12582912
net.ipv4.tcp_wmem = 10240 87380 12582912
net.ipv4.ip_forward = 1
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
EOF
sysctl -p


cat >>/etc/rc.local<<EOF
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE && iptables-save
iptables --table nat --append POSTROUTING --out-interface ppp0 -j MASQUERADE
iptables -I INPUT -s 10.10.0.0/8 -i ppp0 -j ACCEPT
iptables --append FORWARD --in-interface eth0 -j ACCEPT
iptables -A INPUT -i eth0 -p gre -j ACCEPT
iptables -A INPUT -i eth0 -m tcp -p tcp --dport 1723 -j ACCEPT
EOF

service pptpd restart
echo "pptpd user: user1 password: password1"
