# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="spaceship"
CASE_SENSITIVE="true"
zstyle ':omz:update' mode disabled  # disable automatic updates

# automatically rehash
zstyle ':completion:*' rehash true

plugins=(sudo fzf)

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

# User configuration

SPACESHIP_USER_SHOW=always
SPACESHIP_HOST_SHOW=never
SPACESHIP_DIR_TRUN=0
SPACESHIP_EXIT_CODE_SHOW=true

SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  line_sep      # Line break
  battery       # Battery level and status
  jobs          # Background jobs indicator
  char          # Prompt character
)

SPACESHIP_RPROMPT_ORDER=(
  exec_time     # Execution time
  exit_code     # Exit code section
  git           # Git section (git_branch + git_status)
  venv          # virtualenv section
  package       # Package version
  node          # Node.js section
  docker        # Docker section
  conda         # conda virtualenv section
  python        # Python section
)

# prompt init
autoload -U promptinit; promptinit
prompt spaceship

export EDITOR=vim

# zsh suggestions
if [ $DISPLAY ]; then
   source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
   bindkey '^[s' autosuggest-accept
fi

# bat
alias cat='bat -Pp --theme=ansi --color=always'
export LESS='-RX'
export MANPAGER=manpager

if [ $DISPLAY ]; then
   # increase keyboard repeat rate
   /usr/bin/xset r rate 250 25
else
   # set it keyboard layout if lid is open and user is on text console
   lid=$(cat /proc/acpi/button/lid/LID/state  | sed -e 's/.*:\s*//g')
   if [ $lid = "open" ]; then
      loadkeys it
   else
      loadkeys us
   fi
fi

alias ls='ls -N --color=auto'

. ~/.appenv.sh
