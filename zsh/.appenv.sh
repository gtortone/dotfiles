# Neovim
alias vi='/usr/bin/nvim'

# Pine
alias pine='/usr/bin/alpine'

# SSH agent
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gcr/ssh

# ROOT environment
export ROOTSYS="/opt/root"
export PATH="${PATH}:${ROOTSYS}/bin"

# EPICS environment
#export EPICS_BASE="/opt/epics/base"
#export EPICS_HOST_ARCH=`$EPICS_BASE/startup/EpicsHostArch.pl`
export PATH="${PATH}:/usr/bin/linux-x86_64"
#export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/lib/linux-x86_64"
## export PYEPICS_LIBCA=$EPICS_BASE/lib/linux-x86_64/libca.so

# sudo macro
sudo() {
   if [[ "$@" == "-s" ]]; then
      /usr/bin/sudo -s /bin/bash
   else
      /usr/bin/sudo $@
   fi
}

# Vivado global setting for Xmonad/i3
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

alias kek-conn='~/devel/Belle2/utils/kek-conn'

# debos
export PATH="$PATH:/opt/go/bin"
