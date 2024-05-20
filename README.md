# Jarkom-Modul-3-IT16-2024

## Anggota Kelompok
| NRP        | Nama                    |
|:----------:|:-----------------------:|
| 5027221020 | Wikri Cahya Syahrila    |
| 5027221021 | Steven Figo             |

### .bashrc
- DHCP Relay
```sh
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.241.0.0/16
apt-get update
apt install isc-dhcp-relay -y
cat /etc/resolv.conf
```
- DHCP Server
```sh
echo 'nameserver 192.241.3.3' > /etc/resolv.conf
apt-get update
apt install isc-dhcp-server -y
```
- DNS Server
```sh
echo 'nameserver 192.168.122.1' > /etc/resolv.conf
apt-get update
apt-get install bind9 -y
```
- Laravel Worker
```sh
echo 'nameserver 192.241.3.3' > /etc/resolv.conf
apt-get update
apt-get install lynx -y
apt-get install mariadb-client -y
apt-get install -y lsb-release ca-certificates apt-transport-https software-properties-common gnupg2
curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg
sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
apt-get update
apt-get install php8.0-mbstring php8.0-xml php8.0-cli   php8.0-common php8.0-intl php8.0-opcache php8.0-readline php8.0-mysql php8.0-fpm php8.0-curl unzip wget -y
apt-get install nginx -y
apt-get install git -y
apt-get install htop -y

service nginx start
service php8.0-fpm start
```
- Client
```sh
apt update
apt install lynx -y
apt install htop -y
apt install apache2-utils -y
apt-get install jq -y
```
- Load Balancer
```sh
echo 'nameserver 192.241.3.3' > /etc/resolv.conf
apt-get update
apt-get install apache2-utils -y
apt-get install nginx -y
apt-get install lynx -y

service nginx start
```
- Database Server
```sh
echo 'nameserver 192.241.3.3' > /etc/resolv.conf
apt-get update
apt-get install mariadb-server -y

service mysql start
```

### prolog
Planet Caladan sedang mengalami krisis karena kehabisan spice, klan atreides berencana untuk melakukan eksplorasi ke planet arakis dipimpin oleh duke leto mereka meregister domain name `atreides.yyy.com` untuk worker Laravel mengarah pada Leto `Atreides` . Namun ternyata tidak hanya klan atreides yang berusaha melakukan eksplorasi, Klan harkonen sudah mendaftarkan domain name `harkonen.yyy.com` untuk worker PHP mengarah pada Vladimir `Harkonen` (0)

