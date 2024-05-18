echo 'SERVERS="192.241.3.2"
INTERFACES="eth1 eth2 eth3 eth4"' > /etc/default/isc-dhcp-relay

echo 'net.ipv4.ip_forward=1' > /etc/sysctl.conf

service isc-dhcp-relay restart