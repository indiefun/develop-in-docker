# develop-in-docker
some Dockerfile and docker-compose.yml templates for development in docker

# usage:
* clone this repo
    ```
    git clone https://github.com/indiefun/develop-in-docker.git
    ```
* checkout your local branch, then modify files
    ```
    git checkout -b dev
    ```
* (optional) modify build args in docker-compose.yml, empty mean ignore install
    ```
    args:
        - NODE_MAJOR=20 # 16 18 20 21 or empty
        - PYTHON_MAJOR=3 # 2 3 or empty
        - JDK_MAJOR=17 # 8 11 17 18 19 20 21 or empty
        - ODOO_VERSION=16.0 # 16.0 or empty, only support 16.0 now
    ```
* (optional) modify ports in docker-compose.yml if 10022 port is in used
    ```
    ports:
        - 20022:22
    ```
* (optional) modify authorized_keys file path if not in ~/.ssh/authorized_keys
    ```
    volumes:
        - ~/.ssh/authorized_keys:/home/ubuntu/.ssh/authorized_keys:ro
    ```
* build image
    ```
    docker-compose build
    ```
* run up containers
    ```
    docker-compose up -d
    ```
* access use ssh connection in idea remote or vscode remote
    ```
    ssh ubuntu@localhost -p 10022
    ```
