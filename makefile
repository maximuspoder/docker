all: build create_database install

build: ; docker-compose up -d

create_database: ; docker exec -it magento2_percona_1 mysql -uroot -proot -e "CREATE DATABASE IF NOT EXISTS LOJA_1; CREATE DATABASE IF NOT EXISTS LOJA_2; CREATE DATABASE IF NOT EXISTS LOJA_2;"

install: ; docker exec -it magento2_phpfpm_1 ./src/setup-mage.sh

phpfpm: ; docker exec -it magento2_phpfpm_1 /bin/sh

database: ; docker exec -it magento2_percona_1 mysql -uroot -proot

down: ; docker-compose down

up: ; docker-compose up

compile: ; docker exec -it magento2_phpfpm_1 php -dmemory_limit=5G /src/www/$(loja)/bin/magento setup:di:compile