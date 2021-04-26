## Docker setup for dev environments

This project aims to create a development environment for Magento 2 with official base images.

### Containers
- Webserver + app : Runs Fedora 33/Apache 2/PHP 74 FPM/Magento 2 community.
- Elastic : Required by Magento 2 for catalog search.
- MySQL : Data persistence

### Description
<p>This project is a skeleton for me to remember the 10000 times I have had to create up Docker images with sligtly varying parameters. Additionally, this run the FPM and the web server in the same container.</p>

### Setup instructions

####Clone the repo to local and run

```angular2html
docker-compose up --build -d
```

Should everything go well, there will be 3 containers running as defined in the containers section. 
The most common issue at this stage, is port conflict. Check to see if any of the ports have apps already listening to it in your machine. The required ports [XXXX:] are defined in the docker-compose.yml.

####Get the Magento 2 code. 

Get your access keys for the application and use the auth.json file in the project. This file is utilized to connect to the Magento server to clone the corresponding repo.

Once done, run this script to fetch the code and setup permissions,

```angular2html
docker exec -it m2_webapp /bin/sh -c "m2setup.sh"
```

This will pull down the code under the m2app/ directory. Once this is complete, run the following code to install the application. A few things to remember, 
 - Both these snippets can be updated according to the requirement.
 - The install script also defines the application URL, or things like time zones or database information. Some of these are defined in the docker-compose and in other areas. So changing them would require changes to other parts.
 - There is an option to install Magento sample data, which is an additional switch to the install script. Make sure to add it before running install if that is something required.

```angular2html
docker exec -it m2_webapp /bin/sh -c "m2install.sh"
```

At this point, you should be able to go the specified URL (make sure to add the URL to hosts), and see the default Magento home page.

### Customizations

#### Apache
 - docker/apache/httpd.conf : any customizations to the main Apache config can be made here. This is copied over everytime the container builds.
 - docker/apache/magento2.conf : specific to magento 2

#### PHP
 - docker/php/custom.ini : any custom PHP configurations can be added here, will be copied over at the next build

#### APP
 - docker/app/Dockerfile : main Dockerfile, can be used to add preload the webapp with any required tool.

#### Common
 - supervisor : can be used to add additional services to the webapp container.

#### Troubleshooting

### Permissions
 - MAGE_ROOT_DIR/var/cache and /page_cache : Both these folders will require Apache user read/write access for the app to work.

### Logging
 - webserver/logs : The logs here can be utilized to track any Apache related errors.
 - m2app/var/log : Application specific logs.
 - /var/php-fpm/www-* : This log is not exposed or symlinked, as once setup FPM logs should not be something a dev needs to monitor on a daily basis. If there are issues with setting up, exec into the webapp container to see if there is anything in the log. 
