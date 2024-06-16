## Quick Working Setup
### Install [river](https://github.com/riverwm/river) and dependencies
```bash
sudo pacman -S --needed river waybar lswt falkon mako nwg-drawer wpaperd starship xdg-desktop-portal-wlr
paru -S --needed swaylock-effects-git wl-color-picker
```

### Minimal Setup
```bash
# Clone the repositories
git clone --depth 1 https://github.com/Twilight4/river-settings
cp -r river-settings/.config/* ~/.config

# Press ctrl+alt+f2 and log in
~/.config/river/scripts/startr
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

### Change zsh prompt to starship
```bash
sed -i.bak '/if \[\[ -r "${XDG_CACHE_HOME:-$HOME\/.cache}\/p10k-instant-prompt-${(%):-%n}.zsh" \]\]; then/,/fi/ s/^/# /' ~/.config/zsh/.zshrc
sed -i.bak 's|^source /usr/share/zsh-theme-powerlevel10k/powerlevel10k\.zsh-theme|# &|' ~/.config/zsh/.zshrc
sed -i.bak '/^\[\[ ! -f ~\/\.config\/zsh\/\.p10k\.zsh \]\]/ s|^|# |' ~/.config/zsh/.zshrc

cat << "EOF" >> ~/.config/zsh/.zshrc
eval "$(starship init zsh)"
function set_win_title(){
    echo -ne "\033]0; $USER@$HOST:${PWD/$HOME/~} \007"
}
precmd_functions+=(set_win_title)
EOF
```

### Automatically load river upon log in
```bash
echo 'if [ "$(tty)" = "/dev/tty1" ]; then
    pgrep river || exec ~/.config/river/scripts/startr
fi' > "$HOME/.config/zsh/.zprofile"
```

### Default MIME types/GTK applications
Every graphical application uses xdg-open. It uses a database to automatically figure out the best program to open the provided path or URL based on MIME type. Sometimes it can breaks and you have to configure it yourself.

Also to set the GTK default applications, for example if you want the "open in terminal" context menu entry in graphical file managers to work. For that you will need to know the name of the .desktop file of your applications: 
```bash
nvim /usr/share/glib-2.0/schemas/org.gnome.desktop.default-applications.gschema.xml
gsettings set org.gnome.desktop.default-applications.terminal exec alacritty.desktop
```
