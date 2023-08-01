## Quick Bootstrap After CachyOS Install (No Desktop)
### Connect to internet
```bash
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
### Desktop entry
```bash
sudo bash -c 'cat > /usr/share/wayland-sessions/river.desktop' <<-'EOF'
[Desktop Entry]
Name=River
Comment=A dynamic tiling Wayland compositor
Exec="$HOME/.config/river/startr"
Type=Application
EOF
```
### Remove GTK window buttons 
```bash
gsettings set org.gnome.desktop.wm.preferences button-layout ""
```


### Copy dotfiles
```bash
git clone --recurse-submodules "https://github.com/Twilight4/dotfiles-river" ~/dotfiles-river
rsync -av "~/dotfiles-river" ~
rm ~/README.md
```
