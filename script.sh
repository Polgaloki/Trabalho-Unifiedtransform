#!/bin/bash

docker-compose up -d

echo -e "SHOW DATABASES;\n GRANT ALL ON unifiedtransform.* TO 'unifiedtransform'@'%' IDENTIFIED BY 'secret';\nFLUSH PRIVILEGES;" > comandos.sql

cat comandos.sql | docker exec -i db mysql -u root -p"your_mysql_root_password"

echo -e "composer install\nphp artisan key:generate\nphp artisan config:cache\nphp artisan migrate:fresh --seed" > composer

cat composer | docker exec -i app sh
