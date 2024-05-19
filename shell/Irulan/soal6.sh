echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     harkonen.it16.com.  root.harkonen.it16.com.  (
                                 2      ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
@               IN      NS      harkonen.it16.com.
@               IN      A       192.241.4.3 ; IP Stilgar Balancer' > /etc/bind/harkonen/harkonen.it16.com

service bind9 restart