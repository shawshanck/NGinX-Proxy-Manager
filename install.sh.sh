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

    if [[ "$OS" == [234] ]]; then
        echo "    1. Installing System Updates... this may take a while...be patient. If it is being done on a Digial Ocean VPS, you should run updates before running this script."
        (sudo apt update && sudo apt upgrade -y) > ~/docker-script-install.log 2>&1 &
        ## Show a spinner for activity progress
        pid=$! # Process Id of the previous running command
        spin='-\|/'
        i=0
        while kill -0 $pid 2>/dev/null
        do
            i=$(( (i+1) %4 ))
            printf "\r${spin:$i:1}"
            sleep .1
        done
        printf "\r"

        echo "    2. Install Prerequisite Packages..."
        sleep 2s

        sudo apt install curl wget git -y >> ~/docker-script-install.log 2>&1
        
        if [[ "$ISACT" != "active" ]]; then
            echo "    3. Installing Docker-CE (Community Edition)..."
            sleep 2s

        
            curl -fsSL https://get.docker.com | sh >> ~/docker-script-install.log 2>&1
            echo "      - docker-ce version is now:"
            DOCKERV=$(docker -v)
            echo "          "${DOCKERV}
            sleep 3s

            if [[ "$OS" == 2 ]]; then
                echo "    5. Starting Docker Service"
                sudo systemctl docker start >> ~/docker-script-install.log 2>&1
            fi
        fi

    fi
        
    
#######################################################
###              Install for CentOS 7 or 8          ###
#######################################################
    if [[ "$OS" == "1" ]]; then
        if [[ "$DOCK" == [yY] ]]; then
            echo "    1. Updating System Packages..."
            sudo yum check-update > ~/docker-script-install.log 2>&1

            echo "    2. Installing Prerequisite Packages..."
            sudo dnf install git curl wget -y >> ~/docker-script-install.log 2>&1

            if [[ "$ISACT" != "active" ]]; then
                echo "    3. Installing Docker-CE (Community Edition)..."

                sleep 2s
                (curl -fsSL https://get.docker.com/ | sh) >> ~/docker-script-install.log 2>&1

                echo "    4. Starting the Docker Service..."

                sleep 2s


                sudo systemctl start docker >> ~/docker-script-install.log 2>&1

                echo "    5. Enabling the Docker Service..."
                sleep 2s

                sudo systemctl enable docker >> ~/docker-script-install.log 2>&1

                echo "      - docker version is now:"
                DOCKERV=$(docker -v)
                echo "        "${DOCKERV}
                sleep 3s
            fi
        fi
    fi

#######################################################
###               Install for Arch Linux            ###
#######################################################

    if [[ "$OS" == "5" ]]; then
        read -rp "Do you want to install system updates prior to installing Docker-CE? (y/n): " UPDARCH
        if [[ "$UPDARCH" == [yY] ]]; then
            echo "    1. Installing System Updates... this may take a while...be patient."
            (sudo pacman -Syu --noconfirm) > ~/docker-script-install.log 2>&1 &
            ## Show a spinner for activity progress
            pid=$! # Process Id of the previous running command
            spin='-\|/'
            i=0
            while kill -0 $pid 2>/dev/null
            do
                i=$(( (i+1) %4 ))
                printf "\r${spin:$i:1}"
                sleep .1
            done
            printf "\r"
        else
            echo "    1. Skipping system update..."
            sleep 2s
        fi

        echo "    2. Installing Prerequisite Packages..."
        sudo pacman -Sy git curl wget --noconfirm >> ~/docker-script-install.log 2>&1

        if [[ "$ISACT" != "active" ]]; then
            echo "    3. Installing Docker-CE (Community Edition)..."
            sleep 2s

            sudo pacman -Sy docker --noconfirm >> ~/docker-script-install.log 2>&1

            echo "    - docker-ce version is now:"
            DOCKERV=$(docker -v)
            echo "        "${DOCKERV}
            sleep 3s
        fi
    fi

#######################################################
###               Install for Open Suse             ###
#######################################################

    if [[ "$OS" == "6" ]]; then
        # install system updates first
        read -rp "Do you want to install system updates prior to installing Docker-CE? (y/n): " UPDSUSE
        if [[ "$UPDSUSE" == [yY] ]]; then
            echo "    1. Installing System Updates... this may take a while...be patient."

            (sudo zypper -n update) > docker-script-install.log 2>&1 &
            ## Show a spinner for activity progress
            pid=$! # Process Id of the previous running command
            spin='-\|/'
            i=0
            while kill -0 $pid 2>/dev/null
            do
                i=$(( (i+1) %4 ))
                printf "\r${spin:$i:1}"
                sleep .1
            done
            printf "\r"
        else
            echo "    1. Skipping system update..."
            sleep 2s
        fi

        echo "    2. Installing Prerequisite Packages..."
        sudo zypper -n install git curl wget >> ~/docker-script-install.log 2>&1

        if [[ "$ISACT" != "active" ]]; then
            echo "    3. Installing Docker-CE (Community Edition)..."
            sleep 2s

            sudo zypper -n install docker-compose >> ~/docker-script-install.log 2>&1
            sudo zypper -n remove docker-compose
            echo "Giving the Docker service time to start..."
        
            sudo systemctl start docker >> ~/docker-script-install.log 2>&1
            sleep 5s &
            pid=$! # Process Id of the previous running command
            spin='-\|/'
            i=0
            while kill -0 $pid 2>/dev/null
            do
                i=$(( (i+1) %4 ))
                printf "\r${spin:$i:1}"
                sleep .1
            done
            printf "\r"
            sudo systemctl enable docker >> ~/docker-script-install.log 2>&1

            echo "    - docker-ce version is now:"
            DOCKERV=$(docker -v)
            echo "        "${DOCKERV}
            sleep 3s
        fi
    fi

    if [[ "$ISACT" != "active" ]]; then
        if [[ "$DOCK" == [yY] ]]; then
            # add current user to docker group so sudo isn't needed
            echo ""
            echo "  - Attempting to add the currently logged in user to the docker group..."

            sleep 2s
            sudo usermod -aG docker "${USER}" >> ~/docker-script-install.log 2>&1
            echo "  - You'll need to log out and back in to finalize the addition of your user to the docker group."
            echo ""
            echo ""
            sleep 3s
        fi
    fi

    if [[ "$NPM" == [yY] ]]; then
        echo "##########################################"
        echo "###     Install NGinX Proxy Manager    ###"
        echo "##########################################"
    
        # pull an nginx proxy manager docker-compose file from github
        echo "    1. Pulling a default NGinX Proxy Manager docker-compose.yml file."

        mkdir -p docker/nginx-proxy-manager
        cd docker/nginx-proxy-manager

        curl https://gitlab.com/bmcgonag/docker_installs/-/raw/main/docker_compose.nginx_proxy_manager.yml -o docker-compose.yml >> ~/docker-script-install.log 2>&1

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

echo ""
echo ""

clear

echo "Let's figure out which OS / Distro you are running."
echo ""
echo ""
echo "    From some basic information on your system, you appear to be running: "
echo "        --  OS Name        " $(lsb_release -i)
echo "        --  Description        " $(lsb_release -d)
echo "        --  OS Version        " $(lsb_release -r)
echo "        --  Code Name        " $(lsb_release -c)
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
