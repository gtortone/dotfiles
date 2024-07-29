# Neovim
alias vi='/usr/bin/nvim'

# Pine
alias pine='/usr/bin/alpine'

# Telnet
alias telnet='/usr/bin/telnet-ssl'

# SSH agent
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gcr/ssh

# ROOT environment
export ROOTSYS="/opt/root"
export PATH="${PATH}:${ROOTSYS}/bin"

# EPICS environment
#export EPICS_BASE="/opt/epics/base"
#export EPICS_HOST_ARCH=`$EPICS_BASE/startup/EpicsHostArch.pl`
export PATH="${PATH}:/usr/bin/linux-x86_64"
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/lib/linux-x86_64"
## export PYEPICS_LIBCA=$EPICS_BASE/lib/linux-x86_64/libca.so

#source /home/tortone/devel/Fazia/Ganil/v201603-17-jessie/narval.sh
export PATH=$PATH:~/Desktop/3D-printer/software

# Vivado global setting for Xmonad
export _JAVA_AWT_WM_NONREPARENTING=1

#Vivado 2018.3
setup-vivado-2018.3() {
   source /opt/Xilinx/Vivado/2018.3/settings64.sh
   source /opt/Xilinx/SDK/2018.3/settings64.sh
   export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true"
   alias vivado='source /opt/Xilinx/Vivado/2018.3/settings64.sh; export LC_NUMERIC=en_US.UTF-8; vivado -nolog -nojournal'
}

# Vivado 2019.2
setup-vivado-2019.2() {
   source /opt/Xilinx/Vivado/2019.2/settings64.sh
   source /opt/Xilinx/Vitis/2019.2/settings64.sh
   export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true"
   alias vivado='source /opt/Xilinx/Vivado/2019.2/settings64.sh; export LC_NUMERIC=en_US.UTF-8; vivado -nolog -nojournal'
   alias vitis='source /opt/Xilinx/Vitis/2019.2/settings64.sh ; export SWT_GTK3=0 ; export GTK2_RC_FILES=0 ; vitis'
}

# Vivado 2020.2
setup-vivado-2020.2() {
   source /opt/Xilinx/Vivado/2020.2/settings64.sh
   source /opt/Xilinx/Vitis_HLS/2020.2/settings64.sh
   export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true"
   alias vivado='source /opt/Xilinx/Vivado/2020.2/settings64.sh; export LC_NUMERIC=en_US.UTF-8; vivado -nolog -nojournal'
   alias vitis='source /opt/Xilinx/Vitis_HLS/2020.2/settings64.sh ; export SWT_GTK3=0 ; export GTK2_RC_FILES=0 ; vitis'
}

# NGINX
## alias nginx='sudo /opt/nginx/sbin/nginx'

# deck
## alias deck='cd /opt/appimage && ./love-11.3-x86_64.AppImage UPDeck_2-1-19.love'

alias kek-conn='~/devel/Belle2/utils/kek-conn'

# MIDAS 
export MIDASBASE=/opt/midas
export MIDASSYS=$MIDASBASE
export ROOTANASYS=$MIDASBASE
export JSROOTSYS=$MIDASBASE/packages/jsroot
export PATH=$PATH:$MIDASSYS/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/midas/lib
# experiment vars
export MIDAS_EXPTAB=$MIDASBASE/online/exptab
export MIDAS_EXPT_NAME=e777

# XILINX IMPACT
#source /opt/Xilinx/14.7/LabTools/settings64.sh

# JAVA Oracle
export JAVA_HOME="/usr/lib/jvm/jdk-15.0.1"
export PATH="$PATH:${JAVA_HOME}/bin"

# debos
export PATH="$PATH:/opt/go/bin"

# pyenv
#export PYENV_ROOT="$HOME/.pyenv"
#command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"

# set Arc-Dark theme for GTK4 apps
export GTK_THEME=Arc-Dark
