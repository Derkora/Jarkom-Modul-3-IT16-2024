touch /etc/nginx/sites-available/laravel

echo 'server {
# PORT 8001
# PORT 8002
# PORT 8003

        listen [PORT];
        root /var/www/laravel-praktikum-jarkom/public;

        index index.php index.html index.htm;
        server_name _;

        location / {
                try_files $uri $uri/ /index.php?$query_string;
        }

        # pass PHP scripts to FastCGI server
        location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.0-fpm.sock;
        }

location ~ /\.ht {
            deny all;
    }

        error_log /var/log/nginx/implementasi_error.log;
        access_log /var/log/nginx/implementasi_access.log;
}' > /etc/nginx/sites-available/laravel

ln -s /etc/nginx/sites-available/laravel /etc/nginx/sites-enabled/

service php8.0-fpm restart
service nginx restart

echo 'run lynx localhost:[PORT]'