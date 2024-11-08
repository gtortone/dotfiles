# dotfiles

![Neofetch](neofetch.png)

### Linux distribution

Arch Linux (April 2023)

### Window manager components

- window manager: **i3**
- status bar: **polybar**
- notification daemon: **dunst**		
- wallpaper manager: **feh**
- screensaver: **slock** / **xautolock**
- display manager: **autorandr**
- multimedia framework: **pipewire** / **wireplumber**
- network: **nm-applet**
- bluetooth: **blueman-applet**
- keyring daemon: **gnome-keyring-daemon**
- keybind utility: **xbindkeys**
- clipboard manager: **greenclip** / **autocutsel**

### Applications

- Shell: **zsh**
   - plugin manager: zinit
   - plugins: powerlevel10k, syntax-highlighting, completions, autosuggestions
- Editor: **neovim**
- Terminal: **alacritty**
- MIME manager: **mimeo**
- Calculator: **mate-calculator**
- Web browser: **qutebrowser**
- Address book: **abook** 
- Mail reader: **neomutt** / **isync** / **notmuch**
- File browsing: **vifm** / **pcmanfm**
- Image viewer: **sxiv** / **viewnior**
- Video player: **vlc** / **mpv**
- Screencast: **ffmpeg** / **slop** / **screenkey**
- Audio mixer: **pwvucontrol**
- Launcher: **dmenu** / **rofi**
- Screenshot: **maim**
- Calendar: **gcal**
- CPU frequency manager: **cpupower**
- Keyboard layout: **setxkbmap**
- Audio CLI: **ponymix**
- Touchpad config: **xinput**
- Display manager: **xrandr** / **autorandr** / **arandr** / **mons**
- Brightness control: **brightnessctl**
- Dotfiles manager: **stow**

### LXDM login manager

- config file: ```/etc/lxdm/lxdm.conf```
- config utility: ```lxdm-config```
	
### GTK configuration

- config utility: ```lxappearence```
- theme: ```Arc-Dark``` 
- icon theme: ```Obsidian```

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
- list desktop files associated with the given MIME-types: ```mimeo --mime2desk application/pdf```

### Fonts configuration

- terminal font:
    - ```JetBrains Mono NL Regular Nerd Font Complete.ttf```
- refresh fonts cache: ```fc-cache -fv```
- list fonts: ```fc-list```
- fonts GUI: ```gucharmap```
- fonts fix: ```nerdfix```
	
### Keys binding configuration
	
- capture keys: ```xbindkeys -km```
	
### Keys combo

- set mobile mode (LCD display): ```CTRL+ALT+1```
- set docked mode (HDMI display): ```CTRL+ALT+2```
- display dmenu: ```ALT+P```
- display rofi custom menu: ```ALT+SHIFT+P```

