# dotfiles

![Neofetch](neofetch/distro.png)

### Linux distribution

Arch Linux (April 2022)

### Window manager components

- status bar: **xmobar**
- notification daemon: **dunst**		
- systray application: **trayer**
- wallpaper manager: **feh**
- screensaver: **slock**
- display manager: **autorandr**
- network: **nm-applet**
- bluetooth: **blueman-applet**
- keyring daemon: **gnome-keyring-daemon**
- keybind utility: **xbindkeys**
- clipboard manager: **greenclip**

### Applications

- Shell: **zsh**
   - plugins: oh-my-zsh, fzf, powerlevel10k
- Editor: **vim**
   - plugins: vim-plug, vim-airline, vim-airline-themes, vim-fugitive, nerdtree
   - theme: ayu-vim (patched)
- Terminal: **alacritty**
- MIME manager: **mimeo**
- Calculator: **mate-calculator**
- Web browser: **cutebrowser** 
- Mail reader: **pine**
- File browsing: **vifm** / **pcmanfm**
- Image viewer: **sxiv** / **viewnior**
- Clipboard: **xclip**
- Audio mixer: **pavucontrol**
- Launcher: **dmenu** / **rofi**
- Screenshot: **maim**
- Calendar: **gsimplecal**
- CPU frequency manager:	**cpupower-gui**
- Keyboard layout: **setxkbmap**
- Audio CLI: **ponymix**
- Touchpad config: **xinput**
- Display manager: **xrandr** / **autorandr** 	
- Brightness control: **brightnessctl**

### LightDM login manager

- config file: ```/etc/lightdm/lightdm-gtk-greeter.conf```	
- config utility: ```lightdm-gtk-greeter-settings```
	
### GTK configuration

- config files: ```~/.gtkrc-2.0```, ```~/.config/gtk-3.0/settings.ini```
- config utility: ```lxappearence```
- theme: ```Arc-Dark``` 
- icon theme: ```Obsidian```

### Xmonad configuration

- config directory: ```~/.xmonad```
- startup script: ```~/.xmonad/startup.sh```

### Gnome keyring daemon

- to disable system autostart from ```/etc/xdg/autostart``` create gnome-keyring desktop files in ```~/.config/autostart``` and paste this content:
```
[Desktop Entry]
Hidden=true
```

### MIME configuration

- system wide desktop files: ```/usr/share/applications```
- user desktop files: ```.local/share/applications```
- override system default application: ```~/.config/mimeapps.list```
- open file with current default application: ```mimeo test.mp3```
- update desktop database: ```sudo update-desktop-database``` (produce mimeinfo.cache)
- list desktop files: ```mimeo --app2desk``` 
- list application / MIME-type association: ```mimeo --app2mime```
- get MIME-type from file: ```mimeo -m file.pdf``` 
- set preferred application from desktop file MIME-types: ```mimeo --prefer vlc.desktop```


### Fonts configuration

- fonts directory: ```~/.fonts```
- terminal font:
    - ```JetBrains Mono NL Regular Nerd Font Complete.ttf```
- window manager font:
   - ```LiberationSans-Regular.ttf```
   - ```NotoSansMono-Regular.ttf```
- refresh fonts cache: ```fc-cache -fv```
- list fonts: ```fc-list```
	
### Keys binding configuration
	
- config file: ```~/.xbindkeysrc```
- capture keys: ```xbindkeys -k```
	
### Keys combo

- set mobile mode (LCD display): ```CTRL+ALT+1```
- set docked mode (HDMI display): ```CTRL+ALT+2```
- display dmenu: ```ALT+P```
- display dmenu hub: ```ALT+O```
- display rofi custom menu: ```ALT+SHIFT+P```
- display rofi drun: ```ALT+SHIFT+R```

### Deployment

| repository file | local directory |
|-|-|
|```bin/*```|```~/.local/bin```|
|```autorandr/*```|```~/.config/autorandr```|
|```alacritty/.alacritty.yml```|```~```|
|```dunst/dunstrc```|```~/.config/dunst/dunstrc```|
|```mime/mimeapps.list```|```~/.config```|
|```fonts/*```|```~/.fonts```|
|```gtk/.gtkrc-2.0```|```~```|
|```gtk/settings.ini```|```~/.config/gtk-3.0/settings.ini```|
|```rofi/*```|```~/.config/rofi```|
|```xbindkeys/.xbindkeysrc```|```~```|
|```xmobar/xmobar.hs```|```~/.xmonad```|
|```xmonad/*```|```~/.xmonad```|
|```vim/.vimrc```|```~```|
|```vim/plugins.vim```|```.vim/```|
|```zsh/.zshrc```|```~```|

### Useful commands

- paste PNG image from clipboard to file: ```xclip -se c -o > image.png```
