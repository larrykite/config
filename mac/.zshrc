# # set the trace prompt to include seconds, nanoseconds, script name and line number
# zmodload zsh/datetime
# setopt promptsubst
# PS4='+$EPOCHREALTIME %N:%i> '
# # save file stderr to file descriptor 3 and redirect stderr (including trace 
# # output) to a file with the script's PID as an extension
# exec 3>&2 2>/tmp/startlog.$$
# # set options to turn on tracing and expansion of commands contained in the prompt
# setopt xtrace prompt_subst

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
SYSTYPE=$(uname -s)
ZSH_THEME="steeef"
#ZSH_THEME="bullet-train"

export ARCHFLAGS="-arch x86_64"
DEFAULT_USER=uv977zz
# export PROJECT_HOME="${HOME}/pyprojects"

export CASE_SENSITIVE="true"

#export PYTHONPATH="${HOME}/usr/local/bin:/usr/local/lib/python2.7/site-packages:${HOME}/src/XO%20Jet/fos_code:${PYTHONPATH}"

#export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig"
#export DS_NOTEBOOK=default
export VIRTUAL_ENV_DISABLE_PROMPT=1
plugins=(z git copydir copyfile brew osx colorize dirpersist colored-man-pages safe-paste common-aliases)
# plugins=(python brew git osx cp z common-aliases colored-man-pages \
#                 colorize copydir copyfile dirpersist per-directory-history \
#                 zsh-syntax-highlighting history-substring-search)
#alias mysql=/usr/local/mysql/bin/mysql
#alias mysqladmin=/usr/local/mysql/bin/mysqladmin
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/opt/python/libexec/bin/python
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
export PIP_VIRTUALENV_BASE=$WORKON_HOME
#export PIP_RESPECT_VIRTUALENV=true
#export PIP_REQUIRE_VIRTUALENV=true
# CASE_SENSITIVE="true"

HIST_STAMPS="mm/dd/yyyy"
ENABLE_CORRECTION="false"
# To make emacs sub-processes, like tramp, act sanely
if [[ "$TERM" == "dumb" ]]
then
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    unfunction precmd
    unfunction preexec
    PS1='$ '
else
    export TERM=xterm-256color
    source $ZSH/oh-my-zsh.sh
fi


setopt noclobber
setopt histallowclobber
setopt dotglob
setopt extendedglob
setopt CSH_NULL_GLOB

#export LS_COLORS='di=33:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31;7:mi=0;41:ex=93:*.csv=35:*.py=96'
SAVEHIST=200000
HISTSIZE=200000
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help
# autoload -Uz bashcompinit
# bashcompinit

# source /usr/local/share/compleat-1.0/compleat_setup
autoload -Uz zmv
source /usr/local/bin/virtualenvwrapper.sh

source ${HOME}/.iterm2_shell_integration.zsh
eval $(/usr/local/opt/coreutils/libexec/gnubin/dircolors ${HOME}/src/dircolors-solarized/dircolors.ansi-dark)
fpath=(/usr/local/share/zsh-completions $fpath)

[ -f $HOME/zsh_aliases ] && source $HOME/zsh_aliases
[ -f $HOME/zsh_functions ] && source $HOME/zsh_functions

# compdef '_files -g "*.gz *.tgz *.bz2 *.tbz *.zip *.rar *.tar *.lha"' extract_archive

# bindkey "${terminfo[kcud1]}" history-substring-search-down
# bindkey "${terminfo[kcuu1]}" history-substring-search-up
# zstyle ':completion:*' verbose yes
# zstyle ':completion:*:descriptions' format '%B%d%b'
# zstyle ':completion:*:messages' format '%d'
# zstyle ':completion:*:warnings' format 'No matches for: %d'
# zstyle ':completion:*' group-name


