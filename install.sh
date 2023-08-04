#!/bin/bash

installApps()
{
    clear
    OS="$REPLY" ## <-- This $REPLY is about OS Selection
    echo "You can Install NGinX Proxy Manager with this script!"
    echo "Please select 'y' for each item you would like to install."
    echo "NOTE: Without Docker and Docker-Compose, you cannot install this container."
    echo ""
    echo "To install Docker and Docker-Compose, use the link below:"
    echo "https://github.com/shawshanck/Docker-and-Docker-Compose"
    echo ""
    echo "Provided to you by Mohammad Mohammadpour"
    echo "https://github.com/shawshanck"
    echo ""
    
    ISACT=$( (sudo systemctl is-active docker ) 2>&1 )
    ISCOMP=$( (docker-compose -v ) 2>&1 )

    #### Try to check whether docker is installed and running - don't prompt if it is
    
    read -rp "NGinX Proxy Manager (y/n): " NPM

    startInstall
}

startInstall() 
{
    clear
    echo "#######################################################"
    echo "###         Preparing for Installation              ###"
    echo "#######################################################"
    echo ""
    sleep 3s

#######################################################
###           Install for Debian / Ubuntu           ###
#######################################################

    if [[ "$NPM" == [yY] ]]; then
        echo "##########################################"
        echo "###     Install NGinX Proxy Manager    ###"
        echo "##########################################"
    
        # pull an nginx proxy manager docker-compose file from github
        echo "    1. Pulling a default NGinX Proxy Manager docker-compose.yml file."

        mkdir -p docker/nginx-proxy-manager
        cd docker/nginx-proxy-manager

        curl https://raw.githubusercontent.com/shawshanck/NGinX-Proxy-Manager/main/nginx_proxy_manager.yml -o docker-compose.yml >> ~/docker-script-install.log 2>&1

        echo "    2. Running the docker-compose.yml to install and start NGinX Proxy Manager"
        echo ""
        echo ""

        if [[ "$OS" == "1" ]]; then
          docker-compose up -d
        else
          sudo docker-compose up -d
        fi

        echo "    3. You can find NGinX Proxy Manager files at ./docker/nginx-proxy-manager"
        echo ""
        echo "    Navigate to your server hostname / IP address on port 81 to setup"
        echo "    NGinX Proxy Manager admin account."
        echo ""
        echo "    The default login credentials for NGinX Proxy Manager are:"
        echo "        username: admin@example.com"
        echo "        password: changeme"

        echo ""
        echo ""
        echo "Provided to you by Mohammad Mohammadpour"
        echo "https://github.com/shawshanck"       
        sleep 3s
        cd
    fi
    
    exit 1
}

echo ""
echo ""

clear

echo "Let's figure out which OS / Distro you are running."
echo ""
echo ""
echo "    From some basic information on your system, you appear to be running: "
echo "        --  OS Name            " $(lsb_release -i)
echo "        --  Description        " $(lsb_release -d)
echo "        --  OS Version         " $(lsb_release -r)
echo "        --  Code Name          " $(lsb_release -c)
echo ""
echo "------------------------------------------------"
echo ""

PS3="Please select the number for your OS / distro: "
select _ in \
    "CentOS 7 / 8 / Fedora" \
    "Debian 10 / 11" \
    "Ubuntu 18.04" \
    "Ubuntu 20.04 / 21.04 / 22.04" \
    "Arch Linux" \
    "Open Suse"\
    "End this Installer"
do
  case $REPLY in
    1) installApps ;;
    2) installApps ;;
    3) installApps ;;
    4) installApps ;;
    5) installApps ;;
    6) installApps ;;
    7) exit ;;
    *) echo "Invalid selection, please try again..." ;;
  esac
done
