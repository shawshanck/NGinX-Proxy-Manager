<h1>"NGinX Proxy Manager"</h1>

With this script, you can automatically install NGinX Proxy Manager on Docker.

>**Note**: Without Docker and Docker-Compose it fails. [First install Docker and Docker-Compose from here](https://github.com/shawshanck/Docker-and-Docker-Compose).


<h2>Web Interface:</h2>

**After installation:**

Navigate to your server hostname / IP address on port 81 to setup.

Example: 0.0.0.0:81

The default login credentials for NGinX Proxy Manager are:

username: admin@example.com

password: changeme


```
mkdir docker && cd docker
wget https://raw.githubusercontent.com/shawshanck/NGinX-Proxy-Manager/main/install-npm.sh
chmod +x install-npm.sh
./install-npm.sh
```
