## Quick Working Setup
### Install river
```bash
sudo pacman -S --needed river waybar falkon mako nwg-drawer wpaperd starship xdg-desktop-portal-wlr
paru -S --needed swaylock-effects-git wl-color-picker 
```

### Option 1: Using install.sh script
```bash
# Clone the repository
cd ~/downloads
git clone --depth 1 https://github.com/Twilight4/dotfiles.git

# Script install-tweaks.sh involves system-wide changes hence must be run as root
su
./dotfiles/.install/install-tweaks.sh
exit

# Install dotfiles
cd dotfiles
./install.sh
```

### Option 2: Minimal Setup
If user just want to have a working setup without additional tweaks:
```bash
# Clone dotfiles
git clone --depth 1 https://github.com/Twilight4/river-settings/
git clone --depth 1 https://github.com/Twilight4/dotfiles/
cp -r river-settings/.config/* ~/.config
cp -r dotfiles/.config/* ~/.config
rm -rf river-settings
rm -rf dotfiles

# Click on the power button on waybar and log out
# Press ctrl+alt+f3 and log in
#./config/river/scripts/startr

# Remove hyprland from garuda installation
#sudo pacman -Rns hyprland-git waybar-hyprland-git
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
```

### Change zsh prompt to starship
```bash
sed -i '/^\[\[ ! -f ~\/.config\/zsh\/.p10k.zsh/d' ~/.config/zsh/.zshrc
sed -i '/^if \[\[ -r "\${XDG_CACHE_HOME:-\$HOME\/.cache}\/p10k-instant-prompt-\${(%):-%n}.zsh" \]\]; then$/,/^  source "\${XDG_CACHE_HOME:-\$HOME\/.cache}\/p10k-instant-prompt-\${(%):-%n}.zsh"$/d;/^fi$/d' ~/.config/zsh/.zshrc
sed -i '/^if \[\[ -r "\${XDG_CACHE_HOME:-\$HOME\/.cache}\/p10k-instant-prompt-\${(%):-%n}.zsh" \]\]; then$/,/^  source "\${XDG_CACHE_HOME:-\$HOME\/.cache}\/p10k-instant-prompt-\${(%):-%n}.zsh"$/d;/^fi$/d;/^source \/usr\/share\/zsh-theme-powerlevel10k\/powerlevel10k.zsh-theme$/d' ~/.config/zsh/.zshrc

cat << "EOF" >> ~/.config/zsh/.zshrc
eval "$(starship init zsh)"
function set_win_title(){
    echo -ne "\033]0; $USER@$HOST:${PWD/$HOME/~} \007"
}
precmd_functions+=(set_win_title)
EOF
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
