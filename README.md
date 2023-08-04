<h1>"NGinX Proxy Manager"</h1>

With this script, you can automatically install NGinX Proxy Manager on Docker.

>**Note**: Without Docker and Docker-Compose it fails. [First install Docker and Docker-Compose from here](https://github.com/shawshanck/Docker-and-Docker-Compose).

<hr>
<h2>Web Interface:</h2>

**After installation:**

Navigate to your server hostname / IP address on port 81 to setup.

Example: 0.0.0.0:81

The default login credentials for NGinX Proxy Manager are:

username: admin@example.com

password: changeme

<hr>

<p align="center">
<img src="https://cdn-images.imagevenue.com/ec/41/26/ME16PV86_o.PNG" width="600">
<br>
<img src="https://cdn-images.imagevenue.com/6f/d9/e8/ME16PV88_o.PNG" width="600">
</p>

<hr>

```
mkdir docker && cd docker
wget https://raw.githubusercontent.com/shawshanck/NGinX-Proxy-Manager/main/install-npm.sh
chmod +x install-npm.sh
./install-npm.sh
```
