## Quick Working Setup
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
### Remove Firefox window Title bar
Right click on toolbar and click on "Customize Toolbar...". In the bottom left, uncheck "Title Bar"
### Install [kile](https://gitlab.com/snakedye/kile), better layout generator for river
```bash
cargo install --git https://gitlab.com/snakedye/kile
```
### Other tiny adjustments
```bash
sed -i 's/background_opacity 0\.80/background_opacity 1/' ~/.config/kitty/kitty.conf
```
