# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="blinks"
#ZSH_THEME="jonathan"
ZSH_THEME="steeef"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
#DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git github python svn debian task-warrior zsh-syntax-highlighting command-not-found history-substring-search)

source $ZSH/oh-my-zsh.sh
# Customize to your needs...
export PATH="/usr/local/MATLAB/R2011a/bin":$PATH
export PATH=/home/larrykite/bin:/home/larrykite/Applications/firefox:$PATH
export PATH=/home/larrykite/projects/flex-sdk/bin:/home/larrykite/projects/apache-ant-1.7.0/bin:/home/larrykite/projects/jdk1.5.0_13/bin:$PATH
export EDITOR="ecn"
export VISUAL="ecn"
export CCL_DEFAULT_DIRECTORY=/home/larrykite/projects/ccl
export SKYTREE_LICENSE_PATH=/home/larrykite/bin
export CLASSPATH=/home/larrykite/bin/skytree.jar
source $HOME/zsh_aliases

[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm


function setenv () {
  export $1="$2"
}
function lf
{
    ls --color=tty --classify $*
    echo "$(ls -l $* | wc -l) files"
}

function etf()
{
    echo "$1" >> $2

}
function cdf() { cd *$1*/ }

# Function which adds an alias to the current shell and to
# the ~/zsh_aliases file.
add-alias ()
{
   local name=$1 value="$2"
   echo alias $name=\'$value\' >>~/zsh_aliases
   eval alias $name=\'$value\'
   alias $name
}

# if [ -f ~/.bash_aliases ]; then
#     . ~/.bash_aliases
# fi

extract_archive () {
    local old_dirs current_dirs lower
    lower=${(L)1}
    old_dirs=( *(N/) )
    if [[ $lower == *.tar.gz || $lower == *.tgz ]]; then
        tar zxfv $1
    elif [[ $lower == *.gz ]]; then
        gunzip $1
    elif [[ $lower == *.tar.bz2 || $lower == *.tbz ]]; then
        bunzip2 -c $1 | tar xfv -
    elif [[ $lower == *.bz2 ]]; then
        bunzip2 $1
    elif [[ $lower == *.zip ]]; then
        unzip $1
    elif [[ $lower == *.rar ]]; then
        unrar e $1
    elif [[ $lower == *.tar ]]; then
        tar xfv $1
    elif [[ $lower == *.lha ]]; then
        lha e $1
    else
        print "Unknown archive type: $1"
        return 1
    fi
    # Change in to the newly created directory, and
    # list the directory contents, if there is one.
    current_dirs=( *(N/) )
    for i in {1..${#current_dirs}}; do
        if [[ $current_dirs[$i] != $old_dirs[$i] ]]; then
            cd $current_dirs[$i]
            ls
            break
        fi
    done
}

alias ex=extract_archive
compdef '_files -g "*.gz *.tgz *.bz2 *.tbz *.zip *.rar *.tar *.lha"' extract_archive
function git(){hub "$@"}
unalias ar
export WORKON_HOME="$HOME/envs"
export PROJECT_HOME="$HOME/projects"
source /usr/local/bin/virtualenvwrapper.sh
