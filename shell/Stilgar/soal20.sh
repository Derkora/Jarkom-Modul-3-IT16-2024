echo 'upstream workers { 
    least_conn;
    server 192.176.2.2:8001;
    server 192.176.2.3:8002;
    server 192.176.2.4:8003;
}

server {
        listen 80;
        server_name atreides.it16.com;

        location / {
        proxy_pass http://workers;
        }
}' > /etc/nginx/sites-available/laravel

service nginx restart