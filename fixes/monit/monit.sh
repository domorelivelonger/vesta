yum install monit -y
systemctl enable monit
rm -rf /etc/monit*
curl -s https://raw.githubusercontent.com/webxdata/vesta/master/fixes/monit/monit.conf  > /etc/monitrc
touch /home/admin/web/*/public_html/monit_token
/usr/local/vesta/bin/v-add-firewall-rule accept 0.0.0.0/0 2812 tcp
systemctl restart monit
