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