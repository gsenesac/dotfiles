#!/bin/bash
#Load dotfiles
for file in ~/.{bash_prompt,aliases,exports}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

shopt -s nocaseglob

PROMPT_DIRTRIM=2
PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/go/bin
PATH=$PATH:/usr/local/go/bin
PROXYFILE=$HOME/.bash/proxy
APTGET_CONF=/etc/apt/apt.conf

#TODO: Would be cool to save off previous proxy settings
function isproxyset()
{
    if [ -e $PROXYFILE ]; then
        . $PROXYFILE

        if [ -n "$proxy" ]; then
            echo 1
        else
            echo 0
        fi
    else
        echo 0
    fi
}

function set_bash_proxy()
{
    . $PROXYFILE
    export http_proxy=$proxy
    export https_proxy=$proxy
}

function replace_or_append()
{
    #$1 - string to replace
    #$2 - replacement line
    #$3 - filename

    if grep -q $1 $3; then
        sudo sed -i "/$1/c\\$2" $3
    else
        sudo echo "$2" >> $3
    fi
}

function set_apt_proxy()
{
    . $PROXYFILE

    APT_HTTP_SET="Acquire::http::Proxy \"$proxy\";"
    APT_HTTPS_SET="Acquire::https::Proxy \"$proxy\";"

    if [ -e $APTGET_CONF ]; then
        replace_or_append "Acquire::http::Proxy" "${APT_HTTP_SET}" $APTGET_CONF
        replace_or_append "Acquire::https::Proxy" "${APT_HTTPS_SET}" $APTGET_CONF
    else
        sudo echo $APT_HTTP_SET | sudo dd of=$APTGET_CONF
        sudo echo $APT_HTTPS_SET | sudo dd of=$APTGET_CONF oflag=append conv=notrunc
    fi 

}

function unset_bash_proxy()
{
    export http_proxy=
    export https_proxy=
}

function unset_apt_proxy()
{
    . $PROXYFILE

    if [ -e $APTGET_CONF ]; then
        sudo sed "/Acquire::http::Proxy/d" $APTGET_CONF > .tmp
        sudo sed -i "/Acquire::https::Proxy/d" .tmp
        sudo mv .tmp $APTGET_CONF
    else
        echo "No apt.conf file present at /etc/apt"
    fi 

}

#TODO: Make this take an argument to only set proxy on individual
#      apps, i.e. only set bash or only set apt-get
function upproxy()
{
    proxy_set=$(isproxyset)
    if [ $proxy_set = 1 ]; then
        set_bash_proxy
        set_apt_proxy
    else
        echo "Proxy not set"
        echo "Enter the desired proxy, or Ctrl-C to cancel:"
        read newproxy
        echo "Setting proxy to: $newproxy"
        echo "proxy=$newproxy" > $PROXYFILE
        set_bash_proxy
        set_apt_proxy
    fi      
}

#TODO: Make this take an argument to only set proxy on individual
#      apps, i.e. only set bash or only set apt-get
function downproxy()
{
    unset_bash_proxy
    unset_apt_proxy
}

function statproxy()
{
    echo "Bash HTTP Proxy Settings:"
    echo "http_proxy = $http_proxy"
    echo "https_proxy = $https_proxy"
}
