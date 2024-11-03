# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d $ZINIT_HOME ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# zsh plugins
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# zsh snippets
zinit snippet OMZP::sudo

# load completions
autoload -U compinit && compinit
zinit cdreplay -q

# keybindings
bindkey '^[s' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
eval "$(dircolors)"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# history
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# fzf
eval "$(fzf --zsh)"

# zoxide
eval "$(zoxide init --cmd cd zsh)"

# redefine ESC-<up>, ESC-<down>, ESC-<left>, ESC-<right> to avoid
# collisions with sudo plugin
bindkey -M emacs '\e\eOA' redisplay
bindkey -M vicmd '\e\eOA' redisplay
bindkey -M viins '\e\eOA' redisplay
bindkey -M emacs '\e\eOB' redisplay
bindkey -M vicmd '\e\eOB' redisplay
bindkey -M viins '\e\eOB' redisplay
bindkey -M emacs '\e\eOC' redisplay
bindkey -M vicmd '\e\eOC' redisplay
bindkey -M viins '\e\eOC' redisplay
bindkey -M emacs '\e\eOD' redisplay
bindkey -M vicmd '\e\eOD' redisplay
bindkey -M viins '\e\eOD' redisplay

# switch keyboard layout when lid is open
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

# bat
alias cat='bat -Pp --theme=ansi --color=always'

# man pages with colors
export LESS='-RX'
export MANPAGER=manpager

# ls
alias ls='ls -N --color=auto'
alias ll='ls -lN --color=auto'

# neovim
export EDITOR=nvim

# PATH
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

. ~/.appenv.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
