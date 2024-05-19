echo nameserver 192.241.3.3 > /etc/resolv.conf
apt-get install apache2-utils -y

mkdir /etc/nginx/supersecret
htpasswd -b -c /etc/nginx/supersecret/htpasswd secmart kcksit16

apt-get update
apt-get install bind9 nginx -y

echo '
 upstream myweb  {
        least_conn;
        server 192.241.1.2; #IP Vladimir
        server 192.241.1.3; #IP Rabban
        server 192.241.1.4; #IP Feyd
 }

 server {
        listen 80;
        server_name harkonen.it16.com;

        location / {
        auth_basic "Restricted Access";
        auth_basic_user_file /etc/nginx/supersecret/htpasswd;
        proxy_pass http://myweb;
        }
 }' > /etc/nginx/sites-available/lb-jarkom

ln -s /etc/nginx/sites-available/lb-jarkom /etc/nginx/sites-enabled
rm -rf /etc/nginx/sites-enabled/default

service nginx restart
nginx -t