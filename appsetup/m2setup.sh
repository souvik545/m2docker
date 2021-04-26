composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition /var/www/html/
find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} +
find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} +
chmod u+x bin/magento
