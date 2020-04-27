# Magento 2 for Tests

Docker enviroment with phpfpm, nginx, percona, redis and Mailhog. 

Magento 2 with 3 extra stores for integrated tests

### Prerequisites

docker and docker-compose


### Installing
Primeiro é necessário configurar as variaveis de ambiente no arquivo .env

Para instalar usar o comando:

```
make build
```

Depois conectar-se ao bando de dados com o comando:

```
make database 
```

Por enquanto é necessário criar 3 banco de dados.

Os nomes devem ser compativeis com os nomes do .env se não for alterado criar usando "LOJA_1","LOJA_2" e "LOJA_3".

Depois usar o comando:

```
make install 
```
