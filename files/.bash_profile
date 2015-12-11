WHITE="\[\033[1;37m\]"
LIGHT_BLUE="\[\033[1;34m\]"
YELLOW="\[\033[1;33m\]"
RED="\[\033[1;34m\]"
GREEN="\[\033[0;32m\]"
YELLOW="\[\033[0;33m\]"
NO_COLOUR="\[\033[0m\]"
MY_IP=$(ipconfig getifaddr en0)

# Function to display my ip
function get_ip () {
  if [ $? != 0 ]; then
     echo "command failed"
  elif [[ $MY_IP == 0 ]]; then
    echo "No ip or wrong adapter"
  fi
}

(get_ip)

# Titelbar
case $TERM in
    xterm*|rxvt*)
        TITLEBAR='\[\033]0;\u@\h:\w\007\]'
        ;;
    *)
        TITLEBAR=""
        ;;
esac


PS1="$TITLEBAR\
$RED[\
$WHITE\u$RED@$WHITE\h\
$RED]-[\
$WHITE\$MY_IP\
$RED]-[\
$WHITE\$PWD\
$RED]\
\n\
$RED[\
$WHITE\D{%H:%M}$RED]$NO_COLOR$YELLOW\$(parse_git_branch)$ $NO_COLOUR"

PS2="$RED-$WHITE-$WHITE-$NO_COLOUR "

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/DrPity/Development/android-sdk/platform-tools:/Development/android-sdk/tools:$PATH
export CLICOLOR=1
export ANDROID_HOME="/Development/android-sdk"
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;33'


# Show current git branch
function parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}


extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }



# Some aliases
alias ll='ls -la'
alias filetree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'"
alias bashreload=". ~/.bash_profile"
alias server="python -m SimpleHTTPServer"