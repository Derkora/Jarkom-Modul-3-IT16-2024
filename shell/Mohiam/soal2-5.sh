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