# A shortcut function that simplifies usage of xclip.
# - Accepts input from either stdin (pipe), or params.
# ------------------------------------------------
cb() {
  local _scs_col="\e[0;32m"; local _wrn_col='\e[1;31m'; local _trn_col='\e[0;33m'
  # Check that xclip is installed.
  if ! type xclip > /dev/null 2>&1; then
    echo -e "$_wrn_col""You must have the 'xclip' program installed.\e[0m"
  # Check user is not root (root doesn't have access to user xorg server)
  elif [[ "$USER" == "root" ]]; then
    echo -e "$_wrn_col""Must be regular user (not root) to copy a file to the clipboard.\e[0m"
  else
    # If no tty, data should be available on stdin
    if ! [[ "$( tty )" == /dev/* ]]; then
      input="$(< /dev/stdin)"
    # Else, fetch input from params
    else
      input="$*"
    fi
    if [ -z "$input" ]; then  # If no input, print usage message.
      echo "Copies a string to the clipboard."
      echo "Usage: cb <string>"
      echo "       echo <string> | cb"
    else
      # Copy input to clipboard
      echo -n "$input" | xclip -selection c
      # Truncate text for status
      if [ ${#input} -gt 80 ]; then input="$(echo $input | cut -c1-80)$_trn_col...\e[0m"; fi
      # Print status.
      echo -e "$_scs_col""Copied to clipboard:\e[0m $input"
    fi
  fi
}
# Aliases / functions leveraging the cb() function
# ------------------------------------------------
# Copy contents of a file
function cbf() { cat "$1" | cb; }
# Copy SSH public key
alias cbssh="cbf ~/.ssh/id_rsa.pub"
# Copy current working directory
alias cbwd="pwd | cb"
# Copy most recent command in bash history
alias cbhs="fc -l | tail -n 1 | sed -e 's/^[0-9 ]\+//' | cb"

# remove duplicates from PATH

typeset -Ag abbreviations
abbreviations=(
  "Im"    "| most"
  "Ia"    "| awk"
  "Ig"    "| grep"
  "Ieg"   "| egrep"
  "Iag"   "| agrep"
  "Igr"   "| groff -s -p -t -e -Tlatin1 -mandoc"
  "Ip"    "| $PAGER"
  "Ih"    "| head"
  "Ik"    "| keep"
  "It"    "| tail"
  "Is"    "| sort"
  "Iv"    "| ${VISUAL:-${EDITOR}}"
  "Iw"    "| wc"
  "Ix"    "| xargs"
  "Ish"   "| sort -h"
)

magic-abbrev-expand() {
    local MATCH
    LBUFFER=${LBUFFER%%(#m)[_a-zA-Z0-9]#}
    LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
    zle self-insert
}

no-magic-abbrev-expand() {
  LBUFFER+=' '
}

zle -N magic-abbrev-expand
zle -N no-magic-abbrev-expand
bindkey " " magic-abbrev-expand
bindkey "^x " no-magic-abbrev-expand
bindkey -M isearch " " self-insert
#export ALTERNATIVE_EDITOR=""
#export EDITOR=emacsclient

[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export HOMEBREW_GITHUB_API_TOKEN="6c8ff8d11402f240ee50b2347df345973472a0af"
export FORECAST_API_KEY="a9e7b84c026e83a44c2364c058eb1927"
# eval "$(thefuck --alias)"
# if brew command command-not-found-init > /dev/null; then eval "$(brew command-not-found-init)"; fi

source /Users/${DEFAULT_USER}/src/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /Users/${DEFAULT_USER}/src/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# PS1='%{$FG[023]%}$[HISTCMD-1][%?]'

#. /Users/larrykite/torch/install/bin/torch-activate

# to prevent:
#  'ascii' codec can't encode character u'\u2026' in position 463: ordinal not in range(128)
# when python program outputs unicode characters and error occurs when piping to most or less
export PYTHONIOENCODING="utf_8"
#export EDITOR=emacsclient
export JAVA_HOME=$(/usr/libexec/java_home)
typeset -U PATH
# export GEOS_DIR="/usr/local/Cellar/geos/3.6.1/"


# # turn off tracing
# unsetopt xtrace
# #restore stderr to the value saved in FD 3
# exec 2>&3 3>&-
