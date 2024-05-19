apt-get update
apt-get install apache2-utils -y
ab -V
ab -n 5000 -c 150 http://harkonen.it16.com/