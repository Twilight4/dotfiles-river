## Quick Bootstrap After CachyOS Install (No Desktop)
### Connect to internet
```
nmcli dev wifi
nmcli dev wifi connect "wifi_ssid" password "wifi_password"
nmcli dev status
```
### Run install-tweaks script
```bash
su -
bash <(curl -s https://raw.githubusercontent.com/Twilight4/alis-iso/main/install-tweaks.sh)
exit
```
### Copy dotfiles
