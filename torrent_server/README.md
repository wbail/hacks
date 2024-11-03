# torrent image downloader

using a raspberry pi with qbittorrent (docker)

### installation

- download raspberry pi image (minimal, no desktop)

### static ip

- setup static ip
- create the file ```/etc/wpa_supplicant/wpa_supplicant.conf```
```
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=COUNTRY CODE

network={
     ssid="SSID"
     psk="PASSWORD"
     scan_ssid=1
     key_mgmt=WPA-PSK
}
```

- edit the ```/etc/network/interfaces```
```
auto wlan0
#allow-hotplug wlan0
iface wlan0 inet static
        address 192.168.1.X
        netmask 255.255.255.0
        gateway 192.168.X.X
        dns-nameservers 1.1.1.1 8.8.8.8
        wpa-ssid SSID
        wpa_psk PASSWORD
```

### update and upgrade

- run the commands to update and upgrade: ```sudo apt-get update && sudo apt-get upgrade```

### vpn

installation
- curl: ```sudo apt-get install curl```
- wireguard: ```sudo apt-get install openresolv wireguard```

- generate a configuration file
- ```sudo mv se-mma-wg-001.conf /etc/wireguard```
- ```sudo chown root:root -R /etc/wireguard && sudo chmod 600 -R /etc/wireguard```

connect with wireguard
- ```wg-quick up se-mma-wg-001```

verify connection
```curl https://am.i.mullvad.net/connected```

- if it doesn't work, make sure that you still have time on your Mullvad account.
- you can also check that you get a handshake using the wg command.

disconnect
```wg-quick down se-mma-wg-001```

local network:
- if you enabled the kill switch in the WireGuard configuration file generator then you may get a problem to connect to your local network. You can modify the kill switch in your WireGuard configuration files so it includes an exception for your local network, for example ```"! -d 192.168.1.0/24"```. Here is a full example:
```
PostUp = iptables -I OUTPUT ! -o %i -m mark ! --mark $(wg show %i fwmark) -m addrtype ! --dst-type LOCAL ! -d 192.168.1.0/24 -j REJECT && ip6tables -I OUTPUT ! -o %i -m mark ! --mark $(wg show %i fwmark) -m addrtype ! --dst-type LOCAL -j REJECT

PreDown = iptables -D OUTPUT ! -o %i -m mark ! --mark $(wg show %i fwmark) -m addrtype ! --dst-type LOCAL ! -d 192.168.1.0/24 -j REJECT && ip6tables -D OUTPUT ! -o %i -m mark ! --mark $(wg show %i fwmark) -m addrtype ! --dst-type LOCAL -j REJECT
```

run on boot
- ```sudo systemctl enable wg-quick@se-mma-wg-001```


### softwares

- docker: 
```
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/raspbian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/raspbian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

docker --version
```

- qbittorrent (arm docker container): ```git clone https://github.com/qbittorrent/docker-qbittorrent-nox```
