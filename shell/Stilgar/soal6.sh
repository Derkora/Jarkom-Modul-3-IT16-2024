echo nameserver 192.241.3.3 > /etc/resolv.conf
apt-get update
apt-get install bind9 nginx -y

echo '
 upstream myweb  {
        server 192.241.1.2; #IP Vladimir
        server 192.241.1.3; #IP Rabban
        server 192.241.1.4; #IP Feyd
 }

 server {
        listen 80;
        server_name harkonen.it16.com;

        location / {
        proxy_pass http://myweb;
        }
 }' > /etc/nginx/sites-available/lb-jarkom

ln -s /etc/nginx/sites-available/lb-jarkom /etc/nginx/sites-enabled
rm -rf /etc/nginx/sites-enabled/default

service nginx restart
nginx -t