penyelesaian:
![Screenshot 2024-05-16 221930](https://github.com/Derkora/Jarkom-Modul-3-IT16-2024/assets/110652010/373cefa6-e150-4ff1-9db7-08bfc03d2f6e)
## Soal 0
- Pada Irulan
```sh
echo 'zone "atreides.it16.com" { 
        type master; 
        file "/etc/bind/atreides/atreides.it16.com";
};

zone "harkonen.it16.com" {
        type master;
        file "/etc/bind/harkonen/harkonen.it16.com";
}; ' >> /etc/bind/named.conf.local

mkdir /etc/bind/atreides
mkdir /etc/bind/harkonen

echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     atreides.it16.com. root.atreides.it16.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      atreides.it16.com.
@       IN      A       192.241.2.2     ; IP Leto' > /etc/bind/atreides/atreides.it16.com

echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     harkonen.it16.com. root.harkonen.it16.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      harkonen.16.com.
@       IN      A       192.241.1.2     ; IP Vladimir' > /etc/bind/harkonen/harkonen.it16.com

echo 'options {
        directory "/var/cache/bind";

        forwarders {
                192.168.122.1;
        };

        // dnssec-validation auto;
        allow-query{any;};
        auth-nxdomain no;
        listen-on-v6 { any; };
}; ' >/etc/bind/named.conf.options

service bind9 restart
```

### bagian 1

(1) Lakukan konfigurasi sesuai dengan peta yang sudah diberikan.

Kemudian, karena masih banyak spice yang harus dikumpulkan, bantulah para aterides untuk bersaing dengan harkonen dengan kriteria berikut.:
- Semua `CLIENT` harus menggunakan konfigurasi dari DHCP Server.
- Client yang melalui House Harkonen mendapatkan range IP dari [prefix IP].1.14 - [prefix IP].1.28 dan [prefix IP].1.49 - [prefix IP].1.70 (2)
- Client yang melalui House Atreides mendapatkan range IP dari [prefix IP].2.15 - [prefix IP].2.25 dan [prefix IP].2.200 - [prefix IP].2.210 (3)
- Client mendapatkan DNS dari Princess `Irulan` dan dapat terhubung dengan internet melalui DNS tersebut (4)
- Durasi DHCP server meminjamkan alamat IP kepada Client yang melalui House Harkonen selama 5 menit sedangkan pada client yang melalui House Atreides selama 20 menit. Dengan waktu maksimal dialokasikan untuk peminjaman alamat IP selama 87 menit (5)
*house == switch

penyelesaian:
## Soal 1
Lakukan konfigurasi jaringan, tapi dengan konfigurasi DHCP pada client
- DHCP Relay (Arakis)
```sh
echo 'SERVERS="192.241.3.2"
INTERFACES="eth1 eth2 eth3 eth4"' > /etc/default/isc-dhcp-relay

echo 'net.ipv4.ip_forward=1' > /etc/sysctl.conf

service isc-dhcp-relay restart
```
- DHCP Server (Mohiam)
```sh
echo 'INTERFACESv4="eth0"' > /etc/default/isc-dhcp-server

service isc-dhcp-server restart
```
Akan failed lalu berhasil ketika menjalankan soal 2-5

## Soal 2-5
- DHCP Server
```sh
echo 'subnet 192.241.1.0 netmask 255.255.255.0 {
#Soal 2 kasih range ip untuk harkonen
        range 192.241.1.14 192.241.1.28;
        range 192.241.1.49 192.241.1.70;
        option routers 192.241.1.1;
#Soal 4 mendapatkan DNS dari Irulan
        option broadcast-address 192.241.1.255;
        option domain-name-servers 192.241.3.3;
#Soal 5 Durasi DHCP
        default-lease-time 300;
        max-lease-time 5220;
}

subnet 192.241.2.0 netmask 255.255.255.0 {
#Soal 3 kasih range ip untuk Atreides
        range 192.241.2.15 192.241.2.25;
        range 192.241.2.200 192.241.2.210;
        option routers 192.241.2.1;
#
        option broadcast-address 192.241.2.255;
        option domain-name-servers 192.241.3.3;
#
        default-lease-time 1200;
        max-lease-time 5220;
}

subnet 192.241.3.0 netmask 255.255.255.0 {
#
        option routers 192.241.3.1;
}

subnet 192.241.4.0 netmask 255.255.255.0 {
#
        option routers 192.241.4.1;
} ' > /etc/dhcp/dhcpd.conf

service isc-dhcp-server restart
```

### bagian 2.1
Seiring berjalannya waktu kondisi semakin memanas, untuk bersiap perang. Klan Harkonen melakukan deployment sebagai berikut
- Vladimir Harkonen memerintahkan setiap worker(harkonen) PHP, untuk melakukan konfigurasi virtual host untuk website berikut dengan menggunakan php 7.3. (6)
- Aturlah agar Stilgar dari fremen dapat dapat bekerja sama dengan maksimal, lalu lakukan testing dengan 5000 request dan 150 request/second. (7)
- Karena diminta untuk menuliskan peta tercepat menuju spice, buatlah analisis hasil testing dengan 500 request dan 50 request/second masing-masing algoritma Load Balancer dengan ketentuan sebagai berikut:
    - Nama Algoritma Load Balancer 
    - Report hasil testing pada Apache Benchmark 
    - Grafik request per second untuk masing masing algoritma. 
    - Analisis (8)
- Dengan menggunakan algoritma Least-Connection, lakukan testing dengan menggunakan 3 worker, 2 worker, dan 1 worker sebanyak 1000 request dengan 10 request/second, kemudian tambahkan grafiknya pada peta. (9)
- Selanjutnya coba tambahkan keamanan dengan konfigurasi autentikasi di LB dengan dengan kombinasi username: “secmart” dan password: “kcksyyy”, dengan yyy merupakan kode kelompok. Terakhir simpan file “htpasswd” nya di /etc/nginx/supersecret/ (10)
- Lalu buat untuk setiap request yang mengandung /dune akan di proxy passing menuju halaman https://www.dunemovie.com.au/.  `hint: (proxy_pass)` (11)
- Selanjutnya LB ini hanya boleh diakses oleh client dengan IP [Prefix IP].1.37, [Prefix IP].1.67, [Prefix IP].2.203, dan [Prefix IP].2.207. `hint: (fixed in dulu clientnya)` (11)

penyelesaian:

### bagian 2.2
Tidak mau kalah dalam perburuan spice, House atreides juga mengatur para pekerja di `atreides.yyy.com`.
- Semua data yang diperlukan, diatur pada Chani dan harus dapat diakses oleh Leto, Duncan, dan Jessica. (13)
- Leto, Duncan, dan Jessica memiliki `atreides` Channel sesuai dengan quest guide berikut. Jangan lupa melakukan instalasi PHP8.0 dan Composer (14)
- `atreides` Channel memiliki beberapa endpoint yang harus ditesting sebanyak 100 request dengan 10 request/second. Tambahkan response dan hasil testing pada grimoire.
    - POST /auth/register (15)
    - POST /auth/login (16)
    - GET /me (17)
- Untuk memastikan ketiganya bekerja sama secara adil untuk mengatur `atreides` Channel maka implementasikan Proxy Bind pada Eisen untuk mengaitkan IP dari Leto, Duncan, dan Jessica. (18)
- Untuk meningkatkan performa dari Worker, coba implementasikan PHP-FPM pada Leto, Duncan, dan Jessica. Untuk testing kinerja naikkan 
    - pm.max_children 
    - pm.start_servers
    - pm.min_spare_servers
    - pm.max_spare_servers
- sebanyak tiga percobaan dan lakukan testing sebanyak 100 request dengan 10 request/second kemudian berikan hasil analisisnya pada PDF. (19)
- Nampaknya hanya menggunakan PHP-FPM tidak cukup untuk meningkatkan performa dari worker maka implementasikan Least-Conn pada Stilgar. Untuk testing kinerja dari worker tersebut dilakukan sebanyak 100 request dengan 10 request/second. (20)

#### PS:
Peta dikumpulkan dalam bentuk PDF dengan format yyy_Spice.pdf
yyy merupakan kode kelompok

penyelesaian:

## Soal 13
- pada Chani
Jalankan ini pada terminal
```txt
mysql -u root -p

CREATE USER 'kelompokit16'@'%' IDENTIFIED BY 'passwordit16';
CREATE USER 'kelompokit16'@'localhost' IDENTIFIED BY 'passwordit16';
CREATE DATABASE dbkelompokit16;
GRANT ALL PRIVILEGES ON *.* TO 'kelompokit16'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'kelompokit16'@'localhost';
FLUSH PRIVILEGES;
exit
```
```sh
echo '

# Options affecting the MySQL server (mysqld)
[mysqld]
skip-networking=0
skip-bind-address
' >> /etc/mysql/my.cnf

service mysql restart
root@Chani:~# 
root@Chani:~# cat soal13.sh 
echo '

# Options affecting the MySQL server (mysqld)
[mysqld]
skip-networking=0
skip-bind-address
' >> /etc/mysql/my.cnf

service mysql restart
```

## Soal 14
```sh
wget https://getcomposer.org/download/2.0.13/composer.phar
chmod +x composer.phar
mv composer.phar /usr/bin/composer

cd /var/www && git clone https://github.com/martuafernando/laravel-praktikum-jarkom.git
cd /var/www/laravel-praktikum-jarkom && composer update

cd /var/www/laravel-praktikum-jarkom && cp .env.example .env

echo 'APP_NAME=Laravel
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost

LOG_CHANNEL=stack
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=debug

DB_CONNECTION=mysql
DB_HOST=192.241.4.2
DB_PORT=3306
DB_DATABASE=dbkelompokit16
DB_USERNAME=kelompokit16
DB_PASSWORD=passwordit16

BROADCAST_DRIVER=log
CACHE_DRIVER=file
FILESYSTEM_DISK=local
QUEUE_CONNECTION=sync
SESSION_DRIVER=file
SESSION_LIFETIME=120

MEMCACHED_HOST=127.0.0.1

REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_MAILER=smtp
MAIL_HOST=mailpit
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS="hello@example.com"
MAIL_FROM_NAME="${APP_NAME}"

AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=
AWS_USE_PATH_STYLE_ENDPOINT=false

PUSHER_APP_ID=
PUSHER_APP_KEY=
PUSHER_APP_SECRET=
PUSHER_HOST=
PUSHER_PORT=443
PUSHER_SCHEME=https
PUSHER_APP_CLUSTER=mt1

VITE_PUSHER_APP_KEY="${PUSHER_APP_KEY}"
VITE_PUSHER_HOST="${PUSHER_HOST}"
VITE_PUSHER_PORT="${PUSHER_PORT}"
VITE_PUSHER_SCHEME="${PUSHER_SCHEME}"
VITE_PUSHER_APP_CLUSTER="${PUSHER_APP_CLUSTER}"' > /var/www/laravel-praktikum-jarkom/.env

cd /var/www/laravel-praktikum-jarkom && php artisan key:generate
cd /var/www/laravel-praktikum-jarkom && php artisan config:cache
cd /var/www/laravel-praktikum-jarkom && php artisan migrate:fresh
cd /var/www/laravel-praktikum-jarkom && php artisan db:seed --class=AiringsTableSeeder
cd /var/www/laravel-praktikum-jarkom && php artisan storage:link
cd /var/www/laravel-praktikum-jarkom && php artisan jwt:secret
cd /var/www/laravel-praktikum-jarkom && php artisan config:clear

chown -R www-data.www-data /var/www/laravel-praktikum-jarkom/storage
```

```sh
touch /etc/nginx/sites-available/laravel

echo 'server {

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
```
![Screenshot 2024-05-18 091629](https://github.com/Derkora/Jarkom-Modul-3-IT16-2024/assets/110652010/c0ce310c-ade8-43b6-967e-bd4c6e6c5a0e)

## Soal 15
```sh
echo ' {
    "username": "it16",
    "password": "it16password"
}' > register.json

ab -n 100 -c 10 -p register.json -T application/json http://atreides.it16.com:8001/api/auth/register
```
![Screenshot 2024-05-18 100112](https://github.com/Derkora/Jarkom-Modul-3-IT16-2024/assets/110652010/17672711-aa9f-4ed7-8d42-c9ac9a6a4956)
## Soal 16
```sh
echo ' {
        "username": "it16",
        "password": "it16password"
}' > login.json

ab -n 100 -c 10 -p login.json -T application/json http://atreides.it16.com:8001/api/auth/login
```
![Screenshot 2024-05-18 100511](https://github.com/Derkora/Jarkom-Modul-3-IT16-2024/assets/110652010/17abe086-e14b-4fe2-a425-0bbcc9712cf3)
## Soal 17
```sh
# mendapatkan token
curl -X POST -H "Content-Type: application/json" -d '{"username": "it16", "password": "it16password"}' http://atreides.it16.com:8001/api/auth/login | jq -r '.token' > token.txt
# set token
token=$(cat token.txt); curl -H "Authorization: Bearer $token" http://atreides.it16.com:8001/api/me
# jalankan /api/me
ab -n 100 -c 10 -H "Authorization: Bearer $token" http://atreides.it16.com:8001/api/me
```
![Screenshot 2024-05-18 101149](https://github.com/Derkora/Jarkom-Modul-3-IT16-2024/assets/110652010/c527a615-e4be-4c08-8804-27ca2f3bc9b5)
## Soal 18
```sh
echo 'upstream workers {
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
```
## Soal 19
liat pada peta/it16_spice.pdf

## Soal 20
```sh
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
```

