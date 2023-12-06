## Quick Working Setup
### Install river
```bash
sudo pacman -S river waybar swaylock-effects-git wl-color-picker falkon mako wofi nwg-drawer nwg-launchers
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
### Remove Firefox window Title bar
Right click on toolbar and click on `Customize Toolbar...` and in the bottom left uncheck `Title Bar`.
### Other small adjustments
```bash
sed -i 's/if \[\[ "$XDG_CURRENT_DESKTOP" == "Hyprland" \]\]; then/if \[\[ "$XDG_CURRENT_DESKTOP" == "river" \]\]; then/' ~/.config/rofi/applets/bin/clipboard.sh
sed -i 's/^backgrounds*#1A1B26/#&/' ~/.config/kitty/theme.conf         # set background theme to default (black)
```
### Default MIME types/GTK applications
Every graphical application uses xdg-open. It uses a database to automatically figure out the best program to open the provided path or URL based on MIME type. Sometimes it can breaks and you have to configure it yourself.

Also to set the GTK default applications, for example if you want the "open in terminal" context menu entry in graphical file managers to work. For that you will need to know the name of the .desktop file of your applications: 
```bash
nvim /usr/share/glib-2.0/schemas/org.gnome.desktop.default-applications.gschema.xml
gsettings set org.gnome.desktop.default-applications.terminal exec alacritty.desktop
```
### Automatically load river upon log in
```bash
echo 'if [ "$(tty)" = "/dev/tty1" ]; then
    pgrep river || exec ~/.config/river/scriptsstartr
fi' > "$HOME/.config/zsh/.zprofile"
```
